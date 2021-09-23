#!/bin/bash

HELPTEXT="./install.sh <desktop|laptop|headless>"
case $1 in
    h|help|\?|-h|-help|-\?|--h|--help|--\?)
        echo -e $HELPTEXT
        exit 0
        ;;
    desktop)
        UNIT=DESKTOP
        ;;
    laptop)
        UNIT=LAPTOP
        ;;
    headless)
        UNIT=HEADLESS
        ;;
    *)
        echo -e $HELPTEXT
        exit 0
        ;;
esac

category(){
    echo -e " \e[1;37m$1\e[0m"
}

item(){
    echo -e "  \e[0m$1\e[0m"
}

echo -e " \e[1;33mInstall type \e[1;35m$UNIT\e[0m"

# Bash config
category "Bash config"
item "~/.bash_aliases"
install .bash_aliases $HOME/.bash_aliases
item "~/.bashrc"
install .bashrc $HOME/.bashrc
item "~/.profile"
install .profile $HOME/.profile

category "Common folders"
item "~/src/"
SRCFOLDER=$HOME/src
mkdir -p $SRCFOLDER

# Local scripts
category "Local scripts"
LOCALBIN=$HOME/.local/bin
if [ $UNIT == "DESKTOP" ]; then
    item "~/.local/bin/middle-mouse-scroll"
    install middle-mouse-scroll $LOCALBIN/middle-mouse-scroll
fi
item "~/.local/bin/minesweeper"
if [ ! -f $LOCALBIN/minesweeper ]; then
    git clone --depth=1 git://joshstock.in/ncurses-minesweeper.git $SRCFOLDER/ncurses-minesweeper
    cd $SRCFOLDER/ncurses-minesweeper
    make compile build
    install bin/minesweeper $LOCALBIN/minesweeper
    rm -rf $SRCFOLDER/ncurses-minesweeper
fi

if [ $UNIT == "DESKTOP" ] || [ $UNIT == "LAPTOP" ]; then
    # GTK config
    category "GTK config"

    GTKDIR=$HOME/.config/gtk-3.0
    item "~/.config/gtk-3.0/"
    mkdir -p $GTKDIR

    item "~/.config/gtk-3.0/gtk.css"
    install gtk.css $GTKDIR/gtk.css

    item "Terminal theme 'Oceanic Next'"
    ./terminal_theme.sh $1 &>/dev/null

    # Fonts
    category "Fonts"

    item "~/.fonts/"
    FONTDIR=$HOME/.fonts
    mkdir -p $FONTDIR

    item "Fira Sans pack"
    if [ ! -f $FONTDIR/FiraSans-Regular.ttf ]; then
        curl -fLso /tmp/Fira.zip https://fonts.google.com/download?family=Fira%20Sans
        unzip -q /tmp/Fira.zip -d $FONTDIR
    fi

    item "Fira Mono (Powerline-patched) pack"
    if [ ! -f $FONTDIR/FuraMono-Regular\ Powerline.otf ]; then
        curl -fLso $FONTDIR/FuraMono-Regular\ Powerline.otf https://github.com/powerline/fonts/raw/master/FiraMono/FuraMono-Regular%20Powerline.otf
    fi
    if [ ! -f $FONTDIR/FuraMono-Medium.otf ]; then
        curl -fLso $FONTDIR/FuraMono-Medium\ Powerline.otf https://github.com/powerline/fonts/raw/master/FiraMono/FuraMono-Medium%20Powerline.otf
    fi
    if [ ! -f $FONTDIR/FuraMono-Bold.otf ]; then
        curl -fLso $FONTDIR/FuraMono-Bold\ Powerline.otf https://github.com/powerline/fonts/raw/master/FiraMono/FuraMono-Bold%20Powerline.otf
    fi

    item "Refreshing font cache"
    fc-cache
fi

# Global git config
category "Global git config"

item "~/.gitconfig"
install .gitconfig $HOME/.gitconfig

# Vim
category "Vim config"

item "~/.vim/"
VIMDIR=$HOME/.vim
mkdir -p $VIMDIR

item "~/.vim/vimrc"
if [ $UNIT == "HEADLESS" ]; then
    grep -v "RMHEADLESS" vimrc > $VIMDIR/vimrc
else
    install vimrc $VIMDIR/vimrc
fi

item "~/.vim/autoload/plug.vim"
curl -fLso $VIMDIR/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Done
echo -e " \e[1;33mDONE\e[0m"
