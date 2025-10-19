{
  config,
  lib,
  pkgs,
  ...
}:

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
    audacity
    bitwarden-desktop
    fd
    fontconfig
    fzf
    jq
    jless
    just
    neovim
    nerd-fonts.fira-code
    nixfmt-rfc-style
    lazygit
    rectangle
    ripgrep
    starship
    tailscale
    tree-sitter
    vscodium
    wezterm
  ];

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'.
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Enable font installation
  fonts.fontconfig.enable = true;
}
