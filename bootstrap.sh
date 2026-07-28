#!/usr/bin/env bash
#
# Bootstrap this NixOS config on a machine: clone the repo and run
# `nixos-rebuild boot` for the selected host.
#
# Usage: bootstrap.sh [-b|--branch <branch>] [-d|--dir <path>] [-h|--help] [host]
#
#   host            NixOS host to build (default: $(hostname))
#   -b, --branch    branch/tag/commit to check out (default: $BRANCH or master)
#   -d, --dir       clone target directory (default: $TARGET_DIR or ~/code/nixos-config)
#
# Env overrides: REPO_URL, BRANCH, TARGET_DIR.

set -euo pipefail

REPO_URL="${REPO_URL:-https://github.com/niklastreml/nixos-config}"
BRANCH="${BRANCH:-master}"
TARGET_DIR="${TARGET_DIR:-$HOME/code/nixos-config}"
HOST=""

# Flags so we don't depend on flakes being enabled in /etc/nix/nix.conf.
NIX_FLAGS=(--extra-experimental-features 'nix-command flakes')

usage() {
	sed -n '3,12p' "$0" | sed 's/^# \{0,1\}//'
}

die() {
	echo "bootstrap: $*" >&2
	exit 1
}

# --- parse args (flags may come before or after the positional host) --------
while [[ $# -gt 0 ]]; do
	case "$1" in
	-b | --branch)
		[[ $# -ge 2 ]] || die "$1 requires an argument"
		BRANCH="$2"
		shift 2
		;;
	-d | --dir)
		[[ $# -ge 2 ]] || die "$1 requires an argument"
		TARGET_DIR="$2"
		shift 2
		;;
	-h | --help)
		usage
		exit 0
		;;
	-*)
		usage >&2
		die "unknown option: $1"
		;;
	*)
		[[ -z "$HOST" ]] || die "unexpected extra argument: $1"
		HOST="$1"
		shift
		;;
	esac
done

HOST="${HOST:-$(hostname)}"

# --- preflight --------------------------------------------------------------
[[ "$(id -u)" -ne 0 ]] || die "do not run as root; the repo should be owned by your user (sudo is used only for the rebuild)"

command -v nix >/dev/null 2>&1 || die "nix not found on PATH; run this from a NixOS installer or a machine with Nix installed"

# git may be absent on a bare installer ISO; fall back to a throwaway nix shell.
git() {
    nix "${NIX_FLAGS[@]}" shell nixpkgs#git -c git "$@"
}

# nh may also be absent on a fresh Nix install; fall back to a throwaway nix shell.
# The internal nix calls spawned by nh also need --extra-experimental-features, so
# we set it via NIX_CONFIG which nh forwards into its subprocesses.
nh() {
    NIX_CONFIG="extra-experimental-features = nix-command flakes" \
        nix "${NIX_FLAGS[@]}" shell nixpkgs#nh -c nh "$@"
}

# --- clone or update --------------------------------------------------------
if [[ -d "$TARGET_DIR/.git" ]]; then
	echo "bootstrap: updating existing checkout at $TARGET_DIR"
	git -C "$TARGET_DIR" fetch origin
	git -C "$TARGET_DIR" checkout "$BRANCH"
	# Fast-forward only when tracking a branch; detached tags/commits have no upstream.
	if git -C "$TARGET_DIR" rev-parse --abbrev-ref --symbolic-full-name '@{u}' >/dev/null 2>&1; then
		git -C "$TARGET_DIR" pull --ff-only
	fi
else
	echo "bootstrap: cloning $REPO_URL ($BRANCH) into $TARGET_DIR"
	mkdir -p "$(dirname "$TARGET_DIR")"
	git clone --branch "$BRANCH" "$REPO_URL" "$TARGET_DIR"
fi

# --- host validation (against the checked-out branch) -----------------------
if [[ ! -f "$TARGET_DIR/hosts/$HOST/nixos.nix" ]]; then
	echo "bootstrap: no NixOS host '$HOST' on branch '$BRANCH'." >&2
	echo "Available hosts:" >&2
	for d in "$TARGET_DIR"/hosts/*/; do
		[[ -f "$d/nixos.nix" ]] && echo "  - $(basename "$d")" >&2
	done
	exit 1
fi

if [[ ! -f "$TARGET_DIR/hosts/$HOST/hardware-configuration.nix" ]]; then
	die "hosts/$HOST/hardware-configuration.nix is missing; generate it first with: nixos-generate-config --show-hardware-config > $TARGET_DIR/hosts/$HOST/hardware-configuration.nix"
fi

# --- rebuild ----------------------------------------------------------------
echo "bootstrap: building host '$HOST' (branch '$BRANCH') with nh os boot"
nh os boot "$TARGET_DIR" -H "$HOST" --accept-flake-config

cat <<EOF

bootstrap: done. Host '$HOST' from branch '$BRANCH' is staged as the next boot generation.
Reboot to activate it.

The repo was cloned over HTTPS (read-only). For push access, switch the remote to SSH:
  git -C "$TARGET_DIR" remote set-url origin git@github.com:niklastreml/nixos-config
EOF
