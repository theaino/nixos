{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

		sops-nix = {
			url = "github:Mic92/sops-nix";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

		templ = {
			url = "github:a-h/templ";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		zen-browser = {
			url = "github:0xc000022070/zen-browser-flake";
			inputs = {
				nixpkgs.follows = "nixpkgs";
				home-manager.follows = "home-manager";
			};
		};

    nixcord = {
      url = "github:kaylorben/nixcord";
      inputs.nixpkgs.follows = "nixpkgs";
    };

		spicetify-nix = {
			url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
		};
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
		nixosConfigurations =
			let
				system = "x86_64-linux";
				pkgs = import nixpkgs (import ./pkgs { inherit system inputs; });
			in
			{
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
								inputs.sops-nix.homeManagerModules.sops
								inputs.nixvim.homeModules.nixvim
								inputs.zen-browser.homeModules.beta
								inputs.nixcord.homeModules.nixcord
								inputs.spicetify-nix.homeManagerModules.default
							];

							home-manager.extraSpecialArgs = {
								inherit inputs;
							};
						}

						inputs.sops-nix.nixosModules.sops
						inputs.stylix.nixosModules.stylix
						inputs.nixvim.nixosModules.nixvim
					];
				};
			};
	};
}
