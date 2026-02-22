{
	description = "Base flake for my NixOS system";

	inputs = {
		nixpkgs.url = "nixpkgs/nixos-unstable";
		
		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		nur = {
			url = "github:nix-community/NUR";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		firefox-addons = {
    	  		url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
    	  		inputs.nixpkgs.follows = "nixpkgs";
    		};	

		self.submodules = true;
	};

	outputs = {self, nixpkgs, home-manager, firefox-addons, nur, ...}@inputs:
	let
		homeConfig = { username ? "ropptar" }: {
			
			home-manager = {
				useGlobalPkgs = true;
				useUserPackages = true;
				extraSpecialArgs = { inherit inputs firefox-addons; };
				
				users.ropptar =  ./home;
			};
		};

		hostConfig = { hostname, system ? "x86_64-linux", username ? "ropptar" }: 
			nixpkgs.lib.nixosSystem {
				inherit system;
				specialArgs = { inherit inputs; };
				modules = [
					./hosts/${hostname}
					{
						networking.hostName = hostname;	
						users.users.${username} = {
							isNormalUser = true;
							home = "/home/${username}";
						};
					}
					home-manager.nixosModules.home-manager
					( homeConfig { username=username; })

					{ nixpkgs.overlays = [ inputs.nur.overlays.default ]; }
				];
			};
	in {
		nixosConfigurations = {
			blackno1 = hostConfig { hostname = "blackno1"; };
		};

		homeConfigurations.ropptar = home-manager.lib.homeConfiguration {
			pkgs = nixpkgs.legacyPackages.x86_64-linux;
			extraSpecialArgs = { inherit inputs firefox-addons; };
			modules = [ ./home ];
		};
	};
}
