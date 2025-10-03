{ pkgs, ... }:
{
  users.users.tray = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "video"
      "libvirtd"
      "input"
      "gamemode"
      "networkmanager"
      "tray"
      "docker"
      "scanner"
      "wireshark"
      "lp"
    ];
    initialPassword = "deinemutteristlecker";
    shell = pkgs.zsh;
  };

  programs.wireshark.enable = true;

  environment = {
    # Launch hyprland upon login (tty1 only)
    loginShellInit = ''
      			[ "$TTY" = /dev/tty1 ] && dbus-run-session Hyprland
      		'';
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
      SDL_VIDEODRIVER = "wayland";
      GDK_BACKEND = "wayland";
      QT_QPA_PLATFORM = "wayland";
      XWAYLAND_NO_GLAMOR = "0";
      __GLX_VENDOR_LIBRARY_NAME = "amd";
      XDG_CURRENT_DESKTOP = "GNOME";
    };
    variables = {
      EDITOR = "nvim";
    };
  };
}
