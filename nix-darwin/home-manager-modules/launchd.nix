{ config, pkgs, ... }:
{
  launchd = {
    # Rectangle start at login
    agents.rectangle = {
      enable = true;
      config = {
        ProgramArguments = [ "${pkgs.rectangle}/Applications/Rectangle.app/Contents/MacOS/Rectangle" ];
        RunAtLoad = true;
      };
    };
  };
}
