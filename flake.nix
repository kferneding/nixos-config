{
  description = "NixOS Base Setup";
  inputs = {
    dotfiles = {
      url = "github:KevinFlummi/dotfiles";
      flake = false;
    };
    nixpkgs.url = "nixpkgs/nixos-unstable";
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    dotfiles,
    home-manager,
    stylix,
    noctalia,
    ...
  }: {
    nixosConfigurations.tofu = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        inherit dotfiles;
      };
      modules = [
        stylix.nixosModules.stylix
        ./hosts/tofu/configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = {
              inherit dotfiles;
            };
            users.kevin.imports = [
              ./home/kevin.nix
              noctalia.homeModules.default
            ];
            backupFileExtension = "backup";
          };
        }
      ];
    };
    nixosConfigurations.lentil = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        inherit dotfiles;
      };
      modules = [
        stylix.nixosModules.stylix
        ./hosts/lentil/configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = {
              inherit dotfiles;
            };
            users.kevin.imports = [
              ./home/kevin.nix
              noctalia.homeModules.default
            ];
            backupFileExtension = "backup";
          };
        }
      ];
    };
  };
}
