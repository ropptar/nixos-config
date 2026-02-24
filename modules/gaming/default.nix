{ config, pkgs, lib, ... }:

let
  cfg = config.roles.gaming;
  isNixOS = builtins.hasAttr "system" config;
in
{
  imports = lib.optionals (cfg.enable) [
    ./steam.nix
  ];
  config = lib.mkIf cfg.enable (lib.mkMerge [
    (lib.mkIf isNixOS {
      hardware.graphics.enable32Bit = true;
      boot.kernelParams = [ "threadirqs" "mitigations=off" ];
      services.udev.packages = [ pkgs.game-devices-udev-rules ];
    })

    (lib.mkIf (!isNixOS) {
      programs.mangohud = {
        enable = true;
        #settings = {};
      };
    })
  ]);
}
