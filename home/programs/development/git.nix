{ lib, pkgs, ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "xTrayambak";
        email = "xtrayambak@gmail.com";
      };
    };
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
