{ config, ... }: let
  font_family = "JetBrainsMono Nerd Font";
in {
	programs.hyprlock = {
		enable = true;

		settings = {
			general = {
				disable_loading_bar = true;
				hide_cursor = true;
				no_fade_in = false;
				grace = 0;
			};


			background = [
				{
					blur_passes = 2;
					blur_size = 8;
        				path = "/tmp/current-wallpaper";
					vibrancy = 0.8916;
					vibrancy_darkness = 0;
				}
			];

			input-field = [
				{
        				monitor = "eDP-1";

					size = "300, 50";

					outline_thickness = 4;

        				outer_color = "rgba(246, 246, 246, 0.1)";
        				inner_color = "rgba(246, 246, 246, 0.1)";
        				font_color = "#ffffff";

        				fade_on_empty = true;
					# font_size = 16;
        				placeholder_text = ""; # '<span font_family="JetBrainsMono">Password</span>'';

        				dots_spacing = 0.2;
        				dots_center = true;
      				}
    			];
			image = [
				{
					monitor = "";
					path = "";
					size = 60;
					reload_time = 2;
					rounding = 8;
					border_size = 0;
					reload_cmd = "/home/${config.home.username}/.scripts/music album-cover";
					position = "-150, -300";
					halign = "center";
					valign = "center";
				}
			];

			label = [
				{
					monitor = "";
					font_size = 10;
					inherit font_family;
					color = "rgb(255, 255, 255, 0.8)";
					position = "880, -310";
					halign = "left";
					valign = "center";
					text = "cmd[update:1000] echo \"$(/home/${config.home.username}/.scripts/music artist-name)\"";
				}
				{
					monitor = "";
					font_size = 10;
					inherit font_family;
					color = "rgb(255, 255, 255, 0.8)";
					position = "880, -290";
					halign = "left";
					valign = "center";
					text = "cmd[update:1000] echo \"$(/home/${config.home.username}/.scripts/music song-name)\"";
				}
				{
					monitor = "";
					font_size = 10;
					inherit font_family;
					color = "rgb(255, 255, 255, 0.8)";
					position = "880, -330";
					halign = "left";
					valign = "center";
					text = "cmd[update:1000] echo \"$(/home/${config.home.username}/.scripts/music album-name)\"";
				}
				{
					monitor = "";
					font_size = 10;
					inherit font_family;
					color = "rgb(255, 255, 255, 0.8)";
					position = "-730, -310";
					halign = "right";
					valign = "center";
					text = "cmd[update:1000] echo \"$(/home/${config.home.username}/.scripts/music length)\"";
				}
      				{
        				monitor = "";
        				text = "$TIME";
        				font_size = 160;
        				color = "rgb(255, 255, 255)";
					inherit font_family;

        				position = "0, 325";

        				valign = "center";
        				halign = "center";
				}
				{
					monitor = "";
					text = ''cmd[update:3600000] echo $(/home/${config.home.username}/.scripts/pretty_date lock_screen)'';
					font_size = 24;
					color = "rgb(255, 255, 255)";
					inherit font_family;

					position = "0, 195";

					valign = "center";
					halign = "center";
				}
				{
					monitor = "";
					text = "cmd[update:3600000] echo \"$(/home/${config.home.username}/.scripts/wttr lock_screen NOIDA)\"";
					font_size = 16;
					color = "rgb(255, 255, 255)";
					inherit font_family;

					position = "0, 157";

					valign = "center";
		 			halign = "center";
       				}
       				/* {
         				monitor = "";
	 				text = "cmd[update:40000] echo \"$(/home/${config.home.username}/.scripts/batinfo lock_screen)\"";
			 		font_size = 16;
			 		color = "rgb(255, 255, 255)";
					inherit font_family;

	 				position = "-20, 1";
			 		valign = "bottom";
		 			halign = "right";
		       		}
       				{
		         		monitor = "";
			 		text = "cmd[update:40000] echo \"$(/home/${config.home.username}/.scripts/netinfo)\"";
		 			font_size = 16;
			 		color = "rgb(255, 255, 255)";
					inherit font_family;

			 		position = "-54, 1";
					valign = "bottom";
					halign = "right";
	       			} */
			];
		};
	};
}
