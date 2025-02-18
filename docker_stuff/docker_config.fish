fish_add_path /root/nvim/usr/bin
#fish_add_path $HOME/.atuin/bin 

if status is-interactive
    # Commands to run in interactive sessions can go here
    fish_vi_key_bindings
    # atuin init fish --disable-up-arrow | source
end



# --- Navigation ---

alias l='ls -lha'
alias lt='ls -ltrha'

alias pcp="rsync -r --progress"
alias cdl='cd  (\ls -1dt ./*/ | head -n 1)'

alias ...=' cd .. ;cd  ..'
alias ....='... ; cd ..'
alias .....='.... ; cd ..'

abbr mm './manage.py'

alias s='./manage.py shell'

alias b='cd -'
function abs
    echo (pwd)/$argv[1]

end


alias vi='nvim'
alias vim='nvim'
