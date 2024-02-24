{
	programs.waybar = {
		enable = true;
    style = ''
* {
    font-family: JetBrainsMono, FontAwesome, RobotoMono;
    font-size: 14px;
}

window#waybar {
    background-color: rgba(59, 66, 82, 0.0);
    border-radius: 0px;
    color: #FFFFFF;
    transition-property: background-color;
    transition-duration: .5s; 
}

#clock,
#battery,
#cpu,
#memory,
#disk,
#temperature,
#backlight,
#network,
#pulseaudio,
#tray,
#mode,
#window,
#custom-vpn,
#bluetooth,
#privacy,
#custom-weather
{
    padding: 0 10px;
    margin: 3px 0;
    color: rgba(46, 52, 64, 0.4998);
    border-radius: 10px;
}

#custom-notification
{
	padding: 0 10px;
	margin: 0 0;
	color: rgba(46, 52, 64, 0.4998);
	border-radius: 10px;
}

#user
{
	margin: 3px 0;
}

#custom-cava 
{
	margin: 3px 0;
	padding: 0 10px;
	border-radius: 10px;
}

#workspaces
{
	padding: 0 5px;
	margin: 3px 0;
	color: #FFFFFF;
	border-radius: 5px;
}

#clock,
#window,
#workspaces,
#battery,
#cpu,
#memory,
#disk,
#backlight,
#network,
#pulseaudio,
#temperature,
#custom-notification,
#custom-weather,
#custom-playerlabel,
#custom-playerctl.backward,
#custom-playerctl.play,
#custom-playerctl.forward,
#custom-vpn,
#bluetooth,
#tray,
#privacy
{
    background-color: rgba(46, 52, 64, 0.4998);
    color: #FFFFFF;
}

#tray {
	margin-right: 10px;
}

#custom-weather {
	margin: 3px 0px;
}

#clock {
	margin-right: 5px;
}

#pulseaudio {
	margin-left: 10px;
	border-radius: 10px 0px 0px 10px;
}

#temperature, #custom-vpn, #bluetooth, #privacy {
	border-radius: 0px 0px 0px 0px;
	margin-left: 0px;
	margin-right: 0px;
	border-left: 0px;
	border-right: 0px;
}

#network {
	border-radius: 10px 0px 0px 10px;
}

#battery {
	border-radius: 0px 0px 0px 0px;
}

#clock {
	border-radius: 0px 10px 10px 0px;
}

#custom-weather {
	border-radius: 0px 10px 10px 0px;
}

#custom-cava 
{
	background-color: rgba(46, 52, 64, 0.4998);
}

#custom-playerlabel
{
	border-radius: 10px 0px 0px 0px;
}

#custom-playerctl.backward {
	margin-left: 10px;
	border-radius: 10px 0px 0px 0px;
	padding-left: 16px;
	margin-left: 7px;
}

#custom-playerctl.play {
	border-radius: 0px 0px 0px 0px;
	padding: 0 5px;
}

#custom-playerctl.forward {
	border-radius: 0px 0px 10px 0px;
	padding-right: 12px;
        margin-right: 7px
}

#custom-playerctl.backward,
#custom-playerctl.play,
#custom-playerctl.forward
{
	font-weight: bold;
	font-size: 22px;
}
    		'';
		settings.mainBar = {
			height = 32;
			spacing = 0;
			layer = "top";
			position = "top";
			modules-left = [
				"pulseaudio"
				"battery"
				"temperature"
				"custom/weather"
			];
			modules-center = [
				"hyprland/window"
			];
			modules-right = [
				"network"
				"bluetooth"
				"custom/vpn"
        			"clock"
        			"tray"
			];
			cava = {
        			framerate = 60;
        			autosens = 1;
        			bars = 18;
        			lower_cutoff_freq = 50;
        			higher_cutoff_freq = 10000;
        			method = "pipewire";
        			source = "auto";
        			stereo = true;
        			reverse = false;
        			bar_delimiter = 0;
        			monstercat = false;
        			waves = false;
        			input_delay = 2;
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
			cpu = {
				format = " {usage}%";
				tooltip = false;
			};
			memory = {
				format = "{}%";
			};
			bluetooth = {
				format = "";
				on-click = "GTK_THEME=Adwaita-dark blueman-manager";
				format-connected = " ";
				tooltip-format = "{device_alias}";
				tooltip-format-connected = "{device_enumerate}";
				tooltip-format-enumerate-connected = "{device_alias}";
			};
			temperature = {
				hwmon-path = "/sys/class/hwmon/hwmon2/temp1_input";
				critical-threshold = 85;
				format = "{icon} {temperatureC}℃";
				format-icons = ["" "" ""];
			};
			network = {
				format-wifi = " ";
				on-click = "iwgtk";
				tooltip-format = "{essid}";
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
				max-length = 48;
				format = "{}";
				seperate-outputs = true;
			};
		};
	};
}	
