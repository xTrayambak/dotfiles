{ config, pkgs, ... }:
{
  services.navidrome = {
    enable = true;
    settings = {
      Port = 3007;
      Address = "localhost";

      MusicFolder = "/pool/navidrome/songs";
      CacheFolder = "/pool/navidrome/cache";

      Agents = "apple-music,deezer,lastfm,listenbrainz";

      EnableInsightsCollector = true; # help your local OSS project! ;)
    };
    plugins = with pkgs.navidromePlugins; [
      apple-music
    ];
  };

  age.secrets.webdav = {
    file = ../../../secrets/webdav.age;
    owner = "navidrome";
    group = "navidrome";
    mode = "0400";
  };

  services.webdav = {
    enable = true;
    user = "navidrome";
    group = "navidrome";
    environmentFile = config.age.secrets.webdav.path;
    settings = {
      address = "localhost";
      port = 3010;
      directory = "/pool/navidrome/songs";
      permissions = "RW";
      users = [
        {
          username = "{env}USERNAME";
          password = "{env}PASSWORD";
        }
      ];
    };
  };
}
