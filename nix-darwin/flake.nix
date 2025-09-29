{
  description = "Example nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-25.05-darwin";
    nix-darwin.url = "github:nix-darwin/nix-darwin/nix-darwin-25.05";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
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
          # List packages installed in system profile. To search by name, run:
          # $ nix-env -qaP | grep wget
          environment.systemPackages = with pkgs; [
            curl
            direnv
            gawk
            git
            htop
            rsync
            vim
          ];

          # Necessary for using flakes on this system.
          nix.settings.experimental-features = "nix-command flakes";

          # Set Git commit hash for darwin-version.
          system.configurationRevision = self.rev or self.dirtyRev or null;

          # Used for backwards compatibility, please read the changelog before changing.
          # $ darwin-rebuild changelog
          system.stateVersion = 6;

          # The platform the configuration will be used on.
          nixpkgs.hostPlatform = "aarch64-darwin";

          # Enable home-manager
          users.users.corytheboyd.home = "/Users/corytheboyd";

          # Determinate uses its own daemon to manage the Nix installation that
          # conflicts with nix-darwin’s native Nix management.
          #
          # To turn off nix-darwin’s management of the Nix installation, set:
          #
          #     nix.enable = false;
          #
          # This will allow you to use nix-darwin with Determinate. Some nix-darwin
          # functionality that relies on managing the Nix installation, like the
          # `nix.*` options to adjust Nix settings or configure a Linux builder,
          # will be unavailable.
          nix.enable = false;
        };
    in
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#simple
      darwinConfigurations."cory-mbp-2023" = nix-darwin.lib.darwinSystem {
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
