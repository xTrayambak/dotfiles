{ pkgs, lib, ... }: let
  mod = "Mod4";
in {
  wayland.windowManager.sway = {
    enable = true;
    config = {
      keybindings = {
        "${mod}+Return" = "exec --no-startup-id ${pkgs.wezterm}/bin/wezterm-gui";
      };
    };
  };
}
