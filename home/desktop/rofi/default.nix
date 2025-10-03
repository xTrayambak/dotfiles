{ pkgs, ... }:
{
  xdg.configFile = {
    "rofi/config.rasi".source = ./config.rasi;
    "rofi/fonts.rasi".source = ./fonts.rasi;
    "rofi/colors.rasi".source = ./colors.rasi;
  };
  home.packages = with pkgs; [
    rofi
  ];
}
