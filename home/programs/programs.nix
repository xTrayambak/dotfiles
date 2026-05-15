{ ... }:
{
  imports = [
    ./neovim
    ./emacs
    ./btop
    ./development
    ./terminal/tools.nix

    ./apps.nix
    ./gaming.nix
  ];
}
