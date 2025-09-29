{
  programs.zsh = {
    enable = true;
    syntaxHighlighting.enable = true;

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
    };

    initContent = ''
      # https://junegunn.github.io/fzf/shell-integration
      source <(fzf --zsh)

      # https://junegunn.github.io/fzf/shell-integration/#key-bindings
      export FZF_CTRL_R_OPTS="
        --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
        --color header:italic
        --header 'Press CTRL-Y to copy command into clipboard'"
    '';
  };
}
