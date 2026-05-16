{ pkgs, ... }:
{
  services.cloudflared = {
    enable = true;
    certificateFile = "/home/tray/.cloudflared/cert.pem";

    tunnels = {
      "dc2eb3da-46ba-48fe-a641-86a6831754bf" = {
        credentialsFile = "/home/tray/.cloudflared/dc2eb3da-46ba-48fe-a641-86a6831754bf.json";
        ingress = {
          "git.xtrayambak.xyz" = "http://localhost:3000";
          "status.xtrayambak.xyz" = "http://localhost:3001";
          "nc.xtrayambak.xyz" = "http://localhost:80";
        };
        default = "http_status:404";
      };
    };
  };

  environment.systemPackages = [ pkgs.cloudflared ];
}
