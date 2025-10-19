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
      "jetbrains-toolbox"
      "sol"
    ];
  };
}
