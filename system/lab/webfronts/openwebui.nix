{ ... }: {
  nixpkgs.overlays = [
    (final: prev: {
      ctranslate2 = prev.ctranslate2.overrideAttrs (oldAttrs: {
        src = oldAttrs.src.overrideAttrs (_: {
          outputHash = "sha256-cchwv+esysn/0v6RqD5zp306HfzOjjlCxH5usLETXs0=";
        });
      });

      pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
        (python-final: python-prev: {
          langgraph = python-prev.langgraph.overridePythonAttrs (oldAttrs: {
            doCheck = false;
          });
        })
      ];
    })
  ];

  services.open-webui = {
    enable = true;
    host = "localhost";
    port = 3008;
    stateDir = "/pool/openwebui";
    environment = {
      ANONYMIZED_TELEMETRY = "False";
      DO_NOT_TRACK = "True";
      SCARF_NO_ANALYTICS = "True";
    };
  };

  systemd.services.open-webui.serviceConfig = {
    ReadWritePaths = [ "/pool" ];
  };
}
