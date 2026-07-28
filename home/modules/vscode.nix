{ pkgs, ... }: {
  home.packages = [ pkgs.vscode ];

  programs.vscode = {
    enable = true;
    mutableExtensionsDir = true;

    profiles.default = {
      userSettings = {
        "extensions.autoUpdate" = false;
        "extensions.autoCheckUpdates" = false;
        "workbench.sideBar.location" = "right";
        "workbench.iconTheme" = "material-icon-theme";
      };

      extensions =
        with pkgs.vscode-extensions;
        [
          bbenoist.nix
          vscodevim.vim
          pkief.material-icon-theme
          danielgavin.ols
          ziglang.vscode-zig
          rust-lang.rust-analyzer
          vadimcn.vscode-lldb
          ms-vscode.hexeditor
        ]
        ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
          {
            name = "Go";
            publisher = "golang";
            version = "0.54.0";
            sha256 = "sha256-o1SJjR6eQcGWN9BGoN5CBTdn6RsNG2a0+p/ZDcywzr0=";
          }
        ];
    };
  };
}
