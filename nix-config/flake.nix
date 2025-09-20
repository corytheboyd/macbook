{
  description = "macbook";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs@{
      self,
      nix-darwin,
      nixpkgs,
      home-manager,
    }:
    let
      configuration =
        { pkgs, ... }:
        {
          services.nix-daemon.enable = true;
          nix.settings.experimental-features = "nix-command flakes";
          programs.zsh.enable = true;
          system.stateVersion = 4;

          users.users.yourusername = {
            name = "corytheboyd";
            home = "/Users/corytheboyd";
          };
        };
    in
    {
      darwinConfigurations."corytheboyd" = nix-darwin.lib.darwinSystem {
        modules = [
          configuration
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.corytheboyd = import ./home.nix;
          }
        ];
      };
    };
}
