{ config, pkgs, ... }:
{
	dconf = {
    		enable = true;
    		settings = {
      			"org/gnome/desktop/interface" = {
        			color-scheme = "prefer-dark";
				gtk-theme = "Adwaita-dark";
      			};
			"org/gnome/shell" = {
				disable-user-extensions = false;
				enabled-extensions = with pkgs.gnomeExtensions; [
					blur-my-shell.extensionUuid
				];
			};
    		};
  	};

	gtk = {
		enable = true;
		cursorTheme = {
			name = "BreezeX-RosePine-Linux";
			size = 32;
		};
/*		theme = {
      			name = "Adwaita-dark";
    		};*/
		iconTheme = {
			name = "Adwaita";
			package = pkgs.adwaita-icon-theme;
		};
		font = {
			name = "AdwaitaSans";
			size = 11;
		};
  	};

	qt = {
		enable = true;
		platformTheme.name = "qtct";
		style.name = "kvantum";
	};

	# Thanks, @brisingr05!
	/* xdg.configFile = {
  		"gtk-4.0/assets".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/assets";
  		"gtk-4.0/gtk.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk.css";
  		"gtk-4.0/gtk-dark.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk-dark.css";


		# "gtk-3.0/assets".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-3.0/assets";
		# "gtk-3.0/gtk.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-3.0/gtk.css";
		# "gtk-3.0/gtk-dark.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-3.0/gtk-dark.css";

		# "Kvantum/kvantum.kvconfig".source = "${pkgs.colloid-kde}/share/Kvantum/Colloid/ColloidDark.kvconfig";
	}; */

	home.packages = with pkgs; [
		libadwaita
		adwaita-qt
		adwaita-qt6
		colloid-kde
		fira-code
		adwaita-fonts
		noto-fonts-cjk-sans
		noto-fonts
		noto-fonts-emoji
		font-awesome
		nerd-fonts.jetbrains-mono
		nerd-fonts.ubuntu
		nerd-fonts.zed-mono
		nerd-fonts.roboto-mono
	];
}
