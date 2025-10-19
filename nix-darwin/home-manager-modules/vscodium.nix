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
        nefrob.vscode-just-syntax
      ];

      userSettings = {
        "workbench.colorTheme" = "Default Dark+";
        "editor.fontSize" = 14;
        "editor.fontFamily" = "'JetBrains Mono', monospace";
        "editor.tabSize" = 4;

        # On save actions
        "editor.formatOnSave" = true;

        # Whitespace preferences
        "editor.renderWhitespace" = "all";
        "files.trimFinalNewlines" = true;
        "files.insertFinalNewline" = true;
        "files.trimTrailingWhitespace" = true;

        # File browser UI
        "explorer.compactFolders" = false;
        "workbench.tree.indent" = 24;

        # Per-language rules
        "[nix]"."editor.defaultFormatter" = "brettm12345.nixfmt-vscode";
        "[just]"."editor.defaultFormatter" = "nefrob.vscode-just-syntax";
      };
    };
  };
}
