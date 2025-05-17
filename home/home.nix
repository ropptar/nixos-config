{ pkgs, self, lib, ... }: 
let
	flakeRoot = ./../../..;
	dotfilesRoot = flakeRoot + /dotfiles;
in
{
	imports = [
		./programs/main.nix
	];
	home = {
		username = "ropptar";
		homeDirectory = "/home/ropptar";
		stateVersion = "24.11";
		
		packages = with pkgs; [
			# Dev
			sourcegit
			meld

			# Tools
			fuzzel
			btop
			grim
			slurp
			flatpak

			# Apps
			librewolf
			nemo

			# Social
			telegram-desktop

			# Misc
			spotify
			pfetch
			tealdeer
		];

		file = {
			".bashrc".source = ./../../../dotfiles/.bashrc;
			".config/hypr".source = ./../../../dotfiles/hypr;
		};	
	};
	# gtk = {
	# 	enable = true;

	# 	theme = {
	# 		name = "Gruvbox";
	# 		package = lib.mkDefault pkgs.gruvbox-gtk-theme;
	# 	};
	# 	iconTheme = {
	# 		name = "Gruvbox-Plus-Icons";
	# 		package = lib.mkDefault pkgs.gruvbox-plus-icons;		
	# 	};
	# };
	# qt = {
	# 	enable = true;
	# 	platformTheme = "gtk";
	# };
}

