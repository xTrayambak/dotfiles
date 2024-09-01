{
  description = "Tray's Dotfiles";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur.url = "github:nix-community/NUR";
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    waybar.url = "github:Alexays/waybar";
    lanzaboote.url = "github:nix-community/lanzaboote";
    nix-gaming.url = "github:fufexan/nix-gaming";
    flatpaks.url = "github:gmodena/nix-flatpak";
  };

  outputs = { 
    nixpkgs, home-manager, 
    hyprland, nur, lanzaboote,
    waybar, nix-gaming, flatpaks, ... } @ inputs: {
    defaultPackage.x86_64-linux = home-manager.defaultPackage.x86_64-linux;

    homeConfigurations = {
      "tray" = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs { system = "x86_64-linux"; };
	extraSpecialArgs = { inherit inputs; };
        modules = [ 
	  ./home.nix
	];
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
