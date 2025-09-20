{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should manage
  home.username = "corytheboyd";
  home.homeDirectory = "/Users/corytheboyd";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  home.stateVersion = "25.05";

  # User packages (moved from environment.systemPackages)
  home.packages = with pkgs; [
    vim
    mise
    fzf
    git
    colima
    ffmpeg
    htop
    jless
    jq
    lazygit
    uv
  ];

  # Programs configuration
  programs = {
    # Git configuration
    git = {
      enable = true;
      # Add your git config here
    };

    # Note: zsh configuration moved back to nix-darwin for PATH compatibility

    # Starship configuration
    starship = {
      enable = true;
      settings = builtins.fromTOML (builtins.readFile ./config/starship/starship.toml);
    };
  };

  # iTerm2 configuration
  targets.darwin.defaults."com.googlecode.iterm2" = {
    # Add your iTerm2 preferences here
  };

  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;
}