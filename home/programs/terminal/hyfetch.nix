{ pkgs, ... }: {
  home.packages = with pkgs; [ hyfetch ];

  xdg.configFile."hyfetch.json".source = ./hyfetch.json;
}
