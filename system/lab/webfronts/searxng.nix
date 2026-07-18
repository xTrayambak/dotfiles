{ config, pkgs, ... }:
{
  age.secrets.searxng = {
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
    environmentFile = config.age.secrets.searxng.path;
  };
}
