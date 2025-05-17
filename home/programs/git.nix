{ ... }:
{
	programs = {
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
	};
}
