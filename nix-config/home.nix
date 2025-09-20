{ config, pkgs, ... }:

{
  home.username = "yourusername";
  home.homeDirectory = "/Users/yourusername";
  home.stateVersion = "23.05";

  home.packages = with pkgs; [
    git
    vim
    nodejs
    python3
  ];

  programs.home-manager.enable = true;
}
