{ lib, pkgs, ... }:
{
  /*
    services.tor = {
      enable = true;
      relay = {
        enable = true;
        role = "relay";
      };
      settings = {
        Nickname = "FriendsOfDorothy";
        ORPort = 9001;

        ControlPort = 9051;
        CookieAuthentication = true;

        # AssumeReachable = true;
        ExitRelay = lib.mkForce false;

        RelayBandwidthRate = "20 MBytes";
        RelayBandwidthBurst = "24 MBytes";
      };
    };
  */

  services.snowflake-proxy = {
    enable = true;
    capacity = 0;
  };

  environment.systemPackages = with pkgs; [ nyx ];
}
