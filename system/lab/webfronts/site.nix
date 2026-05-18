{ pkgs, ... }:
let
  rebuildScript = pkgs.writeShellScriptBin "rebuild-traysite" ''
    cd /home/nginx/traysite
    ${pkgs.git}/bin/git pull origin master
    ${pkgs.zola}/bin/zola build --output-dir /home/nginx/.traysite-out --force
  '';
in
{
  systemd = {
    services.traysite = {
      enable = true;
      description = "Zola thingmajig";
      serviceConfig = {
        Type = "oneshot";
        User = "nginx";
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
          port = 3005;
        }
      ];
      root = "/home/nginx/.traysite-out";

      locations."/" = {
        index = "index.html";
        extraConfig = ''
          try_files $uri $uri/index.html =404;
        '';
      };
    };
  };

  systemd.services.nginx.serviceConfig = {
    ProtectHome = false;
  };
}
