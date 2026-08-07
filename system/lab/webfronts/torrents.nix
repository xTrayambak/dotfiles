{ pkgs, ... }: {
  services.qbittorrent = {
    enable = true;
    openFirewall = false;
    serverConfig = {
      LegalNotice.Accepted = true;
      Preferences = {
        WebUI = {
          AlternativeUIEnabled = true;
          RootFolder = "${pkgs.vuetorrent}/share/vuetorrent";
        };
        General.Locale = "en";
      };
    };
    webuiPort = 3011;
  };
}
