{ config, pkgs, ... }:
{
  programs.alacritty = {
    enable = true;
    settings = {
      general = {
        import = [
          "${pkgs.alacritty-theme}/share/alacritty-theme/tokyo_night.toml"
          "./static/alacritty/keybindings.toml"
        ];
      };

      font = {
        normal.family = "FiraCode Nerd Font Mono";
        size = 14;
      };

      window = {
        startup_mode = "Maximized";
        opacity = 0.75;
        blur = true;
        padding = {
          x = 10;
          y = 10;
        };
      };

      selection = {
        save_to_clipboard = true;
      };
    };
  };
}
