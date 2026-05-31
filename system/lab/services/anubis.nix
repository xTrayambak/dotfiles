{ ... }:
{
  services.anubis = {
    instances = {
      forgejo = {
        enable = true;
        settings = {
          TARGET = "http://localhost:3007";
          REDIRECT_DOMAINS = "git.xtrayambak.xyz";
          PUBLIC_URL = "https://git.xtrayambak.xyz";
          COOKIE_DOMAIN = "git.xtrayambak.xyz";

          BIND_NETWORK = "tcp";
          BIND = "localhost:3000";

          DIFFICULTY = 5;
        };
      };
    };
  };
}
