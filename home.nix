{ inputs, lib, config, pkgs, ... }: {
  imports = [
	./home/default.nix
  ];

  nixpkgs = {
    overlays = [
    ];
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    username = "tray";
    homeDirectory = "/home/tray";
    packages = with pkgs; [
      flatpak
      neofetch
      swaybg
      gnome.gnome-software
    ];
    sessionPath = [
    	"~/.nimble/bin"
    ];
    stateVersion = "24.05";
  };

  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  # home.packages = with pkgs; [ steam ];

  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}
