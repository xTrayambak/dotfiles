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

      ControlPort = 9051;
      CookieAuthentication = true;

      ServerTransportPlugin = {
        transports = [ "obfs4" ];
        exec = "${pkgs.obfs4}/bin/lyrebird";
      };

      ServerTransportListenAddr = "obfs4 0.0.0.0:443";

      ExitRelay = lib.mkForce false;

      RelayBandwidthRate = "20 MBytes";
      RelayBandwidthBurst = "24 MBytes";
    };
  };

  systemd.services.tor.serviceConfig = {
    AmbientCapabilities = [ "CAP_NET_BIND_SERVICE" ];
    CapabilityBoundingSet = [ "CAP_NET_BIND_SERVICE" ];
    NoNewPrivileges = lib.mkForce false;
  };

  environment.systemPackages = with pkgs; [ nyx ];
}
