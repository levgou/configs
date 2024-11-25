if status is-interactive
  # Commands to run in interactive sessions can go here
  fish_vi_key_bindings
end



# --- Navigation ---

alias l='ls -lha'
alias lt='ls -ltrha'

alias pcp="rsync -r --progress"
alias cdl='cd  (\ls -1dt ./*/ | head -n 1)'

alias ...=' cd .. ;cd  ..'
alias ....='... ; cd ..'
alias .....='.... ; cd ..'

alias b='cd -'
function abs
	echo (pwd)/$argv[1]

end

