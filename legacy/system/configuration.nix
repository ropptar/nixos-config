{ pkgs, ... }: 
{
	
	nixpkgs.config.allowUnfree = true;

	nix.settings.experimental-features = ["nix-command" "flakes"];

	boot = {
		kernelPackages = pkgs.linuxPackages_zen;

		loader = {
			systemd-boot = {
				enable = true;
				configurationLimit=50;
				consoleMode = "2";
				extraEntries = {
					"arch.conf" = ''
						title	Arch Linux(Zen)
						sort-key	arch
						linux	/vmlinuz-linux-zen
						initrd	/intel-ucode.img
						initrd	/initramfs-linux-zen.img
						options	root=LABEL=DATA rootflags=subvol=@arch rw
					'';
				};
				extraInstallCommands = ''
					${pkgs.gnused}/bin/sed -i 's/^default\s.*/default\t@saved/' /boot/loader/loader.conf
				'';
			};
			
			efi.canTouchEfiVariables= true;
		};
	};

	networking = {
		networkmanager.enable = true;
		firewall.enable = false;
	};

	time.timeZone = "Europe/Moscow";

	services = {

		xserver.enable = true;

		desktopManager.gnome.enable = true;
		displayManager.gdm.enable = true;

		openssh.enable = true;
		
		pipewire.enable = true;
	};

	programs = {
		thunar = {
			enable=true;
			plugins = with pkgs; [ thunar-archive-plugin thunar-volman  ];
		};
	};

	environment = {
		systemPackages = with pkgs;  [
			vim
		];

		variables = {
			EDITOR="vim";
			VISUAL="nvim";
		};
	};

	users.users.ropptar = {
		isNormalUser = true;
		extraGroups = ["wheel" "input" "networkManager" "docker" "video" "audio" ];	
	};

	system.stateVersion = "25.11";
}
