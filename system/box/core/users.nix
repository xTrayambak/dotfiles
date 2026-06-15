{ config, pkgs, ... }:
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
  programs.hyprland.enable = true;

  environment = {
    # Launch niri upon login (tty1 only)
    loginShellInit = ''
      if [ "$(tty)" = "/dev/tty1" ]; then
        exec ${pkgs.niri}/bin/niri --session
      fi
    '';
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
      SDL_VIDEODRIVER = "wayland";
      GDK_BACKEND = "wayland";
      QT_QPA_PLATFORM = "wayland";
      XWAYLAND_NO_GLAMOR = "0";
      __GLX_VENDOR_LIBRARY_NAME = "amd";
    };
    variables = {
      EDITOR = "nvim";
    };
  };
}
