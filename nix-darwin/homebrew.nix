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
      "hammerspoon"
      "jetbrains-toolbox"
      "sol"
    ];
  };
}
