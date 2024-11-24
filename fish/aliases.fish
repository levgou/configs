alias vim='/Users/levgourevitch/.local/bin/lvim'
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
	ls -Gltrha $argv[1] | tail
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



# Kubectl sync - given the path to ..../django/project and a pod name
# It will sync the local files to the remote ones upon local file change
function kks -a source -a pod
	fswatch -o $source | while read f; rsync -avurzP --blocking-io --exclude '__pycache__' --rsync-path= --rsh="kubectl exec  -i $pod  -- " $source/*  rsync:/ ; end
end

# This will present an interactive menu with all your pods (adjust grep command - with your name)
# If you pass the script runner name - itll just connect to it (kk some-name)
# If you pass l as an argument (a la. kk l) it'll list all of your pods
# Note this will export an GLOBAL vairable to all of your shells LAST_POD_CONNECTED
function kk -a pod
	if [ "$pod" = "l" ]
		kubectl get pods | grep lev    #  <------   set your name here
	else if test -n "$pod"
    set --erase --global LAST_POD_CONNECTED
		set -xU LAST_POD_CONNECTED $pod
		echo "Copying config files"
		kubectl cp /Users/levgourevitch/private/configure_docker.bash $LAST_POD_CONNECTED:/root/project/configure_docker.bash 
		kubectl cp /Users/levgourevitch/private/docker_bashrc.bash $LAST_POD_CONNECTED:/root/.bashrc
		kubectl cp /Users/levgourevitch/private/docker_tmux.conf $LAST_POD_CONNECTED:/root/.tmux.conf
		kubectl cp /Users/levgourevitch/private/ipython_config_extra.py $LAST_POD_CONNECTED:/root/ipython_config_extra.py
		echo "Connecting to: $pod"
		kubectl exec -it $pod -- /bin/bash
	else
		set pod (kubectl get pods | rg lev | fzf | awk '{print $1}')
		kk $pod
	end
end

function kkf 
	set pod (kubectl get pods | rg lev | fzf | awk '{print $1}')
	set -xU LAST_POD_CONNECTED $pod
	echo "Connecting to: $pod"
	kubectl exec -it $pod -- /bin/bash
end

function kka
	set pod (kubectl get pods | fzf | awk '{print $1}')
	echo "Connecting to: $pod"
	kubectl exec -it $pod -- /bin/bash
end

# in case LAST_POD_CONNECTED is set, just connect to it (usefull for re-connecting)
function kkl
	if set -q LAST_POD_CONNECTED
		kubectl exec -it $LAST_POD_CONNECTED -- /bin/bash
	end
end

# in case LAST_POD_CONNECTED is set, copy a file from your project to the correct
# place inside the script runner
function kkc -a file
	if set -q LAST_POD_CONNECTED
		if string match -q -- '*django/project/*' $file && test -f $file
			set pod_filename (echo $file | sed 's/.*django\/project\///g')
			echo "Copying to $LAST_POD_CONNECTED:$pod_filename"
			kubectl cp $file $LAST_POD_CONNECTED:$pod_filename
		end
	end
end


function aws-export-sts-keys -a code
	set profile "loris"

	if test -z "$code"
		echo "Please provide OTP"
		return 1
	end

	set mfa_arn (aws sts get-caller-identity --profile $profile | jq -r '.Arn' | sed 's/user/mfa/')

	set creds (aws sts get-session-token --profile $profile --serial-number $mfa_arn --token-code $code)

	set -xU AWS_ACCESS_KEY_ID (echo $creds | jq -r '.Credentials.AccessKeyId')
	set -xU AWS_SECRET_ACCESS_KEY (echo $creds | jq -r '.Credentials.SecretAccessKey')
	set -xU AWS_SESSION_TOKEN (echo $creds | jq -r '.Credentials.SessionToken')
	set -xU AWS_DEFAULT_REGION "us-east-2"
end

