{ config, pkgs, ... }:
{
  programs.alacritty = {
    enable = true;
    settings = {
      general.import = [
        "${pkgs.alacritty-theme}/share/alacritty-theme/tokyo_night.toml"
      ];
      font = {
        normal.family = "JetBrains Mono";
        size = 14;
      };
      window = {
        opacity = 0.98;
        padding = {
          x = 10;
          y = 10;
        };
      };
    };
  };
}
