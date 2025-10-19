{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium; # This makes it VSCodium
    profiles.default = {
      enableExtensionUpdateCheck = false;
      enableUpdateCheck = false;

      extensions = with pkgs.vscode-extensions; [
        # Editor
        k--kato.intellij-idea-keybindings

        # Essential
        mkhl.direnv
        jnoortheen.nix-ide
        brettm12345.nixfmt-vscode

        # Language server, formatter
        davidanson.vscode-markdownlint
        tamasfe.even-better-toml
        redhat.vscode-yaml
        timonwong.shellcheck
      ];

      userSettings = {
        "editor.fontSize" = 14;
        "editor.fontFamily" = "'JetBrains Mono', monospace";
        "editor.tabSize" = 4;
        "editor.formatOnSave" = true;
        "editor.renderWhitespace" = "all";

        "explorer.compactFolders" = false;

        "workbench.colorTheme" = "Default Dark+";
        "workbench.tree.indent" = 24;

        "[nix]"."editor.defaultFormatter" = "brettm12345.nixfmt-vscode";
      };
    };
  };
}
