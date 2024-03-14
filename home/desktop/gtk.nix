{ config, pkgs, ... }:
{
	dconf = {
    		enable = true;
    		settings = {
      			"org/gnome/desktop/interface" = {
        			color-scheme = "prefer-dark";
				gtk-theme = "Adwaita-dark";
      			};
    		};
  	};
	gtk = {
		enable = true;
		theme = {
      			name = "Adwaita-dark";
			package = pkgs.adw-gtk3;
    		};
		iconTheme = {
			name = "Adwaita";
			package = pkgs.gnome.adwaita-icon-theme;
		};
		font = {
			name = "JetBrainsMono";
			size = 11;
		};
  	};
	
	# Thanks, @brisingr05!
	xdg.configFile = {
  		"gtk-4.0/assets".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/assets";
  		"gtk-4.0/gtk.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk.css";
  		"gtk-4.0/gtk-dark.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk-dark.css";
	};

	home.packages = with pkgs; [
		gnome.adwaita-icon-theme
		libadwaita
		adwaita-qt
		adwaita-qt6
	];
}
