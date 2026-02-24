{ inputs, pkgs, ...}:

{
	programs.firefox = {
		enable = true;
		profiles.ropptar = {
			id = 0;
			isDefault = true;
			extensions = with inputs.firefox-addons.packages.x86_64-linux; [
				ublock-origin
				darkreader
				sponsorblock
				vimium
				privacy-badger
				dearrow
			];

			#the downfall of firefox as out of the box browser must be studied.
			settings = {
				"extensions.autoDisableScopes" = 0;
				"extensions.enabledScopes" = 4;

				"middlemouse.paste" = false;
				"general.autoScroll" = true;
				"sidebar.verticalTabs" = true;
				
				"browser.tabs.closeWindowWithLastTab" = false;
				"browser.translations.enable" = false;
				"browser.translations.automaticallyPopup" = false;
				
				"browser.ml.enable" = false;
				"browser.ml.chat.enabled" = false;
				"browser.ml.chat.page" = false;
				"browser.ml.linkPreview.enabled" = false;
				"browser.tabs.groups.smart.enabled" = false;
				"browser.tabs.groups.smart.userEnabled" = false;
				"extensions.ml.enabled" = false;
				"sidebar.notification.badge.aichat" = false;
				
				"datareporting.healthreport.uploadEnabled" = false;  # Send technical data
				"datareporting.policy.dataSubmissionEnabled" = false;  # Daily usage ping
				"privacy.donottrackheader.enabled" = true;  # DNT header
				"privacy.globalprivacycontrol.enabled" = true;  # GPC (Do Not Sell)
				
				"browser.safebrowsing.malware.enabled" = false;
				"browser.safebrowsing.phishing.enabled" = false;
				"browser.safebrowsing.downloads.enabled" = false;
				
				"ui.systemUsesDarkTheme" = 1;
				"layout.css.prefers-color-scheme.content" = 2;
				
				"browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" = false;
				"browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" = false;
			};
		};

		policies = {
			"DisableTelemetry" = true;
			"DisableFirefoxStudies" = true;
			"EnableTrackingProtection" = {
				Value = false;
				Locked = false;
			};

			"SearchEngines" = {
				"Default" = "DuckDuckGo";
				"Add" = [
					{
						"Name" = "Wikipedia";
						"URLTemplate" = "https://wikipedia.org/w/index.php?search=%s";
						"Method" = "GET";
						"IconURL" = "https://en.wikipedia.org/static/favicon/wikipedia.ico";
						"Alias" = "wiki";
					}
					{
						"Name" = "Arch Wiki";
						"URLTemplate" = "https://wiki.archlinux.org/index.php?search=%s";
						"Method" = "GET";
						"IconURL" = "https://wiki.archlinux.org/favicon.ico";
						"Alias" = "aw";
					}
					{
						"Name" = "NixOS Option Search";
						"URLTemplate" = "https://mynixos.com/search?q=%s";
						"Method" = "GET";
						"IconURL" = "https://mynixos.com/favicon-dark.svg";
						"Alias" = "nix";
					}
				];
			};
		};
	};


	home.packages = with pkgs; [
		telegram-desktop
		teamspeak6-client

		tumbler
		gvfs
		
		vlc
	];
}
