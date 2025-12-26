{ config, pkgs, ... }:
{
  programs.chromium = {
    enable = true;
    extensions = [
      { id = "fmkadmapgofadopljbjfkapdkoienihi"; } # React Developer Tools
    ];
  };
}
