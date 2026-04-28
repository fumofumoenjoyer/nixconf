{
  description = "NixOS from Scratch";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable"; # Add this
    nix-flatpak.url = "github:gmodena/nix-flatpak";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, nix-flatpak, ... }@inputs: {
    nixosConfigurations.nixos-btw = nixpkgs.lib.nixosSystem {
      # This makes 'inputs' available to configuration.nix and home.nix
      specialArgs = { inherit inputs; };
      modules = [
        ./configuration.nix
        home-manager.nixosModules.home-manager
        nix-flatpak.nixosModules.nix-flatpak
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.fumo = import ./home.nix;
            extraSpecialArgs = { inherit inputs; }; # Also pass to Home Manager
            backupFileExtension = "backup";
          };
        }
      ];
    };
  };
}
