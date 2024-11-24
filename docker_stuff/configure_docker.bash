install_utils.sh
apt install unzip
apt-get -y install rsync git   # git is for tpm / cloning repos
# gcc

# git clone --depth 1 https://github.com/cjbassi/gotop /tmp/gotop
# /tmp/gotop/scripts/download.sh

# neovim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
./nvim.appimage  --appimage-extract
mv squashfs-root/ ~/nvim
mkdir -p ~/.config/nvim

# tmux
mkdir -p ~/.tmux/plugins
curl -OLJ https://github.com/tmux-plugins/tpm/archive/refs/heads/master.zip 

unzip tpm-master.zip  -d ~/.tmux/plugins
rm -v tpm-master.zip
mv -v ~/.tmux/plugins/tpm-master ~/.tmux/plugins/tpm

~/.tmux/plugins/tpm/scripts/install_plugins.sh

curl https://raw.githubusercontent.com/riobard/bash-powerline/master/bash-powerline.sh > ~/.bash-powerline.sh

# pip install
pip install pdbpp

# ./manage.py shell vim mode
mkdir -p ~/.ipython/profile_default
mv -v ipython_config_docker.py ~/.ipython/profile_default/ipython_config.py

# echo "c.TerminalInteractiveShell.editing_mode = 'vi'" >> ~/.ipython/profile_default/ipython_config.py
# echo "c.InteractiveShellApp.exec_lines = [
#     'from organization.models import Agent, Installation, ClientAgent, Client;'
#     'from brain.models import *;'
#     'from more_itertools import flatten;'
#     'from collections import Counter, defaultdict;'
#     'from pprint import pp;'
# ]" >> ~/.ipython/profile_default/ipython_config.py
