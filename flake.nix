{
	description = "Base flake for my NixOS system";

	inputs = {
		nixpkgs.url = "nixpkgs/nixos-unstable";
		
		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";

		};

		nixos-hardware.url = "github:NixOS/nixos-hardware/master";

		hm-librewolf-module = {
			url = "github:nix-community/home-manager?ref=pull/5684/head";
			flake = false;
		};


		self.submodules = true;
	};

	outputs = {self, nixpkgs, home-manager, nixos-hardware, ...} @ inputs:
	let
		lib = nixpkgs.lib;
	in {
		nixosConfigurations = {
			XPS-13-9310 = lib.nixosSystem {
				specialArgs = {inherit self;};
				system = "x86_64-linux";
				modules = [
					./hosts/XPS-13-9310
					nixos-hardware.nixosModules.dell-xps-13-9310
					home-manager.nixosModules.home-manager
					{
						home-manager.extraSpecialArgs = {inherit self;};
						home-manager.useUserPackages = true;
						home-manager.useGlobalPkgs = true;
						home-manager.backupFileExtension = "backup";
						home-manager.users.ropptar = import ./home/home.nix;
					}
				];
			};
		};
	};
}
