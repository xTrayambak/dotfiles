{ ... }:
{
  services.redlib = {
    enable = true;
    address = "localhost";
    port = 3002;
    settings = {
      BANNER = "tray's redlib instance";
      ROBOTS_DISABLE_INDEXING = "off";
      ENABLE_RSS = "on";
      FULL_URL = "rl.xtrayambak.xyz"; # idk if this is what it means
    };
  };
}
