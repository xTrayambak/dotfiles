{ config, inputs, username, ... }:

{
  imports = [
    inputs.hyprlock.homeManagerModules.default
  ];
  programs.hyprlock = {
    enable = true;

    general = {
      disable_loading_bar = true;
      hide_cursor = true;
      no_fade_in = false;
    };

    backgrounds = [
      {
	blur_passes = 2;
	blur_size = 8;
        path = "/home/tray/Wallpapers/meadow-afternoon.png";
      }
    ];

    input-fields = [
      {
        monitor = "eDP-1";

        size = {
          width = 300;
          height = 50;
        };

        outline_thickness = 2;

        outer_color = "rgba(46, 52, 64, 50)";
        inner_color = "rgba(46, 52, 64, 50)";
        font_color = "rgb(255, 255, 255)";

        fade_on_empty = true;
        placeholder_text = ''<span font_family="JetBrainsMono">Password</span>'';

        dots_spacing = 0.3;
        dots_center = true;
      }
    ];

    labels = [
      {
        monitor = "";
        text = "$TIME";
        font_size = 90;
        color = "rgb(255, 255, 255)";

        position = {
          x = 0;
          y = 320;
        };

        valign = "center";
        halign = "center";
      }
      {
      	monitor = "";
	text = "cmd[update:86400000] echo \"$(/home/tray/.scripts/pretty_date lock_screen)\"";
	font_size = 24;
	color = "rgb(255, 255, 255)";

	position = {
	  x = 0;
	  y = 218;
	};

	valign = "center";
	halign = "center";
       }
    ];
  };
}
