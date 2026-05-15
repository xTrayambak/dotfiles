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
    signing.format = "openpgp";
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

  home.packages = [ pkgs.forgejo-cli ];

  imports = lib.filter lib.pathExists [ ../../private.nix ];
}
