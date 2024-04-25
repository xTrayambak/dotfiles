{ inputs, username, ... }:
{
  imports = [
    ./neovim
    ./emacs
    ./zsh
    ./btop
    ./development
    ./browser
    ./terminal/tools.nix
    
    ./apps.nix
    ./gaming.nix
  ];
}
