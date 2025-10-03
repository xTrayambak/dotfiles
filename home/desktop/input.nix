{ pkgs, ... }:
{
  i18n = {
    inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5 = {
        waylandFrontend = true;
        settings = {
          inputMethod = {
            "Groups/0/Items/0".Name = "keyboard-us";
            "Groups/0/Items/1".Name = "m17n-hindi-itrans";
          };
        };
        addons = with pkgs; [
          fcitx5-m17n
        ];
      };
    };
  };

  home.packages = with pkgs; [
    fcitx5-m17n
    m17n_db
    m17n_lib
  ];
}
