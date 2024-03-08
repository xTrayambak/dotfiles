{ inputs, username, ... }:
{
  imports = [
    ./neovim/default.nix
    ./zsh/default.nix
    ./btop/default.nix
    ./terminal/tools.nix
    
    ./apps.nix
    ./gaming.nix
    ./nim.nix
    ./rust.nix
    ./git.nix
  ];
}
