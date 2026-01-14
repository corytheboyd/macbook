{ config, lib, pkgs, ... }:
{
  # Copy config files (not symlink) so tools can write to them
  home.activation.colimaConfig = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    mkdir -p "${config.home.homeDirectory}/.colima/default"
    cp -f "${./static/colima/colima.yaml}" "${config.home.homeDirectory}/.colima/default/colima.yaml"
    chmod 644 "${config.home.homeDirectory}/.colima/default/colima.yaml"
  '';

  home.activation.dockerConfig = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    mkdir -p "${config.home.homeDirectory}/.docker"
    cp -f "${./static/docker/config.json}" "${config.home.homeDirectory}/.docker/config.json"
    chmod 644 "${config.home.homeDirectory}/.docker/config.json"
  '';

  launchd.agents.colima = {
    enable = true;
    config = {
      Label = "com.github.abiosoft.colima";
      ProgramArguments = [
        "${pkgs.colima}/bin/colima"
        "start"
        "--foreground"
      ];
      RunAtLoad = true;
      KeepAlive = false;
      StandardOutPath = "${config.home.homeDirectory}/Library/Logs/colima.log";
      StandardErrorPath = "${config.home.homeDirectory}/Library/Logs/colima.error.log";
    };
  };
}
