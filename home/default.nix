{ pkgs, ... }:
{
	imports=[
		./development.nix
		./media.nix
		./games.nix
	];

	programs.home-manager.enable = true;

	home = {
		sessionVariables = {
			EDITOR="nvim";
			BROWSER="firefox";
			TERMINAL="kitty";
		};

		packages = with pkgs; [
			v2rayn
		];

		username = "ropptar";
		homeDirectory = "/home/ropptar";
		stateVersion="25.11";
	};
}

