{
  services.cockpit = {
    enable = true;
    openFirewall = true;
    port = 9090;
    settings = {
      WebService = {
        AllowUnencrypted = true;
        Origins = "https://dash.xtrayambak.xyz";
        ProtocolHeader = "X-Forwarded-Proto";
      };
      Session = {
        IdleTimeout = 0;
      };
    };
  };
}
