{ pkgs, self, ... }: 
let
	flakeRoot = ./../../..;
	dotfilesRoot = flakeRoot + /dotfiles;
in
{
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
			".bashrc" = {
				source = ./../../../dotfiles/.bashrc;
			};
			".config/hypr" = {
				source = ./../../../dotfiles/hypr;
			};
		};	
	};
	
	programs = {
		home-manager.enable = true;

		
		git = {
			enable = true;
			userName = "Alexander";
			userEmail = "ropptar@ya.ru";
			extraConfig = {
				merge = {
					tool = "meld";
				};
			};
		};

		foot = {
			enable = true;
			settings = {
				main = {
					font = "Hack Nerd Font:size=16";
				};
				colors = {
					background="282828";
					foreground="ebdbb2";
					regular0="282828";
					regular1="cc241d";
					regular2="98971a";
					regular3="d79921";
					regular4="458588";
					regular5="b16286";
					regular6="689d6a";
					regular7="a89984";
					bright0="928374";
					bright1="fb4934";
					bright2="b8bb26";
					bright3="fabd2f";
					bright4="83a598";
					bright5="d3869b";
					bright6="8ec07c";
					bright7="ebdbb2";
				};
			};
		};

	};
}

