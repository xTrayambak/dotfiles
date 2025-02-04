{ ... }:
{
  imports = [
    ./neovim
    ./emacs
    ./zsh
    ./btop
    ./defaults.nix
    ./gnome-extensions.nix
    ./development
    ./browser
    ./terminal/tools.nix
    
    ./apps.nix
    ./gaming.nix
  ];
}
