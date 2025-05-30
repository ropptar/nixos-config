{ pkgs, self, lib, ... }: 
{
	imports = [
		./programs
		./hyprland
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
			nemo

			# Social
			telegram-desktop

			# Misc
			spotify
			pfetch
			tealdeer
		];

		file = {
			".bashrc".source = ./../dotfiles/.bashrc;
			".config/bash".source = ./../dotfiles/bash;
			".config/hypr".source = ./../dotfiles/hypr;
		};	
	};

	programs.home-manager.enable = true;
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

