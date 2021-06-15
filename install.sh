#! /usr/bin/sh

cd $(dirname $0)

# install emacs dir.
ln -srf emacs/.emacs   ~/.emacs
ln -srf emacs/.emacs.d ~/.emacs.d

# install vim config file.
ln -srf vim/.vimrc     ~/.vimrc
