# nixos-config

Personal NixOS + Home Manager configuration for all of my machines, organised
around **features** rather than a NixOS/Home Manager split.

A feature bundles everything needed for one capability — system packages,
services, and user dotfiles — behind a single toggle. A host turns a feature on
with `myFeatures.<name>.enable = true`, and both its system and home layers come
along together.

## Hosts

| Host      | Type                        | System        | Notes                              |
| --------- | --------------------------- | ------------- | ---------------------------------- |
| `desktop` | NixOS (integrated HM)       | x86_64-linux  | Hyprland workstation, NVIDIA       |
| `laptop`  | NixOS (integrated HM)       | x86_64-linux  | Hyprland, cherry-picked work bits  |
| `vm`      | NixOS (integrated HM)       | x86_64-linux  | QEMU guest                         |
| `wsl`     | NixOS (integrated HM)       | x86_64-linux  | WSL, full work host                |
| `macbook` | standalone Home Manager     | aarch64-darwin | no NixOS layer                    |

## Bootstrap

On a fresh NixOS machine, clone this repo and stage the host config as the next
boot generation in one line:

```sh
curl -sSfL https://raw.githubusercontent.com/niklastreml/nixos-config/master/bootstrap.sh | bash -s -- desktop
```

To try an in-progress branch, point both the fetched script and the `-b` flag at
it:

```sh
curl -sSfL https://raw.githubusercontent.com/niklastreml/nixos-config/<branch>/bootstrap.sh | bash -s -- -b <branch> desktop
```

The script clones over HTTPS into `~/code/nixos-config` and runs
`nixos-rebuild boot`, so **reboot to activate** the result. Options:

- **host** — positional, defaults to `$(hostname)`.
- `-b, --branch` — branch/tag/commit to check out (default `master`).
- `-d, --dir` — clone target (default `~/code/nixos-config`).
- Env overrides: `REPO_URL`, `BRANCH`, `TARGET_DIR`.

