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
  };
}
