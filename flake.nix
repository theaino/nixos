{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

		chaotic = {
			url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
			inputs.nixpkgs.follows = "nixpkgs";
		};

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixcord = {
      url = "github:kaylorben/nixcord";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
		let
			system = "x86_64-linux";
			pkgs = import nixpkgs (import ./pkgs { inherit system; });
		in
		{
			nixosConfigurations = {
				mtop = nixpkgs.lib.nixosSystem {
					inherit system pkgs;
					modules = [
						./nixos/hosts/mtop
						./nixos/modules

						home-manager.nixosModules.home-manager {
							home-manager.useGlobalPkgs = true;
							home-manager.useUserPackages = true;

							home-manager.backupFileExtension = "bak";

							home-manager.users.aino = import ./home/users/aino;

							home-manager.sharedModules = [
								inputs.nixcord.homeModules.nixcord
								inputs.stylix.homeModules.stylix
								inputs.nixvim.homeModules.nixvim
							];

							home-manager.extraSpecialArgs = {
								inherit inputs;
							};
						}

						inputs.chaotic.nixosModules.default
						inputs.stylix.nixosModules.stylix
						inputs.nixvim.nixosModules.nixvim
					];
				};
			};
		};
}
