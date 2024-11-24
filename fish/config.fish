function fish_greeting
    fortune
end

source $HOME/.config/fish/aliases.fish

#direnv hook fish | source

fish_vi_key_bindings

# Emulates vim's cursor shape behavior
# Set the normal and visual mode cursors to a block 
set fish_cursor_default block
# Set the insert mode cursor to a line
set fish_cursor_insert line

zoxide init fish | source

atuin init fish --disable-up-arrow | source

