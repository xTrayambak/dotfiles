{ ... }:
{
  imports = [
    ./neovim
    ./browser
    ./btop
    ./development
    ./defaults.nix
    ./terminal/tools.nix
    ./zsh

    ./apps.nix
    ./gaming.nix
  ];
}
