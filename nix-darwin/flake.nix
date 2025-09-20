{
  description = "Example nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-25.05-darwin";
    nix-darwin.url = "github:nix-darwin/nix-darwin/nix-darwin-25.05";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs@{
      self,
      nix-darwin,
      nixpkgs,
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

          # List packages installed in system profile. To search by name, run:
          # $ nix-env -qaP | grep wget
          environment.systemPackages = with pkgs; [
            vim
            mise
            fzf
            git
            oh-my-zsh
            starship
            colima
            ffmpeg
            htop
            jless
            jq
            lazygit
            uv
            iterm2
          ];

          fonts.packages = with pkgs; [
            nerd-fonts.fira-code
            nerd-fonts.jetbrains-mono
          ];

          # Necessary for using flakes on this system.
          nix.settings.experimental-features = "nix-command flakes";

          # Enable alternative shell support in nix-darwin.
          # programs.fish.enable = true;

          # Configure zsh
          programs.zsh = {
            enable = true;
            enableCompletion = true;
            enableFzfCompletion = true;
            enableFzfGit = true;
            enableFzfHistory = true;

            # Ensure zsh is the default shell
            enableBashCompletion = true;

            # Disable default prompt (we use starship)
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
        modules = [ configuration ];
      };
    };
}
