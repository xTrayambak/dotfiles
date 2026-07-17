{ config, pkgs, ... }:
let
  environmentFile = pkgs.writeText "env" ''
    SEARXNG_SECRET_KEY_FILE=${config.age.secrets.searxng.path}
  '';
in
{
  age.secrets.playit-secret = {
    file = ../../../secrets/searxng.age;
  };

  services.searx = {
    enable = true;
    package = pkgs.searxng;
    redisCreateLocally = false;
    settings = {
      server = {
        port = 3009;
        bind_address = "localhost";
      };
    };
    environmentFile = environmentFile;
  };
}
