{ inputs, username, ... }:
{
  imports = [
    ./neovim
    ./zsh
    ./btop
    ./terminal/tools.nix
    
    ./apps.nix
    ./gaming.nix
    ./nim.nix
    ./rust.nix
    ./git.nix
  ];
}
