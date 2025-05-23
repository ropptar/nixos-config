{ pkgs, ... }:
{
	programs.waybar = {
		enable = true;
		settings.mainBar = {
			position = "top";
			spacing = 8;
			modules-left = [
				"custom/distro"
				"hyprland/window"
				"hyprland/submap"
			];
			modules-center = [
				"hyprland/workspaces"
			];
			modules-right = [
				"wireplumber"
				"network"
				"hyprland/language"
				"clock"
				"tray"
			];
		
			"custom/distro" = {
				format = "{}";
				exec = pkgs.writeShellScript "get_distro" ''
					DISTRO=`hostnamectl | grep --color=never System`
					if [[ "$DISTRO" =~ "NixOS" ]]; then
						echo ""
					elif [[ "$DISTRO" =~ "Arch" ]]; then
						echo ""
					else 
						echo ""
					fi
				'';
			};
			"hyprland/window" = {
				format = "{}";
			};
		
			"hyprland/workspaces" = {
				format = "{icon}";
				format-icons = {
					"1" = "";
					"2" = "";
					"3" = "";
					"4" = "";
					"5" = "";
					"6" = "󰲪";
					"7" = "󰲬";
					"8" = "󰲮";
					"9" = "󰲰";
					"10" = "󰿬";
					"special" = "";
					"urgent" = "";
					"focused" = "";
					"default" = "";
				};
		
				active-only = false;
				show-special = true;
				special-visible-only = true;
				persistent-workspaces = {
					"*" = 5;
				};
			};
		
			"wireplumber" = {
				format = "<span color=\"#8ec07c\"></span> {volume}% 󰋋";
				format-muted = "<span color=\"#8ec07c\"></span> {volume}% 󰟎";
				on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
				on-click-middle = "pavucontrol";
			};
			"network" = {
				format-wifi = "<span color=\"#83a598\"></span> {essid} ({signalStrength}%) {icon}";
				format-ethernet = "<span color=\"#83a598\"></span> {ipaddr}/{cidr} ";
				format-linked = "<span color=\"#83a598\"></span> {ifname} (No IP) ";
				format-disconnected = "<span color=\"#83a598\"></span> No network ";
				format-alt = "<span color=\"#83a598\"></span> {ifname}: {ipaddr}/{cidr}";
				format-icons = ["󰤟" "󰤢" "󰤥" "󰤨"];
			};
			"hyprland/language" = {
				format = "<span color=\"#d3869b\"></span> {} 󰌌";
				format-en = "EN";
				format-ru = "RU";
			};
			"tray" = {
				icon-size =16;
				spacing = 10;
			};
			"clock" = {
				format = "<span color=\"#fabd2f\"></span> {:%H:%M} 󰥔";
				timezone = "Europe/Moscow";
				tooltip-format = "{:%d %h %Y, %H:%M:%S}";
			};
		};
		style = ''
@define-color bg #282828;
@define-color fg #ebdbb2;
@define-color gray #a89984;
@define-color red #fb4934;
@define-color red-d #cc241d;
@define-color green #b8bb26;
@define-color green-d #98971a;
@define-color yellow #fabd2f;
@define-color yellow-d #d79921;
@define-color blue #83a598;
@define-color blue-d #458588;
@define-color purple #d3869b;
@define-color purple-d #b16286;
@define-color aqua #8ec07c;
@define-color aqua-d #689d6a;
@define-color orange #fe8019;
@define-color orange-d #d65d0e;


window#waybar {
	background: transparent;
}

window#waybar.hidden {
	opacity: 0;
}

/* global */

#custom-distro,
#window,
#submap,
#workspaces,
#wireplumber,
#network,
#language,
#clock,
#tray
{
	font-size: 18px;
	color: @fg;
	background: @bg;   
	padding: 10px;
	margin-top: 10px;
	border: none;
	border-radius: 10px;
	font-family: Hack Nerd Font Propo;
	transition: none;
	min-height: 20px;
}

/* fix window title collision */

.modules-left {
	margin-right: 15px;
}

.modules-right {
	margin-left: 15px;
}

/* left/rightmost margin*/

.modules-left > widget:first-child > #custom-distro {
	border: 1px solid @orange;
	margin-left: 15px;
}

.modules-right > widget:last-child > #tray  {
	margin-right: 15px;
}

/* modules-left */

#custom-distro {
	font-size: 25px;
	padding: 0px 9px;
	color: @orange;
}

#submap {
	padding: 5px;
	border: 5px solid @red;
}

/* modules-center */

#workspaces {
	font-size: 20px;
}

#workspaces button.empty {
	color: @gray;
}

#workspaces button {
	padding: 0px 5px;
	color:@fg;
}

#workspaces button.active {
	color: @orange;
}

#workspaces button.special {
	padding-left: 4px;
	color: @blue;
}

#workspaces button.urgent {
	color: @red;
}

/* modules-right */

#wireplumber.muted {
	color: @red;
}
'';
	};
}
