{ config, pkgs, ... }:

{
	home.packages = with pkgs; [
		gamescope
		steam
	];	
}
