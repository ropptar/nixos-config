{ config, pkgs, lib, username, ... }:

let
  cfg = config.roles.gaming;
  steamCfg = cfg.steam;
  isNixOS = builtins.hasAttr "system" config;
  isHome = builtins.hasAttr "home" config;
  isOtherOS = isHome && !isNixOS;
in
{
  config = lib.mkIf steamCfg.enable
    (lib.mkMerge [
      (lib.mkIf isNixOS {
        programs.steam = {
          enable = true;
          localNetworkGameTransfers.openFirewall = true;
          gamescopeSession.enable = steamCfg.gamescope.enable;
          extraCompatPackages = cfg.extraCompatPackages;
        };
        programs.gamescope.enable = steamCfg.gamescope.enable;
      })

      (lib.mkIf isHome {
        home-manager.users.${username}.home.file.".local/bin/steam-run" = {
          text = ''
            #!/bin/sh
            ${lib.optionalString cfg.gamemoded.enable "gamemoderun"}
            ${lib.optionalString steamCfg.gamescope.enable "gamescope --"}
            steam "$@"
          '';
          executable = true;
        };
      })

      (lib.mkIf isOtherOS {
        home.pkgs = with pkgs; [ steam ]
          ++ lib.optionals cfg.gamescope.enable [ gamescope ];
      })
    ]);
}
