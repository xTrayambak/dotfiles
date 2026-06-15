{ ... }:
{
  services.navidrome = {
    enable = true;
    settings = {
      Port = 3007;
      Address = "localhost";
      EnableInsightsCollector = true; # help your local OSS project! ;)
    };
  };
}
