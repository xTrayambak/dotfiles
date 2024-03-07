{ inputs, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    avizo
    grim
    slurp
    swww
  ];
  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = ''
monitor=,preferred,auto,1
env = GTK_THEME,Adwaita-dark
# env = WLR_DRM_DEVICES,/dev/dri/card0 # use my iGPU

misc {
	disable_hyprland_logo = yes
}

input {
    kb_layout = us
    kb_variant =
    kb_model =
    kb_options =
    kb_rules =
    accel_profile = adaptive

    follow_mouse = 1

    touchpad {
        natural_scroll = true
        tap-to-click = true
        disable_while_typing = false
    }

    sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
}

general {
    # See https://wiki.hyprland.org/Configuring/Variables/ for more
    monitor = ,preferred,auto,1
    gaps_in = 5
    gaps_out = 20
    border_size = 2
    col.active_border = rgba(595959aa)
    col.inactive_border = rgba(595959aa)

    layout = dwindle
}

decoration {
    # How much to make the windows rounded? #
    rounding = 16

    blur {
	enabled = true
	size = 8
	passes = 2
	popups = true
    }

    # Opacity for focused window  #
    # Not my taste to modify this #
    active_opacity = 1.0

    # Opacity for fullscreen window #
    # Not my taste to modify this   #
    fullscreen_opacity = 1.0
    
    
    # Drop shadows? #
    drop_shadow = yes

    # The range of the shadows #
    shadow_range = 4

    # Rendering power of shadows #
    shadow_render_power = 3

    # Shadow color #
    col.shadow = rgba(0b0e07d1)
}

animations {
    enabled = yes

    bezier = myBezier, 0.05, 0.9, 0.1, 1.05

    animation = windows, 1, 5, myBezier
    animation = windowsOut, 1, 5, default, popin 80%
    animation = border, 1, 10, default
    animation = borderangle, 1, 8, default
    animation = fade, 1, 7, default
    animation = workspaces, 1, 5, default
    animation = specialWorkspace, 1, 5, myBezier, slidevert
}

dwindle {
    # Enable pseudotiling? #
    pseudotile = no

    # Preserve splitting?  #
    preserve_split = yes
}

master {
    new_is_master = true
}

gestures {
    workspace_swipe = on
    workspace_swipe_fingers = 3
}

# Window rules
# Discord
windowrule = float, title:^(ArmCord)$                   # Make "Loading" screen float
windowrule = workspace 4 silent, ^(ArmCord)$            # Move ArmCord to workspace 4
windowrule = tile, title:^(.*)( - ArmCord)$             # Make the main ArmCord window tile

# wofi, avizo and mako
# become less opaque
layerrule = blur, wofi
layerrule = blur, mako
layerrule = ignorealpha 0.0, mako
layerrule = blur, avizo

layerrule = blur, waybar
layerrule = ignorealpha 0.3, waybar

# KeepassXC
# Float
windowrule = float, KeePassXC

# LibreWolf
windowrule = workspace 1 silent, librewolf
# workspace 2&3 are for my terminal and/or games

# Armcord
windowrule = opacity 0.899 override, armcord
windowrule = workspace 4, armcord

# iwgtk
windowrule = float, iwgtk

# blueman
windowrule = float, blueman

# windscribe
windowrule = float, Windscribe

# roadblocks
windowrule = fullscreen, robloxplayerbeta.exe

# minecraft
windowrule = fullscreen, ^(Minecraft)(.*)$

# guh nome calculator
windowrule = float, Calculator

# See https://wiki.hyprland.org/Configuring/Keywords/ for more
$mainMod       = SUPER
$term          = foot
$calculator    = foot --title python3 -e python3 
$quickrecorder = flatpak run io.github.seadve.Kooha
$fullscreenss  = $HOME/.scripts/screenshot full
$selectss      = $HOME/.scripts/screenshot select
$screenlock    = $HOME/.scripts/locker
$applauncher   = wofi -H 480 -W 640

# Mouse binds
bindm=SUPER, mouse:272, movewindow
bindm=SUPER, mouse:273, resizewindow

