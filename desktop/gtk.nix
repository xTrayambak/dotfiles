{ pkgs, ... }:
{
	dconf = {
    		enable = true;
    		settings = {
      			"org/gnome/desktop/interface" = {
        			color-scheme = "prefer-dark";
      			};
    		};
  	};
	gtk = {
		enable = true;
		theme = {
      			name = "Adwaita-dark";
    		};
		iconTheme = {
			name = "Adwaita";
			package = pkgs.gnome.adwaita-icon-theme;
		};
  	};
}
