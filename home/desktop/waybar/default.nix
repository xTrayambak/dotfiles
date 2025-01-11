{ inputs, pkgs, ... }:

{	
	programs.waybar = {
		enable = true;
		package = inputs.waybar.packages.${pkgs.system}.waybar;
		style = builtins.readFile ./style.css;
		settings.mainBar = {
			height = 36;
			spacing = 0;
			layer = "top";
			position = "top";
			modules-left = [
				"pulseaudio"
				"battery"
				"custom/weather"
				"temperature"
				"privacy"
			];
			modules-center = [
				"hyprland/window"
			];
			modules-right = [
				"tray"
				"network"
				"bluetooth"
        			"clock"
			];
			/* cava = {
        			framerate = 90;
        			autosens = 1;
        			bars = 24;
        			lower_cutoff_freq = 50;
        			higher_cutoff_freq = 10000;
        			method = "pipewire";
        			source = "auto";
        			stereo = true;
        			reverse = false;
        			bar_delimiter = 0;
        			monstercat = false;
        			waves = true;
        			input_delay = 0;
        			format-icons = [ 
          				"▁" 
          				"▂" 
          				"▃" 
          				"▄"
          				"▅" 
          				"▆" 
          				"▇" 
          				"█" 
        			];
      			}; */
			tray = {
				spacing = 4;
			};
      			"custom/weather" = {
				exec = "~/.scripts/wttr waybar NOIDA";
				"return-type" = "json";
				on-click = "~/.scripts/wttr notify NOIDA";
				on-click-right = "~/.scripts/wttr refresh NOIDA notify";
				interval = 10;
				format = "{}";
				tooltip = false;
			};
			"custom/vpn" = {
				exec = "~/.scripts/waybar_vpn utun420";
				return-type = "json";
				interval = 1;
				on-click = "windscribe-cli connect";
				on-click-right = "windscribe-cli disconnect";
			};
			"custom/airplane_mode" = {
				exec = "~/.scripts/airplane_mode waybar";
				return-type = "json";
				interval = 1;
				on-click = "~/.scripts/airplane_mode toggle";
			};
			battery = {
                		states = {
                    			good = 95;
                    			warning = 30;
                    			critical = 15;
                		};
                		format = "{icon}  {capacity}%";
                		format-charging = "  {capacity}%";
                		format-plugged = " {capacity}% ";
                		format-alt = "{icon} {time}";
				update-interval = 60; 
                		format-icons = ["" "" "" "" ""];
            		};
			clock = {
				format = "󰥔  {:%a %d %H:%M}";
				tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
				interval = 60;
			};
			bluetooth = {
				format = "";
				format-connected = "󰂱 {device_alias}";
				# tooltip-format = "{device_alias}";
				tooltip-format-connected = "{device_enumerate}";
				tooltip-format-enumerate-connected = "{device_alias}";
			};
			temperature = {
				# hwmon-path = "/sys/class/hwmon/hwmon0/temp1_input";
				critical-threshold = 90;
				format = "{icon} {temperatureC}℃";
				format-icons = ["" "" ""];
				interval = 10;
			};
			network = {
				format-wifi = "{icon}  {essid}";
				format-icons = [
					"󰤯"
					"󰤟"
					"󰤢"
					"󰤥"
					"󰤨"
				];
				tooltip-format = "↑ {bandwidthUpBytes} ↓ {bandwidthDownBytes}";
				format-ethernet = "󰈁";
				format-disconnected = "󰤫";
				format-disabled = "󰤭";
			};
			pulseaudio = {
				format = "{icon}  {volume}%";
				format-muted = "󰸈";
				format-source = "";
				format-source-muted = "";
				on-click = "pavucontrol";
				on-hover = "{source}%";
				on-scroll-up = "volumectl -d +1%";
				on-scroll-down = "volumectl -d -1%";
				format-icons = {
					headphone = "󰋍";
            				headset = "󰋍";
            				phone = "";
            				portable = "󰥰";
            				car = "";
            				default = [
						"󰕿"
						""
						""
					];
				};
			};
			"hyprland/window" = {
				max-length = 80;
				format = "<span>{}</span>";
				tooltip = "{}";
				separate-outputs = true;
				on-click = "${pkgs.foot}/bin/foot ${pkgs.btop}/bin/btop";
			};
		};
	};
}	