# Window controls
bind = SUPER, Tab, cyclenext
bind = SUPER_SHIFT, Tab, swapnext

# Start terminal
bind = SUPER, T, exec, $term
bind = SUPER, Return, exec, $term

# Kill focused window #
# SUPER + SHIFT + T   #
bind = SUPER_SHIFT, T, killactive

# Reload Hyprland   #
# SUPER + SHIFT + R #
bind = SUPER_SHIFT, R, exec, hyprctl reload

# Force kill window #
# SUPER + ALT + T   #
bind = SUPER_ALT, T, exec, hyprctl kill

# Toggle floating parameter on focused window #
#                  SUPER + V                  # 
bind = SUPER, V, togglefloating

# Start Wofi (application manager) #
#         SUPER + D                #
bind = SUPER, D, exec, $applauncher

# Take region-selection screenshot #
#           PrintScreen            #
bind = ,Print, exec, $selectss

# Start Swaylock #
#  SUPER+L       #
bind = $mainMod, L, exec, $screenlock

# Media Controls #
# F8  - Previous #
# F9  - Pause    #
# F10 - Next     #
bind = ,F8, exec, playerctl previous
bind = ,F9, exec, playerctl play-pause
bind = ,F10, exec, playerctl next

# Toggle fullscreen #
#       F11         #
bind = ,F11, fullscreen

# Screenshot the entire screen #
#   SUPER+Print     #
bind = $mainMod, Print, exec, $fullscreenss

# Audio Controls -- Lower, Raise, Mute #
# Volume Lower Button (eg. F6),       #
# Volume Raise Button (eg. F7),       #
# Volume Mute Button (eg. F5)         #
bind = ,XF86AudioLowerVolume, exec, volumectl -u down
bind = ,XF86AudioRaiseVolume, exec, volumectl -u up
bind = ,XF86AudioMute, exec, volumectl toggle-mute
bind = ,XF86AudioMicMute, exec, volumectl -m toggle-mute

# Calculator #
bind = ,XF86Calculator, exec, flatpak run org.gnome.Calculator

# Brightness Controls -- Lower, Raise #
# These may vary from model to model, #
# but since generic XF86 keybinds are #
# being used, it shouldn't matter     #
bind=,XF86MonBrightnessDown,exec,lightctl down
bind=,XF86MonBrightnessUp,exec,lightctl up

# Workspace Controls -- [0 - 9] #
#       SUPER + [0-9]           #
bind = $mainMod, 1, workspace, 1
bind = $mainMod, 2, workspace, 2
bind = $mainMod, 3, workspace, 3
bind = $mainMod, 4, workspace, 4
bind = $mainMod, 5, workspace, 5
bind = $mainMod, 6, workspace, 6
bind = $mainMod, 7, workspace, 7
bind = $mainMod, 8, workspace, 8
bind = $mainMod, 9, workspace, 9
bind = $mainMod, 0, workspace, 10

# Move Active Window to Another Workspace
bind = $mainMod SHIFT, 1, movetoworkspace, 1
bind = $mainMod SHIFT, 2, movetoworkspace, 2
bind = $mainMod SHIFT, 3, movetoworkspace, 3
bind = $mainMod SHIFT, 4, movetoworkspace, 4
bind = $mainMod SHIFT, 5, movetoworkspace, 5
bind = $mainMod SHIFT, 6, movetoworkspace, 6
bind = $mainMod SHIFT, 7, movetoworkspace, 7
bind = $mainMod SHIFT, 8, movetoworkspace, 8
bind = $mainMod SHIFT, 9, movetoworkspace, 9
bind = $mainMod SHIFT, 0, movetoworkspace, 10

# Toggle recording
bind = $mainMod, F10, pass, ^(OBS Studio)$

# Execute stuff
exec      = swww init
exec-once = ~/.scripts/wallpaper
exec-once = waybar
exec-once = /usr/libexec/polkit-gnome-authentication-agent-1 
exec-once = emacs --daemon
exec-once = discover-overlay
exec-once = mako
exec-once = avizo-service
exec-once = nm-applet
    '';
  };
}
