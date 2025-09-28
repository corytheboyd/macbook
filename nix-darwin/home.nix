{ config, pkgs, ... }:

{
  imports = [
    ./home-manager-modules
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "corytheboyd";
  home.homeDirectory = "/Users/corytheboyd";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  home.stateVersion = "25.05";

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    alacritty
    alacritty-theme
    # TODO: figure out permission of non-free packages
    # jetbrains-toolbox
    fontconfig
    nerd-fonts.fira-code
    lazygit
    starship
    vscodium
  ];

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'.
  home.sessionVariables = {
    EDITOR = "vim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Enable font installation
  fonts.fontconfig.enable = true;
}
