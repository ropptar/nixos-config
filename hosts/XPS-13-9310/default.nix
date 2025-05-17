{ self, lib, pkgs, inputs, ... }:
let
	flakeRoot = self;
in
{
	imports =
		[
			./hardware-configuration.nix
			#inputs.home-manager.nixosModules.default
		];
	

	nixpkgs.config.allowUnfree = true;

	nix.settings.experimental-features = [ "nix-command" "flakes" ];

	boot = {
		kernelPackages = pkgs.linuxPackages_zen;
	
		loader = {
			systemd-boot = {
				enable = true;
				consoleMode = "2";
			};
			efi.canTouchEfiVariables = true;
	  	};
	};
	
	networking = {
		hostName = "XPS-13-9310"; 
		networkmanager.enable = true;  
		firewall.enable = false;
	};
	
	time.timeZone = "Europe/Moscow";
	
	services = {
		displayManager.ly.enable = true;

		printing.enable = true;
		
		pipewire = {
		  enable = true;
		  pulse.enable = true;
		};
		
		libinput.enable = true;
		
		openssh.enable = true;

	};
	
	users.users.ropptar = {
		isNormalUser = true;
		extraGroups = [ "wheel" "input" "networkmanager" ];
		# for user-level packages, use home-manager
	};
	
	programs = {
		hyprland = {
		  enable = true;
		};
		
		bash.shellAliases.rebash = "source ~/dotfiles/.bashrc";
	};
	
	environment = {
		systemPackages = with pkgs; [
			# Terminal tools
			tmux
			bat
			wget
			# Tools
			git
			gh
			thefuck
			# Other
			tree
			# DM
			ly
			# Editor
			vim
			# Hyprland
			wl-clipboard
		];
		
		variables = {
			EDITOR = "vim";
			VISUAL = "nvim";
		};
	};
	
	fonts = {
		packages = with pkgs; [
			# (nerdfonts.override { fonts = [ "Hack" ]; }) # (STABLE CHANNEL)
			nerd-fonts.hack # (UNSTABLE CHANNEL)
			noto-fonts-emoji
		];
		
		fontconfig = {
			defaultFonts = {
				serif = [ "Hack Nerd Font Regular" "Noto Color Emoji"];
				monospace = [ "Hack Nerd Font Mono" "Noto Color Emoji" ];
			};
		};
	};
	
	system.stateVersion = "24.11";

}

