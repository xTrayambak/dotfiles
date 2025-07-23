{ lib, pkgs, ... }:

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
    };
    gitCredentialHelper = {
      enable = true;
    };
  };

  imports = lib.filter lib.pathExists [ ../../private.nix ];
}
