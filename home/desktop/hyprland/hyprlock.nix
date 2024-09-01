{ config, ... }: let
  font_family = "JetBrainsMono";
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
					font_size = 16;
        				placeholder_text = ''<span font_family="JetBrainsMono">Password</span>'';

        				dots_spacing = 0.2;
        				dots_center = true;
      				}
    			];

			label = [
      				{
        				monitor = "";
        				text = "$TIME";
        				font_size = 90;
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

					position = "0, 218";

					valign = "center";
					halign = "center";
				}
				{
					monitor = "";
					text = "cmd[update:3600000] echo \"$(/home/${config.home.username}/.scripts/wttr lock_screen NOIDA)\"";
					font_size = 16;
					color = "rgb(255, 255, 255)";
					inherit font_family;

					position = "0, 184";

					valign = "center";
		 			halign = "center";
       				}
       				{
         				monitor = "";
	 				text = "cmd[update:40000] echo \"$(/home/${config.home.username}/.scripts/batinfo lock_screen)\"";
			 		font_size = 16;
			 		color = "rgb(255, 255, 255)";
	 				font_family = "FontAwesome";

	 				position = "-24, 1";
			 		valign = "bottom";
		 			halign = "right";
		       		}
       				{
		         		monitor = "";
			 		text = "cmd[update:40000] echo \"$(/home/${config.home.username}/.scripts/netinfo)\"";
		 			font_size = 16;
			 		color = "rgb(255, 255, 255)";
			 		font_family = "FontAwesome";

			 		position = "-54, 1";
					valign = "bottom";
					halign = "right";
	       			}
			];
		};
	};
}
