{

	description = "Base flake for my NixOS system";

	inputs = {
		nixpkgs.url = "nixpkgs/nixos-unstable";
		
		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = {nixpkgs, home-manager, ...} @ inputs:
		let
			lib = nixpkgs.lib;
		in {
			nixosConfigurations = {
				ropptar-XPS-13-9310 = lib.nixosSystem {
					#extraSpecialArgs = {inherit inputs;};
					system = "x86_64-linux";
					modules = [
						./configuration.nix
						home-manager.nixosModules.default
					];
				};
			};
		};

}
