{ lib, pkgs, ... }:
{
	imports = [
		./boot.nix
		./security.nix
		./users.nix
		./lanzaboote.nix
		./chores.nix
	];

	# Enable manpages for all users
	documentation = {
		dev.enable = true;
		man.generateCaches = true;
		nixos.includeAllModules = true;
	};

	i18n = {
		defaultLocale = "en_US.UTF-8";
	};
	
	nix.settings.experimental-features = [
		"nix-command"
		"flakes"
	];

	nixpkgs.config.allowUnfree = true;

	# Dconf
	programs.dconf.enable = true;
	
	# Enable zsh
	programs.zsh = {
		# Make sure that nothing can disable zsh or we're majestically screwed.
		enable = lib.mkForce true;
	};
	
	environment = {
		systemPackages = with pkgs; [
			libnotify
			xdg-utils
			polkit_gnome
			man-pages
			glib
			gsettings-desktop-schemas
		];
		shellAliases = {};
	};

	# Nerd Fonts
  	fonts.packages = [
    		pkgs.fira-code
    		pkgs.noto-fonts-cjk-sans
    		pkgs.noto-fonts
		pkgs.noto-fonts-emoji
		pkgs.font-awesome
    		(pkgs.nerdfonts.override {
      			fonts = [
        			"IBMPlexMono"
				"JetBrainsMono"
				"ProFont"
				"Ubuntu"
				"AnonymousPro"
				"RobotoMono"
				"Iosevka"
      			];
    		})
  	];

  	xdg.portal = {
    		enable = true;
    		extraPortals = with pkgs; [
      			xdg-desktop-portal-gtk
     			xdg-desktop-portal-hyprland
    		];
		config = {
			common.default = [ "gnome" ];
			hyprland.default = [ "gnome" "hyprland" ];
		};
		xdgOpenUsePortal = true;
 	};

	services.flatpak.enable = true;

	system.stateVersion = lib.mkForce "24.05";
	time.timeZone = lib.mkDefault "Asia/Kolkata";
}
