
echo "STARTING"

# Install Homebrew
# /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew upgrade
brew install tmux
brew install git

# Neovim

# Todo: Find a clean way of adding this to the .zshrc
# The runtime is dynamically obtained through `brew list neovim` so
# let me find a way of automating this.
# export VIMRUNTIME=/opt/homebrew/Cellar/neovim/HEAD-84378c4/share/nvim/runtime
# export XDG_CONFIG_FILE=/Users/cg/.config

brew install luajit --HEAD
brew install neovim --HEAD

ln -sf $CD_CONFIG_REPO/nvim/init.lua $XDG_CONFIG_HOME/nvim/init.lua
mkdir -p $XDG_CONFIG_HOME/nvim/lua/user
ln -sf $CD_CONFIG_REPO/nvim/plugins.lua $XDG_CONFIG_HOME/nvim/lua/user/plugins.lua

##  Install packer
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim

# The init files should automatically run
# :PackerInstall :PackerCompile
# but I need to check. If not, find a way of setting this up.

echo "DONE"
