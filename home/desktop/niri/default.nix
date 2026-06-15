{
  config,
  inputs,
  pkgs,
  ...
}:
let
  inherit (inputs.niri.lib.kdl)
    node
    plain
    leaf
    flag
    ;
in
{
  imports = [
    inputs.niri.homeModules.config
  ];

  nixpkgs.overlays = [ inputs.niri.overlays.niri ];

  programs.niri = {
    package = pkgs.niri;

    config = builtins.readFile ./config.kdl;

    /*
      settings = {
        layout = {
          focus-ring = {
            width = 3;
          };

          border.enable = false;
        };

        spawn-at-startup = [
          { argv = [ "waybar" ]; }
          { argv = [ "awww-daemon" ]; }
        ];

        input = {
          focus-follows-mouse.enable = true;
        };

        binds = with config.lib.niri.actions; {
          # Spawners
          "Mod+T".action = spawn "wezterm";
          "Mod+Return".action = spawn "wezterm";
          "Mod+D".action = spawn "fuzzel";
          "Mod+L".action = spawn "${inputs.self.packages.${pkgs.system}.scripts}/bin/locker";

          # Movement
          "Mod+WheelScrollDown".action = focus-workspace-down;
          "Mod+WheelScrollUp".action = focus-workspace-up;
          "Mod+Shift+WheelScrollDown".action = move-window-to-workspace-down;
          "Mod+Shift+WheelScrollUp".action = move-window-to-workspace-up;

          # Window binds
          "Mod+V".action = toggle-window-floating;
          "Mod+Shift+A".action = swap-window-left;
          "Mod+Shift+S".action = swap-window-right;
          "Mod+Shift+Q".action = close-window;
          "F11".action = fullscreen-window;

          # Misc
          "Mod+W".action = toggle-overview;
        };

        outputs = {
          "eDP-1" = {
            scale = 1.0;
          };
        };
      };
    */
  };
}
