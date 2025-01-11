{ config, inputs, pkgs, ... }:

{
  home.packages = with pkgs; [
    grim
    slurp
    swww
    ydotool
    networkmanagerapplet
  ];

  imports = [
    ./hypridle.nix
    ./hyprlock.nix
  ];
  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    plugins = [
	inputs.hyprland-plugins.packages.${pkgs.system}.hyprexpo
    ];
    settings = {
	# Variables
    	"$mainMod" = "SUPER";
	"$term" = "${pkgs.foot}/bin/foot";
	"$filemanager" = "${pkgs.nautilus}/bin/nautilus";
	"$fullscreenss" = "/home/${config.home.username}/.scripts/screenshot full";
	"$selectss" = "/home/${config.home.username}/.scripts/screenshot select";
	"$screenlock" = "/home/${config.home.username}/.scripts/locker";
	"$applauncher" = "${pkgs.rofi-wayland}/bin/rofi -show drun";
	"$selectss_silent" = "/home/${config.home.username}/.scripts/screenshot select yes";
	"$fullscreenss_silent" = "/home/${config.home.username}/.scripts/screenshot full yes";
	
	env = [
		"HYPRCURSOR_THEME,rose-pine-hyprcursor"
		"HYPRCURSOR_SIZE,${toString config.gtk.cursorTheme.size}"
		"XCURSOR_SIZE,${toString config.gtk.cursorTheme.size}"
		"XCURSOR_THEME,${config.gtk.cursorTheme.name}"
		"GTK_THEME,${config.gtk.theme.name}"
		"GSK_RENDERER,ngl" # I have weird artifacting with the Vulkan backend on my AMD GPU
		"AQ_DRM_DEVICES,/dev/dri/card2"
	];

	"binds:scroll_event_delay" = "80000000";

	# Monitor configuration (1920x1080 display at 144FPS)
	monitor = [
		",preferred,auto,1"
		"eDP-1,1920x1080@144,0x0,1"
	];

	unbind = [
		"mouse:mouse_up,0"
		"mouse:mouse_down,0"
	];
	
	# Start my bar, wallpaper applier + wallpaper script, notification daemon, OSD and networkmanager applet
	exec-once = [
		"${pkgs.waybar}/bin/waybar" # "zsh -c waybar"
		"${pkgs.swww}/bin/swww-daemon"
		"/home/${config.home.username}/.scripts/wallpaper_dumb"
		"/home/${config.home.username}/.scripts/power_saver_userland"
		"${pkgs.mako}/bin/mako"
		"${pkgs.avizo}/bin/avizo-service"
		"${pkgs.blueman}/bin/blueman-applet"
		"${pkgs.networkmanagerapplet}/bin/nm-applet"
	];

	# Input settings
	input = {
		kb_layout = "us";
		follow_mouse = true;
		accel_profile = "adaptive";
		sensitivity = 0.5669;
		scroll_button = -1;
		force_no_accel = false;

		touchpad = {
			natural_scroll = true;
        		tap-to-click = true;
        		disable_while_typing = false;
		};
	};

	general = {
		gaps_in = 4;
		gaps_out = 10.5;
		border_size = 2;
		"col.active_border" = "rgba(595959aa)";
		"col.inactive_border" = "rgba(595959aa)";
		allow_tearing = true;
		layout = "dwindle";
	};

	decoration = {
		rounding = 10;

		blur = {
			enabled = true;
			size = 6;
			passes = 3;
			ignore_opacity = true;
			popups = true;
		};

		# drop_shadow = true;
		# shadow_range = 4;
		# shadow_render_power = 3;
		# "col.shadow" = "rgba(0b0e07d1)";
	};

	animations = {
		enabled = true;
		bezier = [ 
			"myBezier, 0.05, 0.9, 0.1, 1.05" 
			"workspaceSwitch, .37,.04,.6,.92"
		];
		animation = [
			"windows, 1, 5, myBezier"
			"windowsOut, 1, 5, myBezier, popin 80%"
			"border, 1, 10, default"
			"borderangle, 1, 8, default"
			"layersIn, 1, 5, default, slidevert"
			"layersOut, 1, 5, default, slidevert"
			"workspaces, 1, 5, myBezier"
			"specialWorkspace, 1, 5, myBezier"
		];
	};

	dwindle = {
		pseudotile = false;
		preserve_split = true;
	};

	#master.new_is_master = true;

	gestures = {
		workspace_swipe = true;
		workspace_swipe_fingers = 3;
	};

	misc = {
		vrr = true;
		disable_hyprland_logo = true;
		disable_splash_rendering = true;
	};
	
	# Layer rules
	layerrule = [
		"blur, wofi"
		"blur, notifications"
		"ignorezero, notifications"
		"ignorezero, wofi"
		"blur, avizo"
		"blur, rofi"
		"ignorezero, rofi"
		"ignorezero, avizo"
		"blur, waybar"
		"ignorealpha 0.23, waybar"
		"blurpopups, waybar"
		"animation fadeIn, avizo"
		"blur, lucem"
		"blur, logout_dialog"
		"ignorezero, logout_dialog"
		"animation fadeIn, logout_dialog"
		"ignorealpha 0.23, lucem"
		"blur, basket"
		"ignorezero, basket"
	];

	# Window rules
	windowrule = [
		"float, blueman"
		"fullscreen, Xonotic"
		"fullscreen, ^(Minecraft)(.*)$"
		"immediate, ^(Minecraft)(.*)$"
		"immediate, Xonotic"
	];

	windowrulev2 = [
		"opacity 0.845 override, class:org.pulseaudio.pavucontrol"
		"float, class:org.pulseaudio.pavucontrol"
		"float, class:.blueman-manager-wrapped"
		"opacity 0.845 override, class:.blueman-manager-wrapped"
		"opacity 0.799 override, class:vesktop"
		"opacity 0.845 override, class:org.gnome.World.Secrets"
		"opacity 0.845 override, class:org.gnome.Settings"
		"workspace 4 silent, class:vesktop"
		"workspace 1, class:firefox"
		"fullscreen, class:sober"
		"float, class:sober_services"
		"workspace 3, class:sober"
		"workspace 3, class:sober_services"
		"immediate, class:sober"
		# "float, class:org.gnome.Nautilus"
		"float, class:org.gnome.Calculator"
		"float, class:org.gnome.Characters"
		"opacity 0.845 override, class:chrome-cifhbcnohmdccbgoicgdjpfamggdegmo-Default" # Teams
		"float, class:io.missioncenter.MissionCenter"
		"size 1053 719, class:io.missioncenter.MissionCenter"
		"opacity 0.845, class:io.missioncenter.MissionCenter"
		"opacity 0.945, class:foot"
		"float, class:nm-connection-editor"
		"opacity 0.945, class:nm-connection-editor"
		"opacity 0.845, class:org.gnome.Calculator"
		"float, title:^(Lucem)$"
		"opacity 0.845, title:^(Lucem)$"
		"workspace 3, title:^(Lucem)$"
		"workspace 3, class:sober"
	];

	# Keybinds
	bind = [
		"SUPER, Tab, cyclenext"
		"SUPER_SHIFT, Tab, swapnext"
		"SUPER, T, exec, $term"
		"SUPER, Return, exec, $term"
		"SUPER, F, exec, $filemanager"
		"SUPER_SHIFT, T, killactive"
		"SUPER_SHIFT, R, exec, hyprctl reload"
		"SUPER_ALT, T, exec, hyprctl kill"
		"SUPER, V, togglefloating"
		"SUPER, D, exec, $applauncher"
		",Print, exec, $selectss"
		"$mainMod, L, exec, $screenlock"
		",F8, exec, ${pkgs.playerctl}/bin/playerctl previous"
		",F9, exec, ${pkgs.playerctl}/bin/playerctl play-pause"
		",F10, exec, ${pkgs.playerctl}/bin/playerctl next"

		# Wallpaper controls
		"SUPER_SHIFT, W, exec, /home/${config.home.username}/.scripts/wallpaper_cli change-wallpaper"
		"SUPER_SHIFT, P, exec, /home/${config.home.username}/.scripts/wallpaper_cli toggle"
		# "SUPER_SHIFT, S, exec, /home/${config.home.username}/.scripts/wallpaper_cli cycle-time"

		",F11, fullscreen"
		"$mainMod, Print, exec, $fullscreenss"
		
		# Volume controls
		",XF86AudioMute, exec, ${pkgs.avizo}/bin/volumectl -d toggle-mute"
		",XF86AudioMicMute, exec, ${pkgs.avizo}/bin/volumectl -d -m toggle-mute"

		# Power mode switchers
		"SUPER_SHIFT, G, exec, /home/${config.home.username}/.scripts/power_saver_userland performance"
		"SUPER_SHIFT, N, exec, /home/${config.home.username}/.scripts/power_saver_userland ac"
		
		# Calculator button on my keyboard
		",XF86Calculator, exec, ${pkgs.gnome-calculator}/bin/gnome-calculator"

                # "SUPER_SHIFT, E, exec, ${pkgs.emacs}/bin/emacs"
		# "SUPER_SHIFT, B, exec, ${pkgs.firefox}/bin/firefox"
		# "SUPER_SHIFT, D, exec, ${pkgs.vesktop}/bin/vesktop"

		# Moving
		"SUPER_SHIFT, left, movewindow, l"
		"SUPER_SHIFT, right, movewindow, r"
		"SUPER_SHIFT, up, movewindow, u"
		"SUPER_SHIFT, down, movewindow, d"

		# Global keybinds
		"SUPER, R, pass, ^(com\.obsproject\.Studio)$"
		"SUPER, P, pass, ^(com\.obsproject\.Studio)$"
		"SUPER, M, pass, ^(com\.obsproject\.Studio)$"
		"SUPER, N, pass, ^(com\.obsproject\.Studio)$"

		# Notification destroyer 8000
		"SUPER_SHIFT, D, exec, ${pkgs.mako}/bin/makoctl dismiss"

		"SUPER, E, exec, ${pkgs.wlogout}/bin/wlogout"

		# Workspace switching
		"$mainMod, 1, workspace, 1"
        	"$mainMod, 2, workspace, 2"
        	"$mainMod, 3, workspace, 3"
        	"$mainMod, 4, workspace, 4"
        	"$mainMod, 5, workspace, 5"
        	"$mainMod, 6, workspace, 6"
        	"$mainMod, 7, workspace, 7"
        	"$mainMod, 8, workspace, 8"
        	"$mainMod, 9, workspace, 9"
        	"$mainMod, 0, workspace, 10"
		
		# Workspace shifting
		"bind = $mainMod SHIFT, 1, movetoworkspace, 1"
		"bind = $mainMod SHIFT, 2, movetoworkspace, 2"
		"bind = $mainMod SHIFT, 3, movetoworkspace, 3"
		"bind = $mainMod SHIFT, 4, movetoworkspace, 4"
		"bind = $mainMod SHIFT, 5, movetoworkspace, 5"
		"bind = $mainMod SHIFT, 6, movetoworkspace, 6"
		"bind = $mainMod SHIFT, 7, movetoworkspace, 7"
		"bind = $mainMod SHIFT, 8, movetoworkspace, 8"
		"bind = $mainMod SHIFT, 9, movetoworkspace, 9"
		"bind = $mainMod SHIFT, 0, movetoworkspace, 10"
	];
	
	# Mouse binds
	bindm = [
		"SUPER, mouse:272, movewindow"
		"SUPER, mouse:273, resizewindow"
	];

	# Holdable buttons
	binde = [
		",XF86AudioLowerVolume, exec, ${pkgs.avizo}/bin/volumectl -d -u down"
		",XF86AudioRaiseVolume, exec, ${pkgs.avizo}/bin/volumectl -d -u up"
		",XF86MonBrightnessDown,exec, ${pkgs.avizo}/bin/lightctl -d down"
		",XF86MonBrightnessUp,exec, ${pkgs.avizo}/bin/lightctl -d up"

		# Resizing
		"SUPER, left, resizeactive, -15 0"
		"SUPER, right, resizeactive, 15 0"
		"SUPER, up, resizeactive, 0 -15"
		"SUPER, down, resizeactive, 0 15"
	];

	plugin = {
		hyprexpo = {
			columns = 3;
			gap_size = 5;
			workspace_method = "center current";
			enable_gesture = true;
			gesture_fingers = 3;
			gesture_distance = 300;
			gesture_positive = false;
		};
	};
    };
  };
}