Re-running is idempotent: an existing checkout is fetched and switched to the
requested branch in place. Hosts that enable the `work` feature additionally need
SSH access to the internal Telekom GitLab (see [Requirements](#requirements)).

## Layout

```
flake.nix              # entry point: mkHost / mkHome, feature aggregation, HM bridge
lib/features.nix       # auto-discovers features/ and feeds each layer to the right eval
system/
  core.nix             # always-on base system (locale, users, nix, base CLI pkgs)
  grub-theme.nix       # parametric GRUB theme helper (host-specific)
home/
  core.nix             # always-on base home config (username, stateVersion, nixvim)
  nix-your-shell.nix
features/
  <name>/
    options.nix        # declares myFeatures.<name>.enable
    nixos.nix          # system layer   (optional), gated by the toggle
    home.nix           # home layer     (optional), gated by the toggle
    <supporting files> # assets, derivations, etc.
hosts/
  <name>/
    nixos.nix          # NixOS hosts: enables features + host-specific system config
    home.nix           # host-specific home tweaks (monitors, etc.)
    hardware-configuration.nix
  macbook/
    home.nix           # standalone host: sets myFeatures.*.enable directly
assets/                # wallpaper, avatar
```

## How it works

Every feature is imported into every host. Each feature's config is wrapped in
`lib.mkIf config.myFeatures.<name>.enable`, so features a host doesn't enable are
inert. Hosts opt in by flipping toggles — typically with `lib.genAttrs`:

```nix
myFeatures = lib.genAttrs [ "hyprland" "steam" "usb" "git" ... ] (_: { enable = true; });
```

Because NixOS and Home Manager are separate module evaluations, a feature's two
layers live in separate files (`nixos.nix` / `home.nix`) but share one toggle.
On integrated hosts the flake **bridges** the NixOS-level toggles into Home
Manager (`home-manager.users.ntreml.myFeatures = config.myFeatures`), so a single
`myFeatures.<name>.enable = true` drives both layers. The standalone `macbook`
host has no NixOS layer, so it sets the toggles directly in its `home.nix`.

`lib/features.nix` discovers features automatically via `builtins.readDir` —
**adding a feature is just a new directory under `features/`**, no registration
needed. Features whose `home.nix` imports a non-darwin-safe upstream module (e.g.
`noctalia`) are listed in `linuxOnlyFeatures` in the flake so they are skipped on
`macbook`.

## Features

Feature layers (`nixos` = system, `home` = user):

| Feature | Layers | | Feature | Layers |
| --- | --- | --- | --- | --- |
| `audio` | nixos | | `neovim` | nixos + home |
| `bluetooth` | nixos | | `hyprland` | nixos + home |
| `docker` | nixos | | `usb` | nixos + home |
| `networkmanager` | nixos | | `work` | nixos + home |
| `steam` | nixos | | | |
| `wifi` | nixos | | | |
| `aerospace` | home | | `obsidian` | home |
| `browser` | home | | `opencode` | home |
| `direnv` | home | | `packages-cli` | home |
| `discord` | home | | `packages-gui` | home |
| `eduroam` | home | | `starship` | home |
| `fish` | home | | `stylix` | home |
| `git` | home | | `tmux` | home |
| `noctalia` | home (linux-only) | | `vscode` | home |

Small CLI tools whose only configuration is enabling their Home Manager module
(`rbw`, `btop`, `fzf`, `k9s`) live directly in the `packages-cli` feature rather
than as standalone features.

### The `work` feature

`work` is a composite feature: a master `myFeatures.work.enable` switch plus
per-concern sub-toggles that **default to the master switch**. This lets a host
either enable everything (`work.enable = true`) or cherry-pick individual bits on
an otherwise-personal machine.

| Sub-toggle | What it enables |
| --- | --- |
| `work.packages.enable` | Go/Python/C toolchain, `uv`, `gomplate`, `GOPRIVATE` |
| `work.git.enable` | Telekom git identity for repos under `~/work/` |
| `work.glab.enable` | `glab` CLI |
| `work.skills.enable` | internal GitLab skills merged into opencode |
| `work.telecontext.enable` | telecontext MCP server for opencode |
| `work.opencode.enable` | opencode read access to `~/work` |
| `work.network.enable` | Telekom proxy, nameservers, SSH ProxyCommand |

`wsl` sets `work.enable = true` (all of the above); `laptop` cherry-picks
`git` + `glab` + `opencode`.

## Usage

Build (dry-run, no activation):

```sh
# NixOS host
nixos-rebuild build --flake .#desktop

# standalone Home Manager (macbook)
nix build .#homeConfigurations."ntreml@macbook".activationPackage
```

Switch:

```sh
# NixOS hosts (rolls out system + this host's home config together)
sudo nixos-rebuild switch --flake .#desktop

# macbook
home-manager switch --flake .#"ntreml@macbook"
```

`nh` is configured with `FLAKE` on the NixOS hosts, so `nh os switch` works from
anywhere in the tree.

### Adding a feature

1. `mkdir features/<name>`
2. `features/<name>/options.nix`:
   ```nix
   { lib, ... }:
   { options.myFeatures.<name>.enable = lib.mkEnableOption "<name>"; }
   ```
3. Add `nixos.nix` and/or `home.nix`, each wrapping its body in
   `lib.mkIf config.myFeatures.<name>.enable { ... }`.
4. Enable it on a host by adding `"<name>"` to that host's feature list.

## Requirements

Flakes and `nix-command` must be enabled. Some inputs (work skills) require SSH
access to the internal Telekom GitLab; `noctalia` pulls from its own Cachix
substituter, configured in `flake.nix`.

`bootstrap.sh` passes `--extra-experimental-features 'nix-command flakes'` on
every invocation, so it works even on a stock installer where flakes are not yet
enabled system-wide.
