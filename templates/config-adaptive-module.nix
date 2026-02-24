{ config, pkgs, lib, ... }:

#example module that parses selected options and works for both tools: NixOS system ad home-manager

let
  cfg = config.roles.category.field;
  isNixOS = builtins.hasAttr "system" config;
in
{
  imports = lib.optionals (cfg.enable) [
    ./module.nix
  ];

  config = lib.mkIf cfg.enable
    (lib.mkMerge [
      (lib.mkIf isNixOS {
        #NixOS module settings
      })

      (lib.mkIf (!isNixOS) {
        #HM standalone settings
      })
    ];
    }
