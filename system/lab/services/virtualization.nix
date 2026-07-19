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
          "/bin/bash"
        ];

        ports = [ "3010:80" ];
      };
    };
  };
}
