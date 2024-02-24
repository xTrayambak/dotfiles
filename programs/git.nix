{ inputs, lib, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "xTrayambak";
    userEmail = "xtrayambak@gmail.com";
  };

  programs.gh = {
    enable = true;
    settings = {
      editor = "nvim";
      git_protocol = "ssh";
    };
  };

  imports = lib.filter lib.pathExists [ ../private.nix ];
}
