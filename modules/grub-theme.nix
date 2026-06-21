{
  theme ? "mojave",
  type ? "float",
  side ? "left",
  color ? "dark",
  screen ? "2k",
  logo ? "Default",
}:

{ config, pkgs, ... }:

let
  fontSizes = {
    "1080p" = "16";
    "2k" = "24";
    "4k" = "32";
  };
  fontSize = fontSizes.${screen} or "24";

  elegant-grub-theme = pkgs.stdenv.mkDerivation {
    pname = "elegant-grub2-themes";
    version = "unstable-2025-06-21";

    src = pkgs.fetchFromGitHub {
      owner = "vinceliuice";
      repo = "Elegant-grub2-themes";
      rev = "92cdac334cf7bc5c1d68c2fbb266164653b4b502";
      hash = "sha256-fbZLWHxnLBrqBrS2MnM2G08HgEM2dmZvitiCERie0Cc=";
    };

    nativeBuildInputs = [ pkgs.coreutils ];

    installPhase = ''
      mkdir -p $out/icons

      cp "$src/common/terminus"*.pf2 "$out/"
      cp "$src/common/unifont-${fontSize}.pf2" "$out/"

      cp "$src/backgrounds/backgrounds-${theme}/background-${theme}-${type}-${side}-${color}.jpg" "$out/background.jpg"

      cp -r "$src/assets/assets-icons-${color}/icons-${color}-${screen}/"* "$out/icons/"

    '' + (if type == "blur" then ''
      cp "$src/config/theme-sharp-${side}-${color}-${screen}.txt" "$out/theme.txt"
      cp "$src/assets/assets-other/other-${screen}/select_e-white.png" "$out/select_e.png"
      cp "$src/assets/assets-other/other-${screen}/select_c-white.png" "$out/select_c.png"
      cp "$src/assets/assets-other/other-${screen}/select_w-white.png" "$out/select_w.png"
    '' else ''
      cp "$src/config/theme-${type}-${side}-${color}-${screen}.txt" "$out/theme.txt"
      cp "$src/assets/assets-other/other-${screen}/select_e-${theme}-${color}.png" "$out/select_e.png"
      cp "$src/assets/assets-other/other-${screen}/select_c-${theme}-${color}.png" "$out/select_c.png"
      cp "$src/assets/assets-other/other-${screen}/select_w-${theme}-${color}.png" "$out/select_w.png"
    '') + ''

    '' + (if theme == "forest" then ''
      cp "$src/assets/assets-other/other-${screen}/${if type == "blur" then "sharp" else type}-${side}-alt.png" "$out/info.png"
    '' else ''
      cp "$src/assets/assets-other/other-${screen}/${if type == "blur" then "sharp" else type}-${side}.png" "$out/info.png"
    '') + ''

      if [ -f "$src/assets/assets-other/other-${screen}/${logo}.png" ]; then
        cp "$src/assets/assets-other/other-${screen}/${logo}.png" "$out/logo.png"
      else
        cp "$src/assets/assets-other/other-${screen}/Default.png" "$out/logo.png"
      fi
    '';
  };
in
{
  boot.loader.grub.theme = elegant-grub-theme;
}
