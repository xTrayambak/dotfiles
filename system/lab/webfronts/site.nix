{ pkgs, ... }:
let
  rebuildScript = pkgs.writeShellScriptBin "rebuild-traysite" ''
    cd /home/zola/.traysite
    ${pkgs.git}/bin/git pull origin main
    ${pkgs.zola}/bin/zola build --output-dir /home/zola/.traysite-out --force
  '';
in
{
  systemd = {
    services.traysite = {
      enable = true;
      description = "Zola thingmajig";
      serviceConfig = {
        Type = "oneshot";
        User = "zola";
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
      root = "/home/zola/.traysite-out";

      locations."/" = {
        index = "index.html";
        extraConfig = ''
          try_files $uri $uri/index.html =404;
        '';
      };
    };
  };

  systemd.tmpfiles.rules = [
    "a+ /home/zola - - - - u:nginx:x"
    "A+ /home/zola/.traysite-out - - - - u:nginx:X,g:nginx:X,d:u:nginx:rX,d:g:nginx:rX"
  ];

  systemd.services.nginx.serviceConfig.User = "zola";
  systemd.services.nginx.serviceConfig.ProtectHome = "read-only";
}
