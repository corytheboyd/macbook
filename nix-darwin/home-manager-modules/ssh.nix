{
  config,
  lib,
  pkgs,
  ...
}:

{
  # Enable Bitwarden SSH agent
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks = {
      "*" = {
        identityAgent = "${config.home.homeDirectory}/.bitwarden-ssh-agent.sock";
      };
      "seriousbusiness" = {
        user = "root";
        hostname = "seriousbusiness.taild3766c.ts.net";
      };
      "printer" = {
        user = "printer";
        hostname = "printer.local";
      };
      "motherbase" = {
        user = "pliskin";
        hostname = "motherbase.taild3766c.ts.net";
      };
      "arcade" = {
        user = "arcade";
        hostname = "arcade.local";
      };
    };
  };

  # Set SSH_AUTH_SOCK environment variable to use Bitwarden SSH agent
  home.sessionVariables = {
    SSH_AUTH_SOCK = "${config.home.homeDirectory}/.bitwarden-ssh-agent.sock";
  };
}
