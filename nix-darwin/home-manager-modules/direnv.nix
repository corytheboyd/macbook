{
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;  # or enableBashIntegration
    nix-direnv.enable = true;     # performance optimization for nix
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}