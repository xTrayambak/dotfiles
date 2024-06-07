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
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-gaming.url = "github:fufexan/nix-gaming";
    # schizofox.url = "github:schizofox/schizofox";
  };

  outputs = { 
    nixpkgs, home-manager, 
    hyprland, nur, lanzaboote,
    waybar, nixvim,
    nix-gaming, ... } @ inputs: {
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
