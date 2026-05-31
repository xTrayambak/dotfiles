{ pkgs, inputs, ... }:
{
  services.pcp = {
    enable = true;
  };

  systemd.services.pmproxy.serviceConfig = {
    RuntimeDirectory = "pcp";
    RuntimeDirectoryMode = "0755";
  };
}
