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
    waybar.url = "github:Alexays/waybar";
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
    pcp = {
      url = "github:performancecopilot/pcp";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-minecraft = {
      url = "github:Infinidoge/nix-minecraft";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    playit = {
      url = "github:pedorich-n/playit-nixos-module";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    atlas = {
      url = "github:xTrayambak/atlas/nix/init";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      # hyprland,
      nur,
      lanzaboote,
      waybar,
      nix-gaming,
      nixpak,
      zen-browser,
      nitty,
      pcp,
      playit,
      agenix,
      niri,
      atlas,
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
        # Laptop
        box = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [
            ./system/box
          ];
        };

        # Homelab
        lab = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs;
            pcp = inputs.pcp.packages.${system}.pcp;
          };
          modules = [
            ./system/lab
            "${inputs.pcp}/build/nix/nixos-module.nix"
            playit.nixosModules.default
            agenix.nixosModules.default
          ];
        };
      };
    };
}
