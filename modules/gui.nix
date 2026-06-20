{
  config,
  pkgs,
  inputs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    walker
    elephant
    hyprlock
    hyprpaper
    waybar
    tuigreet
  ];

}
