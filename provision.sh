
echo "STARTING"

mkdir -p ./vim/autoload
mkdir -p ./vim/bundle

sudo apt-get update

sudo apt-get install vim -y
sudo apt-get install tmux -y
sudo apt-get install git -y
sudo apt-get install ruby-dev -y
sudo apt-get install vim-nox -y
sudo apt-get install curl -y
sudo apt-get install exuberant-ctags -y
sudo apt-get install make -y

if [ ! -d ~/.vim/bundle/Vundle.vim ]; then 
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

if [ ! -d ~/config-files ]; then 
  git clone https://github.com/cgoldammer/config-files.git ~/config-files
fi

ln -sf ~/config-files/.vimrc ~/.vimrc
ln -sf ~/config-files/.tmux.conf ~/.tmux.conf

vim +PluginInstall +qall

echo "DONE"
