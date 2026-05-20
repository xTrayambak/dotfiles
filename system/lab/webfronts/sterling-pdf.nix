{ ... }:
{
  services.stirling-pdf = {
    enable = true;
    environment = {
      LANGS = "en_GB";
      SECURITY_ENABLELOGIN = "true";
      SECURITY_INITIALLOGIN_USERNAME = "admin";
      SECURITY_INITIALLOGIN_PASSWORD = "flyingfishes1337";
      SYSTEM_MAXFILESIZE = 2000;
      SERVER_PORT = 3007;
    };
  };
}
