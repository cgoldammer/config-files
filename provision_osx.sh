
echo "STARTING"

mkdir -p ./vim/autoload
mkdir -p ./vim/bundle

# Install Homebrew
# /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew upgrade
brew install macvim # This includes ruby support, which is required for command-T
brew install tmux
brew install git
# brew install ruby-dev
# sudo apt-get install curl -y
# sudo apt-get install exuberant-ctags -y
# sudo apt-get install make -y
# sudo apt-get install rake -y

if [ ! -d ~/.vim/bundle/Vundle.vim ]; then 
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

# cd
ln -sf ./.vimrc $HOME/.vimrc
ln -sf ./.tmux.conf $HOME/.tmux.conf

vim +PluginInstall +qall

mkdir -p ~/.vim/pack/plugins/start
git clone --depth=1 https://github.com/ctrlpvim/ctrlp.vim.git ~/.vim/pack/plugins/start/ctrlp


echo "DONE"
