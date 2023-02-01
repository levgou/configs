
# [ -f /usr/local/share/autojump/autojump.fish ]; and source /usr/local/share/autojump/autojump.fish

set JAVA_HOME (/usr/libexec/java_home)

source $HOME/.config/fish/aliases.fish

#direnv hook fish | source

test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish

status --is-interactive; and source (rbenv init -|psub)

fish_vi_key_bindings

# Emulates vim's cursor shape behavior
# Set the normal and visual mode cursors to a block 
set fish_cursor_default block
# Set the insert mode cursor to a line
set fish_cursor_insert line

zoxide init fish | source
