{ pkgs, ... }:
{
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        namespace = "fuzzel";
        font = "JetBrains Mono:size=16";
        use-bold = "yes";
        placeholder = "Search";
        icons-enabled = true;
        match-mode = "fuzzy";
        terminal = "${pkgs.wezterm}/bin/wezterm";
        anchor = "center";
        layer = "overlay";
        prompt = " ";
        keyboard-focus = "exclusive";
        render-workers = 12;
        match-workers = 12;
        image-size-ratio = 1;
        gamma-correct = "yes";
      };

      colors = {
        background = "12121266";
        text = "FFFFFFFF";
        selection-text = "D3D3D3FF";
        border = "00000000";
        selection = "1A1A1A80";
      };

      border = {
        width = 0;
        radius = 24;
      };
    };
  };
}
