{ ... }:
{
  services.navidrome = {
    enable = true;
    settings = {
      Port = 3007;
      Address = "localhost";
      MusicFolder = "/pool/navidrome";
      EnableInsightsCollector = true; # help your local OSS project! ;)
    };
  };
}
