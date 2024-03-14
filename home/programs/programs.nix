{ inputs, username, ... }:
{
  imports = [
    ./neovim
    ./zsh
    ./btop
    ./development
    ./browser
    ./terminal/tools.nix
    
    ./apps.nix
    ./gaming.nix
  ];
}
