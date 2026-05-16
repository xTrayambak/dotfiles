{ lib, pkgs, ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "tray";
        email = "xtrayambak@gmail.com";
      };
    };
    settings = {
      credential.helper = "${pkgs.gitFull}/bin/git-credential-libsecret";
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
