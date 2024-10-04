{
  programs.wofi = {
    enable = true;
    settings = {
      allow_images = true;
      width = 400;
      height = 600;
      location = "bottom_center";
      show = "drun";
      prompt = "Search";
      filter_rate = 128;
      layer = "overlay";
      allow_markup = true;
      no_actions = true;
      halign = "fill";
      matching = "fuzzy";
      orientation = "vertical";
      content_halign = "fill";
      insensitive = true;
      image_size = 40;
      gtk_dark = true;
    };
    style = builtins.readFile ./style.css;
  };
}
