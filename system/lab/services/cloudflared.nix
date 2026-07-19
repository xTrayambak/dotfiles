{ pkgs, ... }:
{
  services.cloudflared = {
    enable = true;

    tunnels = {
      # void (thevoidclub.in)
      "c21f6bcb-e2fa-4583-918e-7a6069ce4cbf" = {
        credentialsFile = "/home/tray/.cloudflared/c21f6bcb-e2fa-4583-918e-7a6069ce4cbf.json";
        certificateFile = "/home/tray/.cloudflared/voidcert.pem";
        ingress = {
          # crimSON
          "grimoire.thevoidclub.in" = "http://localhost:3010";
        };
      };

      # personal (xtrayambak.xyz)
      "dc2eb3da-46ba-48fe-a641-86a6831754bf" = {
        credentialsFile = "/home/tray/.cloudflared/dc2eb3da-46ba-48fe-a641-86a6831754bf.json";

        certificateFile = "/home/tray/.cloudflared/cert.pem";
        ingress = {
          ## Personal services
          # Forgejo (3000)
          "git.xtrayambak.xyz" = "http://localhost:3000";

          # Uptime Kuma (3001)
          "status.xtrayambak.xyz" = "http://localhost:3001";

          # Redlib (3002)
          # "rl.xtrayambak.xyz" = "http://localhost:3002";

          # Invidious (3004)
          "yt.xtrayambak.xyz" = "http://localhost:3004";

          # traysite (3005)
          "www.xtrayambak.xyz" = "http://localhost:3005";
          "xtrayambak.xyz" = "http://localhost:3005";

          # Cockpit (9090)
          "dash.xtrayambak.xyz" = "http://localhost:9090";

          # Nextcloud (80 because nginx hates me)
          "nc.xtrayambak.xyz" = "http://localhost:80";

          # Navidrome (3007)
          "navi.xtrayambak.xyz" = "http://localhost:3007";

          # OpenWebUI (3008)
          "chat.xtrayambak.xyz" = "http://localhost:3008";

          # SearXNG (3009)
          "search.xtrayambak.xyz" = "http://localhost:3009";
        };
        default = "http_status:404";
      };

    };
  };

  environment.systemPackages = [ pkgs.cloudflared ];
}
