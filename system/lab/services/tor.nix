{ lib, pkgs, ... }:
{
  security.wrappers.lyrebird = {
    source = "${pkgs.obfs4}/bin/lyrebird";
    capabilities = "cap_net_bind_service+ep";
    owner = "root";
    group = "root";
  };

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
        exec = "/run/wrappers/bin/lyrebird";
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
