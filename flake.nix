{
  description = "Tray's Dotfiles";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprlock = {
      url = "github:hyprwm/hyprlock";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hypridle = {
      url = "github:hyprwm/hypridle";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur.url = "github:nix-community/NUR";
    hyprland.url = "github:hyprwm/Hyprland";
    waybar.url = "github:Alexays/waybar";
    lanzaboote.url = "github:nix-community/lanzaboote";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    schizofox.url = "github:schizofox/schizofox";
  };

  outputs = { 
    nixpkgs, home-manager, hyprlock, 
    hyprland, nur, lanzaboote,
    waybar, nixvim, hypridle,
  ... } @ inputs: {
    defaultPackage.x86_64-linux = home-manager.defaultPackage.x86_64-linux;

    homeConfigurations = {
      "tray" = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs { system = "x86_64-linux"; };
	extraSpecialArgs = { inherit inputs; };
        modules = [ ./home.nix ];
      };
    };
    nixosConfigurations = {
      "box" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
	specialArgs = { inherit inputs; };
	modules = [ ./sys.nix ];
      };
    };
  };
}
