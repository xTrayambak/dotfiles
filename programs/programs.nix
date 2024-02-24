{ inputs, username, ... }:
{
  imports = [
    ./neovim/default.nix
    ./zsh/default.nix

    ./nim.nix
    ./tools.nix
    ./git.nix
  ];
}
