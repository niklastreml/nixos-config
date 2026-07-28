{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    gcc
    gnumake
    go
    python315
    uv
    gomplate
  ];
}
