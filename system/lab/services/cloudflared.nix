{ pkgs, ... }:
{
  services.cloudflared = {
    enable = true;
    certificateFile = "/home/tray/.cloudflared/cert.pem";
  };

  environment.systemPackages = [ pkgs.cloudflared ];
}
