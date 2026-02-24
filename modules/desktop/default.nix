{ config, pkgs, lib, ... }:

let
  cfg = config.roles.gaming;
in
{
	imports = lib.optionals (cfg.enable) [
		./steam.nix
	];
}
