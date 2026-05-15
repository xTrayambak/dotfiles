{ ... }:
{
  imports = [
    ./neovim
    ./browser
    ./emacs
    ./btop
    ./development
    ./terminal/tools.nix
    ./zsh

    ./apps.nix
    ./gaming.nix
  ];
}
