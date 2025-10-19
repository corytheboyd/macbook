{ pkgs, ... }:
{
  programs.wezterm = {
    enable = true;
    extraConfig = builtins.readFile ./static/wezterm/.wezterm.lua;
  };
}
