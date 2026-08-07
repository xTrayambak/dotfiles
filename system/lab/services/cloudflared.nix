{ pkgs, ... }:
let
  personal = "xtrayambak.xyz";
in
{
  services.cloudflared = {
    enable = true;

    tunnels = {
      # void (thevoidclub.in)
      /*
        "c21f6bcb-e2fa-4583-918e-7a6069ce4cbf" = {
          credentialsFile = "/home/tray/.cloudflared/c21f6bcb-e2fa-4583-918e-7a6069ce4cbf.json";
          certificateFile = "/home/tray/.cloudflared/voidcert.pem";
          ingress = {
            # crimSON
            "grimoire.thevoidclub.in" = "http://localhost:3010";
          };
          default = "http_status:404";
        };
      */

      # personal (xtrayambak.xyz)
      "dc2eb3da-46ba-48fe-a641-86a6831754bf" = {
        credentialsFile = "/home/tray/.cloudflared/dc2eb3da-46ba-48fe-a641-86a6831754bf.json";

        certificateFile = "/home/tray/.cloudflared/cert.pem";
        ingress = {
          ## Personal services
          # Forgejo (3000)
          "git.${personal}" = "http://localhost:3000";

          # Uptime Kuma (3001)
          "status.${personal}" = "http://localhost:3001";

          # Redlib (3002)
          # "rl.xtrayambak.xyz" = "http://localhost:3002";

          # Invidious (3004)
          "yt.${personal}" = "http://localhost:3004";

          # traysite (3005)
          "www.${personal}" = "http://localhost:3005";
          "${personal}" = "http://localhost:3005";

          # Cockpit (9090)
          "dash.${personal}" = "http://localhost:9090";

          # Nextcloud (80 because nginx hates me)
          "nc.${personal}" = "http://localhost:80";

          # Navidrome (3007)
          "navi.${personal}" = "http://localhost:3007";

          # OpenWebUI (3008)
          "chat.${personal}" = "http://localhost:3008";

          # SearXNG (3009)
          "search.${personal}" = "http://localhost:3009";

          # WebDAV (3010): my song collection :3
          "dav.${personal}" = "http://localhost:3010";

          # qbittorrent (3011)
          "1337.${personal}" = "http://localhost:3011";
        };
        default = "http_status:404";
      };

    };
  };

  environment.systemPackages = [ pkgs.cloudflared ];
}
