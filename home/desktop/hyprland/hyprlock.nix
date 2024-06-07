{ config, inputs, username, ... }: let
  font_family = "JetBrainsMono";
in {
	programs.hyprlock = {
		enable = true;

		settings = {
    		general = {
			disable_loading_bar = true;
			hide_cursor = true;
			no_fade_in = false;
    		};


    		backgrounds = [
      			{
				blur_passes = 2;
				blur_size = 8;
        			path = "/home/${config.home.username}/Wallpapers/thing16-afternoon.png";
      			}
    			];

    		input-fields = [
      			{
        			monitor = "eDP-1";

				size = {
          				width = 300;
          				height = 50;
        			};

        			outline_thickness = 4;

        			outer_color = "rgba(46, 52, 64, 50)";
        			inner_color = "rgba(46, 52, 64, 50)";
        			font_color = "#ffffff";

        			fade_on_empty = true;
        			placeholder_text = ''<span font_family="JetBrainsMono">Password</span>'';

        			dots_spacing = 0.2;
        			dots_center = true;
      			}
    		];

		labels = [
      			{
        			monitor = "";
        			text = "$TIME";
        			font_size = 90;
        			color = "rgb(255, 255, 255)";
				inherit font_family;

        			position = {
          				x = 0;
          				y = 320;
        			};

        			valign = "center";
        			halign = "center";
      			}
      			{
      				monitor = "";
				text = ''cmd[update:3600000] echo $(/home/${config.home.username}/.scripts/pretty_date lock_screen)'';
				font_size = 24;
				color = "rgb(255, 255, 255)";
				inherit font_family;

				position = {
	  				x = 0;
	  				y = 218;
				};

				valign = "center";
				halign = "center";
       			}
       			{
         			monitor = "";
		 		text = "cmd[update:3600000] echo \"$(/home/${config.home.username}/.scripts/wttr lock_screen NOIDA)\"";
	 			font_size = 16;
		 		color = "rgb(255, 255, 255)";
		 		inherit font_family;

	 			position = {
	   				x = 0;
	   				y = 184;
		 		};

		 		valign = "center";
		 		halign = "center";
       			}
       			{
         			monitor = "";
	 			text = "cmd[update:40000] echo \"$(/home/${config.home.username}/.scripts/batinfo lock_screen)\"";
		 		font_size = 16;
		 		color = "rgb(255, 255, 255)";
	 			font_family = "FontAwesome";

	 			position = {
	   				x = -24;
	   				y = -70;
		 		};
		 		valign = "bottom";
	 			halign = "right";
	       		}
       			{
	         		monitor = "";
		 		text = "cmd[update:40000] echo \"$(/home/${config.home.username}/.scripts/netinfo)\"";
	 			font_size = 16;
		 		color = "rgb(255, 255, 255)";
		 		font_family = "FontAwesome";

		 		position = {
		   			x = -54;
	   				y = -70;
				};
				valign = "bottom";
				halign = "right";
	       		}
		];
		};
	};
}
