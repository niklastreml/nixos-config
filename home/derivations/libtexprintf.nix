{
  pkgs ? import <nixpkgs> { },
}:

pkgs.stdenv.mkDerivation rec {
  pname = "libtexprintf";
  version = "1.31";

  src = pkgs.fetchzip {
    url = "https://github.com/bartp5/libtexprintf/releases/download/v${version}/libtexprintf-${version}.tar.gz";
    hash = "sha256-SmMTGCX4eCGAWC5Ej5Ke+9GOK6QyZ7OqDHsF9Tyiq4U=";
  };

  nativeBuildInputs = with pkgs; [
    autoreconfHook
  ];
}
