#! /bin/sh

# link to $HOME
echo "# Creating link in your $HOME dir..." 
ln -vsf $PWD/emacs/.emacs ~/.emacs
ln -vsf $PWD/emacs/.emacs.d ~/.emacs.d
ln -vsf $PWD/vim/.vimrc ~/.vimrc
ln -vsf $PWD/vim/.vim ~/.vim

# pull submodule
echo "# Pulling submodule"
git submodule init
git submodule update

# auto-complete submdule
echo "# Pulling submodule of auto-complete"
current_dir=$PWD
cd emacs/.emacs.d/plugins/auto-complete
echo "cd $PWD"
git submodule init
git submodule update

cd $current_dir
echo "cd $PWD"





