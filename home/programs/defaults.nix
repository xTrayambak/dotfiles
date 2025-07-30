{
  xdg.mimeApps = {
    enable = true;
    associations.added = {
      "application/pdf" = ["org.pwmt.zathura.desktop"];
      "image/jpeg" = ["org.gnome.Loupe.desktop"];
      "image/png" = ["org.gnome.Loupe.desktop"];
      "image/gif" = ["org.gnome.Loupe.desktop"];
      "image/svg+xml" = ["org.gnome.Loupe.desktop"];
      "image/webp" = ["org.gnome.Loupe.desktop"];
    };
    defaultApplications = {
      "application/pdf" = ["org.pwmt.zathura.desktop"];
      "text/html" = "zen.desktop";
      "text/json" = "zen.desktop";
      "x-scheme-handler/http" = "zen.desktop";
      "x-scheme-handler/https" = "zen.desktop";
      "x-scheme-handler/discord" = "discord.desktop";
      "x-scheme-handler/about" = "zen.desktop";
      "x-scheme-handler/unknown" = "zen.desktop";
    };
  };
}
