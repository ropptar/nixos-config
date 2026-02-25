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

  outputs = { self, nixpkgs, home-manager, firefox-addons, nur, ... }@inputs:
    let
      pkgsFor = system: import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [ nur.overlays.default ];
      };

      baseModules = [
        ./options.nix
        ./modules
      ];

      mkHome = { hostname, system ? "x86_64-linux", username ? "ropptar" }:
        home-manager.lib.homeManagerConfiguration {
          pkgs = pkgsFor system;
          extraSpecialArgs = {
            inherit inputs firefox-addons;
            inherit hostname username;
          };
          modules = baseModules ++ [
            ./hosts/${hostname}/roles.nix
            {
              home.username = "${username}";
              home.homeDirectory = "/home/${username}";
            }
          ];
        };

      mkHost = { hostname, system ? "x86_64-linux", username ? "ropptar" }:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = baseModules ++ [
            ./hosts/${hostname}
            {
              nixpkgs.pkgs = import inputs.nixpkgs{
                #inherit (nixpkgs.lib) system;
                config.allowUnfree = true;
                overlays = [ inputs.nur.overlays.default ];
              };
              networking.hostName = hostname;
              users.users.${username} = {
                isNormalUser = true;
                home = "/home/${username}";
                extraGroups = [ "wheel" "networkmanager" "input" "video" "audio" ];
              };
            }
          ];
        };
    in
    {
      nixosConfigurations = {
        blackno1 = mkHost { hostname = "blackno1"; };
      };

      homeConfigurations = {
        "ropptar@blackno1" = mkHome {
          hostname = "blackno1";
        };

        "ropptar@angryinch" = mkHome {
          hostname = "angryinch";
        };
      };
    };
}
