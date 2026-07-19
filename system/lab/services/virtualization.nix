{
  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };

    containers.storage.settings = {
      storage = {
        driver = "overlay";
        graphroot = "/pool/containers/storage";
        runroot = "/run/containers/storage";
      };
    };

    oci-containers.containers = {
      debian13 = {
        image = "debian:13";
        autoStart = true;

        cmd = [
          "bash"
          "-c"
          "while true; do if [ -f /grimoire/grimoire ]; then /grimoire/grimoire; else echo 'Waiting for binary...'; fi; sleep 5; done"
        ];

        ports = [ "3010:80" ];
      };
      sherlocked-bot = {
        image = "debian:13";
        autoStart = true;

        cmd = [
          "bash"
          "-c"
          "while true; do if [ -f /sherlocked-bot/src/bot.py ]; then python3 /sherlocked-bot/src/bot.py; else echo 'Waiting for bot'; fi; sleep 5; done"
        ];
      };
    };
  };
}
