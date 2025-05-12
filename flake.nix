{

	description = "Base flake for my NixOS system";

	inputs = {
		nixpkgs.url = "nixpkgs/nixos-unstable";
		
		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		self.submodules = true;
	};

	outputs = {self, nixpkgs, home-manager, ...} @ inputs:
		let
			lib = nixpkgs.lib;
		in {
			nixosConfigurations = {
				ropptar-XPS-13-9310 = lib.nixosSystem {
					specialArgs = {inherit self;};
					system = "x86_64-linux";
					modules = [
						./profiles/desktop/home/configuration.nix
						home-manager.nixosModules.home-manager
						{
							home-manager.extraSpecialArgs = {inherit self;};
							home-manager.useUserPackages = true;
							home-manager.useGlobalPkgs = true;
							home-manager.backupFileExtension = "backup";
							home-manager.users.ropptar = import profiles/desktop/home/home.nix;
						}
					];
				};
			};
		};

}
