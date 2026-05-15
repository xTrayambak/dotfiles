{
  services.cockpit = {
    enable = false;
    openFirewall = true;
    port = 9090;
    settings = {
      WebService = {
        AllowUnencrypted = true;
        ProtocolHeader = "X-Forwarded-Proto";
      };
      Session = {
        IdleTimeout = 0;
      };
    };
  };
}
