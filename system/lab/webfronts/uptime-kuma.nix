{ ... }:
{
  services.uptime-kuma = {
    enable = true;

    settings = {
      HOST = "127.0.0.1";
      PORT = "3001";
    };
  };

  systemd.tmpfiles.rules = [
    "d /var/lib/uptime-kuma 0700 uptime-kuma uptime-kuma - -"
  ];
}
