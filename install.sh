#! /usr/bin/sh

cd $(dirname $0)

# install emacs dir.
rm -rf ~/.emacs.d && ln -srf emacs/.emacs.d ~/.emacs.d

# install vim config file.
ln -srf vim/.vimrc     ~/.vimrc
