# See:
# https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-homebrew.enable
{ config, pkgs, ... }:
{
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "zap";
    };
    taps = [ ];
    brews = [
      "duckdb"
      "opencode"
      "ufbt"
    ];
    casks = [
      "alfred"
      "base"
      "claude"
      "claude-code"
      "firefox"
      "jetbrains-toolbox"
      "monodraw"
      "mullvad-vpn"
      "obsidian"
      "qflipper"
      "shottr"
      "signal"
      "ungoogled-chromium"
      "vlc"
      "yaak"
    ];
  };

  system.activationScripts.homebrew.text = pkgs.lib.mkAfter ''
    # Setup homebrew autoupdate
    echo "Setting up homebrew autoupdate..."
    sudo -u corytheboyd /opt/homebrew/bin/brew autoupdate start 86400 --upgrade --cleanup --immediate || true
  '';
}
