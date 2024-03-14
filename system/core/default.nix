{ lib, pkgs, inputs, ... }:
{
	imports = [
		./boot.nix
		./security.nix
		./users.nix
		./lanzaboote.nix
		./chores.nix
	];
	documentation.dev.enable = true;

	i18n = {
		defaultLocale = "en_US.UTF-8";
	};

	nix.settings.experimental-features = [
		"nix-command"
		"flakes"
	];

	system.autoUpgrade = {
  		enable = true;
  		flake = inputs.self.outPath;
  		flags = [
    			"--update-input"
    			"nixpkgs"
   			 "-L" # print build logs
  		];
  		dates = "02:00";
  		randomizedDelaySec = "45min";
	};


	# Dconf
	programs.dconf.enable = true;
	
	# Enable zsh
	programs.zsh = {
		# Make sure that nothing can disable zsh or we're majestically screwed.
		enable = lib.mkForce true;
		shellAliases = {
			gc = "git commit";
			gcm = "git commit -m";
			upgrade = "sudo nix flake update /home/tray/.config/home-manager# && all-switch";
		};
	};
	
	# Blueman
	services.blueman.enable = true;

	environment = {
		systemPackages = with pkgs; [
			libnotify
			xdg-utils
			polkit
			polkit_gnome
			glib
			gsettings-desktop-schemas
			sbctl
		];
		shellAliases = {};
	};

	# Nerd Fonts
  	fonts.packages = with pkgs; [
    		fira-code
    		noto-fonts-cjk-sans
    		noto-fonts
		noto-fonts-emoji
    		(nerdfonts.override {
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
			common.default = [ "gtk" "gnome" ];
			hyprland.default = [ "gtk" "hyprland" ];
		};
		xdgOpenUsePortal = true;
 	};

	services.flatpak.enable = true;

	system.stateVersion = lib.mkForce "24.05";
	time.timeZone = lib.mkDefault "Asia/Kolkata";
}
