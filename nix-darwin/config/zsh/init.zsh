# https://mise.jdx.dev/cli/activate.html
eval "$(mise activate zsh)"

# fzf integration
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# iTerm2 shell integration
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# Custom functions
function dgaf() {
    git reset
    git checkout .
    git clean -df
}

# Fix completions for uv run to autocomplete .py files
# https://github.com/astral-sh/uv/issues/8432#issuecomment-2965692994
_uv_run_mod() {
    if [[ "$words[2]" == "run" && "$words[CURRENT]" != -* ]]; then
        _arguments '*:filename:_files -g "*.py"'
    else
        _uv "$@"
    fi
}
compdef _uv_run_mod uv
