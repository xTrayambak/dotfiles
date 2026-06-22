{ lib, pkgs, ... }:
{
  services.tor = {
    enable = true;
    relay = {
      enable = true;
      role = "bridge";
    };
    settings = {
      Nickname = "FriendsOfDorothy";
      ORPort = 9001;

      ServerTransportPlugin = "obfs4 exec ${pkgs.lyrebird}/bin/lyrebird";
      ServerTransportListenAddr = "obfs4 0.0.0.0:443";

      ExitRelay = lib.mkForce false;

      RelayBandwidthRate = "20 MBytes";
      RelayBandwidthBurst = "24 MBytes";
    };
  };

  environment.systemPackages = with pkgs; [ nyx ];
}
