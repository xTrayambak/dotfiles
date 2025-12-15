{ inputs, pkgs, ... }:
{
  imports = [
    ./home/default.nix
  ];

  nixpkgs = {
    overlays = [
      inputs.nur.overlays.default
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
      gh
      fastfetch
    ];
    sessionPath = [
      "~/.nimble/bin"
      "~/.local/share/neo/bin"
    ];
    stateVersion = "24.05";
  };

  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}
