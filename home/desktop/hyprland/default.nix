{ config, inputs, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    grim
    slurp
    swww
    networkmanagerapplet
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

	# Config begins from here

	# Monitor configuration (1920x1080 display at 144FPS)
	monitor = [
		",preferred,auto,1"
		"eDP-1,1920x1080@144,0x0,1"
	];
	
	# Start my bar, wallpaper applier + wallpaper script, notification daemon, OSD and networkmanager applet
	exec-once = [
		"waybar"
		"swww init"
		"/home/${config.home.username}/.scripts/wallpaper"
		"mako"
		"avizo-service"
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
		bezier = [ "myBezier, 0.05, 0.9, 0.1, 1.05" ];
		animation = [
			"windows, 1, 5, myBezier"
			"windowsOut, 1, 5, default, popin 80%"
			"border, 1, 10, default"
			"borderangle, 1, 8, default"
			"fade, 1, 7, default"
			"workspaces, 1, 5, default"
			"specialWorkspace, 1, 5, myBezier, slidevert"
		];
	};

	dwindle = {
		pseudotile = false;
		preserve_split = true;
	};

	master.new_is_master = true;

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
		"blur, avizo"
		"ignorezero, avizo"
		"blur, waybar"
		"ignorealpha 0.23, waybar"
	];

	# Window rules
	windowrule = [
		"float, title:^(ArmCord)$"
		"workspace 4 silent, ^(ArmCord)$"
		"tile, title:^(.*)( - ArmCord)$"
		"float, KeePassXC"
		"workspace 1 silent, librewolf"
		"workspace 1 silent, ^(.*)( Mozilla Firefox)$"
		"opacity 0.921 override, title:^(.*)( - ArmCord)$"
		"workspace 4 silent, title:^(.*)( - ArmCord)$"
		"float, blueman"
		"float, Windscribe"
		"fullscreen, robloxplayerbeta.exe"
		"fullscreen, ^(Minecraft)(.*)$"
		"float, Calculator"
		"float, Nautilus"
		"size 1324,805, Nautilus"
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
		",XF86AudioMute, exec, volumectl toggle-mute"
		",XF86AudioMicMute, exec, volumectl -m toggle-mute"
		",XF86Calculator, exec, gnome-calculator"

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
		",XF86AudioLowerVolume, exec, volumectl -u down"
		",XF86AudioRaiseVolume, exec, volumectl -u up"
		",XF86MonBrightnessDown,exec,lightctl down"
		",XF86MonBrightnessUp,exec,lightctl up"
	];
    };
  };
}
