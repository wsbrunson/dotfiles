{
  description = "Shane's multi-system Nix configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, nix-darwin, home-manager }:
  {
    # =========================================================================
    # macOS (nix-darwin)
    # =========================================================================

    darwinConfigurations."snake-charmer" = let
      username = "shanebrunson";
      dotfilesPath = "/Users/${username}/workspace/dotfiles";
    in nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      specialArgs = { inherit inputs username; };
      modules = [
        ./hosts/snake-charmer
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { inherit inputs username dotfilesPath; };
          home-manager.users.${username} = import ./hosts/snake-charmer/home.nix;
        }
      ];
    };

    # =========================================================================
    # NixOS
    # =========================================================================

    nixosConfigurations."cottonmouth" = let
      username = "shane";
      dotfilesPath = "/home/${username}/workspace/dotfiles";
    in nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs username; };
      modules = [
        ./hosts/cottonmouth
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { inherit inputs username dotfilesPath; };
          home-manager.users.${username} = import ./hosts/cottonmouth/home.nix;
        }
      ];
    };

  };
}
