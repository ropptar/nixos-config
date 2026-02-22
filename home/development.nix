{ pkgs, ... }:

{
  programs = {
    git = {
      enable = true;
      lfs.enable = true;
      settings = {
        user = {
          name = "Alexander L";
          email = "ropptar@ya.ru";
        };

        init.defaultbranch = "master";
        url."https://github.com/".insteadOf = [ "ghttp:" ];
        url."git@github.com:".insteadOf = [ "gssh:" ];
      };
    };

    vscode = {
      enable = true;
      package = pkgs.vscodium;

      profiles.default = {
        userSettings = {
          "workbench.colorTheme" = "Gruvbox Dark Medium";
          "workbench.iconTheme" = "material-icon-theme";

          "editor.fontFamily" = "'Hack Nerd Font', 'monospace'";
          "editor.fontLigatures" = true;
          "editor.fontSize" = 14;
          "editor.lineHeight" = 22;
          "editor.renderWhitespace" = "boundary";
          "editor.bracketPairColorization.enabled" = true;
          "editor.guides.bracketPairs" = "active";

          "editor.formatOnSave" = true;
          "editor.codeActionsOnSave" = {
            "source.fixAll" = true;
            "source.organizeImports" = true;
          };
          "files.autoSave" = "onWindowChange";
          "extensions.autoCheckUpdates" = false;
          "extensions.autoUpdate" = false;
          "update.mode" = "none";

          "C_Cpp.clang_format_style" = "file";
          "C_Cpp.autocomplete" = "default";
          "C_Cpp.errorSquiggles" = "enabled";
          "C_Cpp.default.includePath" = [
            "${pkgs.glibc.dev}/include"
            "/usr/include"
          ];
          "C_Cpp.default.compilerPath" = "${pkgs.gcc}/bin/gcc";
          "C_Cpp.default.cStandard" = "c17";
          "C_Cpp.default.cppStandard" = "c++17";

          "cmake.configureOnOpen" = true;
          "cmake.buildDirectory" = "\${workspaceFolder}/build";
          "cmake.generator" = "Ninja";

          "python.defaultInterpreterPath" = "${pkgs.python311}/bin/python";
          "python.terminal.activateEnvironment" = true;
          "python.linting.enabled" = true;
          "python.linting.pylintEnabled" = true;
          "python.linting.pylintPath" = "${pkgs.pylint}/bin/pylint";
          "python.formatting.provider" = "black";
          "python.formatting.blackPath" = "${pkgs.black}/bin/black";

          "nix.enableLanguageServer" = true;
          "nix.serverPath" = "${pkgs.nixd}/bin/nixd";
          "nix.serverSettings" = {
            "nixd" = {
              "formatting" = {
                "command" = [ "${pkgs.nixpkgs-fmt}/bin/nixpkgs-fmt" ];
              };
              "options" = {
                "nixos" = {
                  "expr" = "(builtins.getFlake \"../../\").nixosConfigurations.blackno1.options";
                };
                "home-manager" = {
                  "expr" = "(builtins.getFlake \"../../\").homeConfigurations.ropptar.options";
                };
              };
            };
          };
        };

        extensions = with pkgs.vscode-extensions; [
          jnoortheen.nix-ide
          bbenoist.nix

          ms-vscode.cpptools
          ms-vscode.cmake-tools
          twxs.cmake

          ms-python.python
          ms-python.debugpy

          jdinhlife.gruvbox
          pkief.material-icon-theme
          #asvetliakov.vscode-neovim
        ];
      };
    };
  };
}                                               	
