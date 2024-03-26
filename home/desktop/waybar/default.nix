{ inputs, pkgs, ... }:

{	
	programs.waybar = {
		enable = true;
		package = inputs.waybar.packages.${pkgs.system}.waybar;
		style = builtins.readFile ./style.css;
		settings.mainBar = {
			height = 32;
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
				"network"
				"bluetooth"
        			"clock"
        			"tray"
			];
			cava = {
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
      			};
			tray = {
				spacing = 4;
			};
      			"custom/weather" = {
				exec = "~/.scripts/wttr waybar NOIDA";
				"return-type" = "json";
				interval = 100;
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
                		format-icons = ["" "" "" "" ""];
            		};
			clock = {
				format = "<span foreground='#e5e9f0'> </span> {:%a %d %H:%M:%S}";
				tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
				interval = 1;
			};
			bluetooth = {
				format = " {device_alias}";
				on-click = "blueman-manager";
				format-connected = " ";
				# tooltip-format = "{device_alias}";
				tooltip-format-connected = "{device_enumerate}";
				tooltip-format-enumerate-connected = "{device_alias}";
			};
			temperature = {
				# hwmon-path = "/sys/class/hwmon/hwmon0/temp1_input";
				critical-threshold = 90;
				format = "{icon} {temperatureC}℃";
				format-icons = ["" "" ""];
				interval = 20;
			};
			network = {
				format-wifi = "  {essid}";
				on-click = "iwgtk";
				# tooltip-format = "";
				format-ethernet = "";
				format-disconnected = "";
				format-disabled = "✈";
			};
			pulseaudio = {
				format = "{icon}  {volume}%";
				format-muted = "";
				format-source = "";
				format-source-muted = "";
				on-hover = "{source}%";
				format-icons = {
					headphone = "";
            				headset = "";
            				phone = "";
            				portable = "";
            				car = "";
            				default = [
						""
						""
						""
					];
				};
			};
			"hyprland/window" = {
				max-length = 100;
				format = "<span>{}</span>";
				separate-outputs = true;
			};
		};
	};
}	
