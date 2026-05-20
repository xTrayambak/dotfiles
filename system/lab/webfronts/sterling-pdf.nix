{ ... }:
{
  services.stirling-pdf = {
    enable = true;
    environment = {
      LANGS = "en_GB";
      SECURITY_ENABLELOGIN = "true";
      SYSTEM_MAXFILESIZE = 2000;
      SERVER_PORT = 3007;
    };
  };
}
