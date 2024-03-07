{
  programs.wofi = {
    enable = true;
    settings = {
      allow_images = true;
      width = 400;
      height = 600;
      location = "bottom_center";
      show = "drun";
      prompt = "Search...";
      filter_rate = 128;
      allow_markup = true;
      no_actions = true;
      halign = "fill";
      orientation = "vertical";
      content_halign = "fill";
      insensitive = true;
      image_size = 40;
      gtk_dark = true;
    };
    style = ''
* {
	font-family: JetBrainsMono;
	background: transparent;
}

window {
    margin: 0px;
    border: 5px solid #121212;
    color: rgba(18, 18, 18, 0.4);
    border-radius: 50px;
    font-family: JetBrainsMono;
}

#input {
    padding: 4px;
    margin: 4px;
    padding-left: 20px;
    border: none;
    font-weight: bold;
    color: #fff;
    background-color: #121212;
    background: #121212;
    outline: none;
    border-radius: 15px;
    margin: 10px;
    margin-bottom: 2px;
}

#input:focus {
    border: 0px solid #fff;
    margin-bottom: 0px;
}

#inner-box {
    margin: 8px;
    border: 10px solid #121212;
    color: #eceff4;
    font-weight: bold;
    background-color: #121212;
    border-radius: 15px;
}

#outer-box {
    margin: 0px;
    border: none;
    border-radius: 15px;
    background-color: #121212;
}

#scroll {
    margin-top: 5px;
    border: none;
    border-radius: 15px;
    margin-bottom: 5px;
}

#text:selected {
    color: #fff;
    margin: 0px 0px;
    border: none;
    border-radius: 15px;
}

#entry {
    margin: 0px 0px;
    border: none;
    border-radius: 5px;
    background-color: transparent;
}

#entry:selected {
    margin: 0px 0px;
    border: none;
    border-radius: 5px;
    background: #212121;
}
    '';
  };
}
