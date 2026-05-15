{ pkgs, ... }:
let
  rebuildScript = pkgs.writeShellScriptBin "rebuild-traysite" ''
    cd /home/tray/.traysite
    ${pkgs.git}/bin/git pull origin main
    ${pkgs.zola}/bin/zola build --output-dir /home/tray/.traysite-out
  '';
in
{
  systemd = {
    services.traysite = {
      enable = true;
      description = "Zola thingmajig";
      serviceConfig = {
        Type = "oneshot";
        User = "tray";
        ExecStart = "${rebuildScript}/bin/rebuild-traysite";
      };
    };

    timers.rebuild-traysite = {
      wantedBy = [ "timers.target" ];
      timerConfig = {
        OnBootSec = "1m";
        OnUnitActiveSec = "10m";
        Unit = "rebuild-traysite.service";
      };
    };
  };

  services.nginx = {
    enable = true;
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;

    virtualHosts."xtrayambak.xyz" = {
      listen = [
        {
          addr = "127.0.0.1";
          port = 8080;
        }
      ];
      root = "/home/tray/.traysite-out";

      locations."/" = {
        index = "index.html";
        extraConfig = ''
          try_files $uri $uri/index.html =404;
        '';
      };
    };
  };
}
