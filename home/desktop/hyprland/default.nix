{ config, inputs, pkgs, ... }:

{
  home.packages = with pkgs; [
    grim
    slurp
    swww
    networkmanagerapplet
  ];
  imports = [
    ./hypridle.nix
    ./hyprlock.nix
  ];
  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    settings = {
	# Variables
    	"$mainMod" = "SUPER";
	"$term" = "foot";
	"$filemanager" = "nautilus";
	"$fullscreenss" = "/home/${config.home.username}/.scripts/screenshot full";
	"$selectss" = "/home/${config.home.username}/.scripts/screenshot select";
	"$screenlock" = "/home/${config.home.username}/.scripts/locker";
	"$applauncher" = "wofi -H 480 -W 640";
	"$selectss_silent" = "/home/${config.home.username}/.scripts/screenshot select silent";
	"$fullscreenss_silent" = "/home/${config.home.username}/.scripts/screenshot full silent";
	
	env = [
		"HYPRCURSOR_THEME,${config.gtk.cursorTheme.name}"
		"HYPRCURSOR_SIZE,${toString config.gtk.cursorTheme.size}"
		"GTK_THEME,${config.gtk.theme.name}"
	];

	# Monitor configuration (1920x1080 display at 144FPS)
	monitor = [
		",preferred,auto,1"
		"eDP-1,1920x1080@144,0x0,1"
	];
	
	# Start my bar, wallpaper applier + wallpaper script, notification daemon, OSD and networkmanager applet
	exec-once = [
		"zsh -c waybar"
		"swww init"
		"/home/${config.home.username}/.scripts/wallpaper"
		"mako"
		"avizo-service"
		"emacs --daemon"
		"blueman-applet"
		"nm-applet"
	];

	# Input settings
	input = {
		kb_layout = "us";
		follow_mouse = true;
		accel_profile = "adaptive";

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

		drop_shadow = true;
		shadow_range = 4;
		shadow_render_power = 3;
		"col.shadow" = "rgba(0b0e07d1)";
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
			"workspaces, 1, 5, myBezier, slidevert"
			"specialWorkspace, 1, 5, myBezier, slidevert"
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
		"ignorezero, avizo"
		"blur, waybar"
		"ignorealpha 0.23, waybar"
		"blurpopups, waybar"
	];

	# Window rules
	windowrule = [
		"float, title:^(.*)(Discord)(.*)$"
		"workspace 4 silent, ^(.*)(Discord)(.*)$"
		"workspace 4 silent, vesktop"
		"workspace 5 silent, ^(Proton VPN)$"
		"tile, title:^(.*)(Discord)(.*)$"
		"float, Secrets"
		"workspace 1 silent, ^(Firefox)(.*)$"
		"workspace 1 silent, ^(.*)(Mozilla Firefox)(.*)$"
		"opacity 0.899 override, title:^(.*)(Discord)(.*)$"
		"workspace 4 silent, title:^(.*)(Discord)(.*)$"
		"move 194 50, title:^(.*)(Discord)(.*)$"
		"float, blueman"
		"float, Windscribe"
		"fullscreen, Xonotic"
		"fullscreen, robloxplayerbeta.exe"
		"fullscreen, ^(Minecraft)(.*)$"
		"immediate, ^(Minecraft)(.*)$"
		"immediate, robloxplayerbeta.exe"
		"immediate, Xonotic"
		"float, title:^(.*)(Discord)(.*)$"
		"size 1531 1019, title:^(.*)(Discord)(.*)$"
		"float, Calculator"
		"float, Nautilus"
		"float, Wike"
		"float, title:^(Network Connections)"
		"float, Usage"
		"float, Characters"
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
		",F8, exec, playerctl previous"
		",F9, exec, playerctl play-pause"
		",F10, exec, playerctl next"
		",F11, fullscreen"
		"$mainMod, Print, exec, $fullscreenss"
		",XF86AudioMute, exec, volumectl -d toggle-mute"
		",XF86AudioMicMute, exec, volumectl -d -m toggle-mute"
		",XF86Calculator, exec, gnome-calculator"
		"SUPER_SHIFT, F, exec, $fullscreenss_silent"
		"SUPER_SHIFT, S, exec, $selectss_silent"
                "SUPER_SHIFT, E, exec, emacs"
		"SUPER_SHIFT, B, exec, firefox"
		"SUPER_SHIFT, D, exec, vesktop"
		"SUPER_SHIFT, C, exec, gnome-characters"

		# Global keybinds
		"SUPER, R, pass, ^(com\.obsproject\.Studio)$"
		"SUPER, P, pass, ^(com\.obsproject\.Studio)$"
		"SUPER, M, pass, ^(com\.obsproject\.Studio)$"
		"SUPER, N, pass, ^(com\.obsproject\.Studio)$"

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
		",XF86AudioLowerVolume, exec, volumectl -d -u down"
		",XF86AudioRaiseVolume, exec, volumectl -d -u up"
		",XF86MonBrightnessDown,exec,lightctl -d down"
		",XF86MonBrightnessUp,exec,lightctl -d up"
	];
    };
  };
}
