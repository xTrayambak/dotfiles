{ lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    lm_sensors
  ];

  services.cockpit = {
    enable = true;
    openFirewall = true;
    settings = {
      WebService = {
        AllowUnencrypted = true;
        Origins = lib.mkForce "https://dash.xtrayambak.xyz";
        ProtocolHeader = "X-Forwarded-Proto";
      };
      Session = {
        IdleTimeout = 0;
      };
    };
    plugins = with pkgs; [
      cockpit-podman
      cockpit-machines
    ];
  };
}
