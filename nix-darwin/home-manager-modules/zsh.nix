{
  programs.zsh = {
    enable = true;
    syntaxHighlighting.enable = true;

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
    };

    initContent = ''
      # Homebrew
      eval "$(/opt/homebrew/bin/brew shellenv)"

      # https://junegunn.github.io/fzf/shell-integration
      source <(fzf --zsh)

      # https://junegunn.github.io/fzf/shell-integration/#key-bindings
      export FZF_CTRL_R_OPTS="
        --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
        --color header:italic
        --header 'Press CTRL-Y to copy command into clipboard'"

      # Bitwarden SSH agent integration
      # https://bitwarden.com/help/ssh-agent/#configure-bitwarden-ssh-agent
      export SSH_AUTH_SOCK="$HOME/Library/Containers/com.bitwarden.desktop/Data/.bitwarden-ssh-agent.sock"
    '';
  };
}
