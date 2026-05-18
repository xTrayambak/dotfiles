{ ... }:
let
  invidiousCompanionSecret = "iHa7riebeigeex6X";
in
{
  services.invidious = {
    enable = true;
    domain = "yt.xtrayambak.xyz";
    port = 3004;

    http3-ytproxy.enable = true;

    database = {
      createLocally = true;
    };

    extraSettingsFile = ./invidious.yml;
    settings.invidious_companion_key = invidiousCompanionSecret;
    sig-helper.enable = false; # Deprecated
  };

  virtualisation.oci-containers = {
    backend = "podman";
    containers = {
      invidious-companion = {
        image = "quay.io/invidious/invidious-companion:latest";
        ports = [ "127.0.0.1:8282:8282" ];
        volumes = [
          "companioncache:/var/tmp/youtubei.js:rw"
        ];
        environment = {
          # Same as configured on invidious above.
          SERVER_SECRET_KEY = invidiousCompanionSecret;
        };
      };
    };
  };
}
