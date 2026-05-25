{ ... }:
{
  imports = [
    ./neovim
    ./browser
    ./emacs
    ./btop
    ./development
    ./defaults.nix
    ./terminal/tools.nix
    ./zsh

    ./apps.nix
    ./gaming.nix
  ];
}
