{ pkgs, inputs, ... }:
{
	imports = [
		"${inputs.hm-librewolf-module.outPath}/modules/programs/librewolf.nix"
	];

	home.packages = [ pkgs.arkenfox-userjs ];
	disabledModules = [ "programs/librewolf.nix" ];
	programs.librewolf = {
		enable = true;
		profiles.ropptar = {

			isDefault = true;

			search.engines = {
				MyNixOS = {
					name = "MyNixOS";
					urls = [{
						template = "https://mynixos.com/search";
						params = [
							{ name = "q"; value = "{searchTerms}"; }
						];	
					}];

					icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake-white.svg";
					definedAliases = [ "@mn" ];
				};
			};	
			search.force = true;

			settings = {
				#fuck mozilla
				"browser.safebrowsing.enabled" = "false";
				"browser.safebrowsing.downloads.enabled" = "false";
				"browser.safebrowsing.malware.enabled" = "false";
				"datareporting.healthreport.service.enabled" = "false";
				"datareporting.healthreport.uploadEnabled" = "false";
				"toolkit.telemetry.unified" = "false";
				"toolkit.telemetry.enabled" = "false";
				"browser.pocket.enabled" = "false";
				"browser.selfsupport.url" = "";
				"browser.search.suggest.enabled" = "false";
				"media.gmp-eme-adobe.enabled" = "false";
				"media.eme.enabled" = "false";
				"media.peerconnection.ice.default_address_only" = "true";
				"loop.enabled" = "false";
				"network.captive-portal-service.enabled" = "false";
				"geo.enabled" = "false";
				"plugin.state.flash" = "0";

				#personal
				"toolkit.legacyUserProfileCustomizations.stylesheets" = "true"; #userChrome.css dependency
				"browser.sessionstore.interval" = "30000"; #save session every 5 minutes
				"middlemouse.paste" = "false"; #WHICH IDIOT DECIDED IT WOULD BE A COOL BEHAVIOR I HATE THEM
				"font.name.serif.x-western" = "Hack Nerd Font Propo"; #fonts yay
				"font.name.sans-serif.x-western" = "Hack Nerd Font Propo";
				"font.name.monospace.x-western" = "Hack Nerd Font Mono";
			};
		};
	};
}
