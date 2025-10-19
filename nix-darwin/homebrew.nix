{ config, pkgs, ... }:
{
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
    };
    taps = [ ];
    brews = [ ];
    casks = [
      "claude"
      "claude-code"
      "jetbrains-toolbox"
      "monodraw"
      "mullvad-vpn"
      "obsidian"
      "shottr"
      "signal"
      "sol"
      "vlc"
    ];
  };
}
