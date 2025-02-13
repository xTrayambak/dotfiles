{ ... }:
{
  imports = [
    ./neovim
    ./emacs
    ./zsh
    ./btop
    ./defaults.nix
    ./development
    ./browser
    ./terminal/tools.nix
    
    ./apps.nix
    ./gaming.nix
  ];
}
