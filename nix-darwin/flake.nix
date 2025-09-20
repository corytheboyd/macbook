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
          system.primaryUser = "corytheboyd";

          # Configure user with zsh as default shell
          users.users.corytheboyd = {
            name = "corytheboyd";
            home = "/Users/corytheboyd";
            shell = pkgs.zsh;
          };

          # System packages (essential commands that need to be system-wide)
          environment.systemPackages = with pkgs; [
            coreutils  # mv, mkdir, etc.
            starship   # needed for prompt init
          ];

          fonts.packages = with pkgs; [
            nerd-fonts.jetbrains-mono
          ];

          # Necessary for using flakes on this system.
          nix.settings.experimental-features = "nix-command flakes";

          # Enable alternative shell support in nix-darwin.
          # programs.fish.enable = true;

          # Configure zsh (moved back from Home Manager for PATH compatibility)
          programs.zsh = {
            enable = true;
            enableCompletion = true;
            enableFzfCompletion = true;
            enableFzfGit = true;
            enableFzfHistory = true;
            promptInit = "";

            variables = builtins.fromTOML (builtins.readFile ./config/zsh/environment.toml);

            interactiveShellInit = ''
              # Load aliases
              ${builtins.concatStringsSep "\n" (
                builtins.attrValues (
                  builtins.mapAttrs (name: value: "alias ${name}='${value}'") (
                    builtins.fromTOML (builtins.readFile ./config/zsh/aliases.toml)
                  )
                )
              )}

              # Starship prompt
              eval "$(starship init zsh)"

              # Initialize completions first
              autoload -U compinit && compinit

              # Load custom zsh config from this repo
              source ${./config/zsh/init.zsh}
            '';
          };

          # Configure Homebrew for GUI apps
          homebrew = {
            enable = true;
            casks = [
              "iterm2"
            ];
          };

          # Configure system defaults including iTerm2
          system.defaults = {
            # Set system font defaults
            NSGlobalDomain = {
              AppleFontSmoothing = 1;
            };
          };


          # Set Git commit hash for darwin-version.
          system.configurationRevision = self.rev or self.dirtyRev or null;

          # Used for backwards compatibility, please read the changelog before changing.
          # $ darwin-rebuild changelog
          system.stateVersion = 6;

          # The platform the configuration will be used on.
          nixpkgs.hostPlatform = "aarch64-darwin";

          nix.enable = false;
        };
    in
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#corytheboyd
      darwinConfigurations."corytheboyd" = nix-darwin.lib.darwinSystem {
        modules = [
          configuration
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
            home-manager.users.corytheboyd = import ./home.nix;
          }
        ];
      };
    };
}
