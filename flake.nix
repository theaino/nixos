{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixcord = {
      url = "github:kaylorben/nixcord";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations = {
      laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/laptop/configuration.nix

          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.backupFileExtension = "bak";

            home-manager.users.aino = import ./home/aino.nix;

            home-manager.sharedModules = [
              inputs.nixcord.homeModules.nixcord
              inputs.stylix.homeModules.stylix
              inputs.nixvim.homeModules.nixvim
            ];

            home-manager.extraSpecialArgs = {
              inherit inputs;
            };
          }

          inputs.stylix.nixosModules.stylix
          inputs.nixvim.nixosModules.nixvim
        ];
      };
    };
  };
}
