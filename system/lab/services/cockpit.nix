{ lib }:
{
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
  };
}
