alias vim='nvim'
# --- program aliases ---
alias excel='open -a /Applications/Microsoft\ Excel.app/'

# --- Navigation ---
alias l='ls -lha'
alias lt='ls -ltrha'

alias pcp="rsync -r --progress"
alias cdl='cd  (\ls -1dt ./*/ | head -n 1)'

alias ...=' cd .. ;cd  ..'
alias ....='... ; cd ..'
alias .....='.... ; cd ..'
alias b='cd -'

alias h1='head -n 1'

function ltt
	unbuffer ls -Gltrha $argv[1] | tail
end

alias ltd='ltt ~/Downloads'

alias hh='history merge && history'
alias op='open .'
alias opr='open -R'

function abs
	echo (pwd)/$argv[1]
end

function abc -a filename
	if not test -n "$filename"
		echo (pwd)/(ll | fzf  |  awk '{ print substr($9, 1, 500) } ') | tr -d '\n' | pbcopy
	else
		echo (pwd)/$filename | tr -d '\n' | pbcopy
	end
end

function strip
	awk '{$1=$1;print}'
end

function pp
	pwd | pbcopy
	pwd
end

function cdp
	echo (pbpaste)
	cd (pbpaste)
end

function under
	set filename $argv[1]
	set good_name (echo $filename | tr -s ' ' | tr ', ()"\'' '_')
	mv -v $filename $good_name
end

# --- ffmpeg ---
function FFM_togif
	ffmpeg -i $argv[1] -filter_complex 'fps=10,scale=720:-1:flags=lanczos,split [o1] [o2];[o1] palettegen [p]; [o2] fifo [o3];[o3] [p] paletteuse' (echo (echo $argv[1] | cut -d. -f1).gif)
end

function FFM_720
	ffmpeg -i $argv[1] -vf 'scale=-1:720' $argv[2]
end

function FFM_1080
	ffmpeg -i $argv[1] -vf 'scale=-1:1080' $argv[2]
end

# --- General ---
alias rgi='rg -i'
alias gnode='set PATH ~/npm-glob/bin $PATH'
alias gradle-kill="pkill -f '.*GradleDaemon.*'"

# --- DCApp ---
alias crr='./.scripts/crr.bash'

alias ios-from-android='rm -rf src && cp -r ../../../jack-android/src/JackDataCollectionReactNative/src . && bb prepublishIOSDebug && cd ../JackDataCollectionIOS/ && rls && cd -'

alias rls-and='bb prepublishAndroidDebug && cd ../JackDataCollectionAndroid/ && rls && cd -'

# --- Git ---
alias append-commit='git add . && git commit --amend --no-edit'
alias gl='git log --oneline -10'
alias gm='git log --format=%B -n 1'
alias sts='git status'

function git-like
	git checkout $argv[1]
	git reset --soft mainline
	git commit -m $argv[2]
	git branch temp456
	git checkout mainline
	git merge temp456
	git branch -d temp456
end

# --- Brazil ---
alias bb=brazil-build
alias bba='brazil-build apollo-pkg'
alias bball='brc --allPackages'
alias bbb='brc --allPackages brazil-build'
alias bbr='brc brazil-build'
alias bbra='bbr apollo-pkg'
alias brazil-octane=/apollo/env/OctaneBrazilTools/bin/brazil-octane
alias brc=brazil-recursive-cmd
alias bre=brazil-runtime-exec
alias bws='brazil ws'
alias bwscreate='bws create -n'
alias bwsuse='bws use --gitMode -p'

alias sink='brazil ws sync --md'
alias show='brazil ws show'
alias rls='rm -f Podfile.lock && bb release'
alias bbx='rm -f Podfile.lock && bb xcode-env'
alias rlsx='rm -f Podfile.lock && bb xcode-env && bb release'
alias edge-cache='brazil-package-cache disable_edge_cache ; brazil-package-cache enable_edge_cache'
alias sink='brazil ws sync --md'
alias bs='bb start'
alias ba='bb server-axle'

# --- JQ ---
function js_arr_csv
	jq -r '(.[0] | keys_unsorted) as $keys | ([$keys] + map([.[ $keys[] ]])) [] | @csv'
end

function JQ_select_not_used
	jq '.[] | select ( ._notUsed == true )'
end

function JQ_select_used
	jq '.[] | select ( ._notUsed != true )'
end
function JQ_collect
	jq -s '.'
end
function JQ_destruct
	jq -c '.[]'
end
function JQ_ex_id
	jq ". | select ( .exerciseTypeId == \"$argv[1]\" )"
end
function JQ_video_type
	jq ". | select ( .videoType == \"$argv[1]\" )"
end
function JQ_angle
	jq ". | select ( .angle == \"$argv[1]\" )"
end
function JQ_instructor
	jq ". | select ( .instructor == \"$argv[1]\" )"
end
function JQ_wc
	jq -c | wc
end

# --- ADB ---
alias adb-prox="adb reverse tcp:8081 tcp:8081"
alias adb-menu="adb shell input keyevent 82"
alias adb-entr="adb shell input keyevent 66"
alias adb-reload="adb-menu && adb-entr && adb-entr"
alias adb-r="adb-prox && adb-reload"
alias adb-wake="adb shell input keyevent KEYCODE_WAKEUP"
alias adb-swipe="adb shell input touchscreen swipe 200 800 200 200 100"
alias adb-pass="adb shell input text 126126  && adb shell input keyevent 66"
alias adb-unlock="adb-wake && adb-swipe && adb-pass"

# --- TSLint ---
alias tslint='node_modules/tslint/bin/tslint'
alias tsfix='tslint --project tsconfig.json --fix'
alias lint='tslint --project tsconfig.json'

# --- Prettier ---
alias prettier='node_modules/prettier/bin-prettier.js'
alias format="prettier --write -l 'src/**/*.{js,jsx,ts,tsx}' '!.tmp/**'"

# --- Jest ---
alias jest='node_modules/jest-cli/bin/jest.js --colors --config jestconfig.json'
alias jt='node_modules/jest-cli/bin/jest.js --colors --config jestconfig.json --coverage false'

# this "accepts" 2 arguments - first for test suite pattern, 2nd for filename pattern
alias jest-single='node_modules/jest-cli/bin/jest.js --colors --config jestconfig.json --coverage false -t'
