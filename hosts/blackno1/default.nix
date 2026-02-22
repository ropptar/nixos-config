{ inputs, ... }:

{
	imports = [
		./hardware-configuration.nix
		./system.nix
		../../system
	];
}
