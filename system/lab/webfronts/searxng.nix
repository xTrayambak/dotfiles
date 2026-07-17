{ pkgs, ... }: {
  services.searx = {
    enable = true;
    package = pkgs.searxng;
    redisCreateLocally = false;
    settings = {
      server = {
        port = 3009;
        bind_address = "localhost";
      };
    };
  };
}
