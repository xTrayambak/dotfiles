{
  description = "Tray's Dotfiles";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur.url = "github:nix-community/NUR";
    # hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    # waybar.url = "github:Alexays/waybar";
    lanzaboote.url = "github:nix-community/lanzaboote";
    nix-gaming.url = "github:fufexan/nix-gaming";
    nixpak = {
      url = "github:nixpak/nixpak";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nitty = {
      url = "github:xTrayambak/nitty";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      # hyprland,
      nur,
      lanzaboote,
      # waybar,
      nix-gaming,
      nixpak,
      zen-browser,
      nitty,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in
    {
      packages.${system}.scripts = (pkgs.callPackage ./scripts { });

      homeConfigurations = {
        "tray" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = { inherit inputs; };
          modules = [
            ./home.nix
          ];
        };
      };
      nixosConfigurations = {
        "box" = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [ ./sys.nix ];
        };
      };
    };
}
