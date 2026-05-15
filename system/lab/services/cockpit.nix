{
  services.cockpit = {
    enable = true;
    openFirewall = true;
    port = 9090;
    settings = {
      WebService = {
        AllowUnencrypted = true;
        ProtocolHeader = "X-Forwarded-Proto";
      };
      Session = {
        IdleTimeout = 0;
        Banner = "/etc/issue";
      };
    };
  };
}
