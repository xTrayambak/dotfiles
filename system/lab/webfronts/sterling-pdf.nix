{ ... }:
{
  services.stirling-pdf = {
    enable = false;
    environment = {
      LANGS = "en_GB";
      SECURITY_ENABLELOGIN = "true";
      SYSTEM_MAXFILESIZE = 2000;
      SERVER_PORT = 3007;
    };
  };
}
