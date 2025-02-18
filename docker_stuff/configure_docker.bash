# Fish
echo 'deb http://download.opensuse.org/repositories/shells:/fish:/release:/3/Debian_12/ /' | tee /etc/apt/sources.list.d/shells:fish:release:3.list
curl -fsSL https://download.opensuse.org/repositories/shells:fish:release:3/Debian_12/Release.key | gpg --dearmor | tee /etc/apt/trusted.gpg.d/shells_fish_release_3.gpg >/dev/null

install_utils.sh
apt install -y unzip fish tmux rsync git gcc fzf # git is for tpm / cloning repos

# git clone --depth 1 https://github.com/cjbassi/gotop /tmp/gotop /tmp/gotop/scripts/download.sh
# neovim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
./nvim.appimage --appimage-extract 2>&1 >>/dev/null
mv squashfs-root/ ~/nvim
mkdir -p ~/.config/nvim
git clone https://github.com/LazyVim/starter ~/.config/nvim
rm -rf ~/.config/nvim/.git

# tmux
mkdir -p ~/.tmux/plugins
curl -OLJ https://github.com/tmux-plugins/tpm/archive/refs/heads/master.zip

unzip tpm-master.zip -d ~/.tmux/plugins
rm -v tpm-master.zip
mv -v ~/.tmux/plugins/tpm-master ~/.tmux/plugins/tpm

~/.tmux/plugins/tpm/scripts/install_plugins.sh

# curl https://raw.githubusercontent.com/riobard/bash-powerline/master/bash-powerline.sh > ~/.bash-powerline.sh

# pip install
pip install pdbpp

# ./manage.py shell vim mode
mkdir -p ~/.ipython/profile_default
mv -v /root/ipython_config_extra ~/.ipython/profile_default/ipython_config.py

# fish
mkdir -p ~/.config/fish/
mv -v docker_config.fish ~/.config/fish/config.fish
# Plugins
# curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher

# atuin
#curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh
#fish atuin_ignored.fish
#rm atuin_ignored.fish

# open new tmux session in background with 2 pains, one with django shell running
tmux new -d -s main &&
  tmux new-window -n manage -t main &&
  tmux send-keys -t main.1 './manage.py shell' Enter
# && tmux new-window -n manage -t main \
# && tmux send-keys -t main.1 'nvim .' Enter
