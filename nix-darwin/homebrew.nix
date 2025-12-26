{ config, pkgs, ... }:
{
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
    };
    taps = [
      "domt4/autoupdate"
    ];
    brews = [
      "duckdb"
      "opencode"
    ];
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
      "ungoogled-chromium"
      "vlc"
    ];
  };

  system.activationScripts.homebrew.text = pkgs.lib.mkAfter ''
    # Setup homebrew autoupdate
    echo "Setting up homebrew autoupdate..."
    sudo -u corytheboyd /opt/homebrew/bin/brew autoupdate start 86400 --upgrade --cleanup --immediate || true
  '';
}
