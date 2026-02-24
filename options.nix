{ lib, pkgs, ... }:

let
  inherit (lib) optEnable optStr optInt optList;
in
{
  options.roles = {
    dev.enable = optEnable "development tools";

    gaming = {
      enable = optEnable "gaming software";
      steam = {
        enable = optEnable "Steam launcher";
        beta = optEnable "Steam beta branch";
        gamescope = optEnable "gamescope compositor";
        extraCompatPackages = optList "pkg" [ pkgs.proton-ge-bin ];
      };
      heroic = {
        enable = optEnable "Heroic launcher";
      };
      gamemoded = optEnable "gamemoded daemon";
    };

    media.enable = optEnable "browsing and media suite";
    office.enable = optEnable "office tools";
  };
}
