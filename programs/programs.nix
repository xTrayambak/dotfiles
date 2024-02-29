{ inputs, username, ... }:
{
  imports = [
    ./neovim/default.nix
    ./zsh/default.nix
    ./btop/default.nix

    ./nim.nix
    ./rust.nix
    ./tools.nix
    ./git.nix
  ];
}
