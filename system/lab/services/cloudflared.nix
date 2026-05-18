{ pkgs, ... }:
{
  services.cloudflared = {
    enable = true;
    certificateFile = "/home/tray/.cloudflared/cert.pem";

    tunnels = {
      "dc2eb3da-46ba-48fe-a641-86a6831754bf" = {
        credentialsFile = "/home/tray/.cloudflared/dc2eb3da-46ba-48fe-a641-86a6831754bf.json";
        ingress = {
          ## Personal services
          # Forgejo (3000)
          "git.xtrayambak.xyz" = "http://localhost:3000";

          # Uptime Kuma (3001)
          "status.xtrayambak.xyz" = "http://localhost:3001";

          # Redlib (3002)
          # "rl.xtrayambak.xyz" = "http://localhost:3002";

          # Chhoto (3003)
          # "links.xtrayambak.xyz" = "http://localhost:3003";

          # Invidious (3004)
          "yt.xtrayambak.xyz" = "http://localhost:3004";

          # traysite (3005)
          "www.xtrayambak.xyz" = "http://localhost:3005";
          "xtrayambak.xyz" = "http://localhost:3005";

          # Nextcloud (80 because nginx hates me)
          "nc.xtrayambak.xyz" = "http://localhost:80";
        };
        default = "http_status:404";
      };
    };
  };

  environment.systemPackages = [ pkgs.cloudflared ];
}
