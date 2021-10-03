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

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"

# Bash config
category "Bash config"
item "~/.bash_aliases"
install $SCRIPT_DIR/.bash_aliases $HOME/.bash_aliases
item "~/.bashrc"
install $SCRIPT_DIR/.bashrc $HOME/.bashrc
item "~/.profile"
install $SCRIPT_DIR/.profile $HOME/.profile

category "Common folders"
item "~/src/"
SRCFOLDER=$HOME/src
mkdir -p $SRCFOLDER
item "~/.local/bin/"
LOCALBIN=$HOME/.local/bin
mkdir -p $LOCALBIN

# Local scripts
category "Local scripts"
if [ $UNIT == "DESKTOP" ]; then
    item "~/.local/bin/middle-mouse-scroll"
    install $SCRIPT_DIR/middle-mouse-scroll $LOCALBIN/middle-mouse-scroll
fi
item "/usr/local/bin/minesweeper"
if ! command -v minesweeper &> /dev/null
then
    git clone --depth=1 git://joshstock.in/ncurses-minesweeper.git $SRCFOLDER/ncurses-minesweeper
    cd $SRCFOLDER/ncurses-minesweeper
    make compile build
    install bin/minesweeper /usr/local/bin/minesweeper
    rm -rf $SRCFOLDER/ncurses-minesweeper
    cd $SCRIPT_DIR
fi

if [ $UNIT == "DESKTOP" ] || [ $UNIT == "LAPTOP" ]; then
    # GTK config
    category "GTK config"

    GTKDIR=$HOME/.config/gtk-3.0
    item "~/.config/gtk-3.0/"
    mkdir -p $GTKDIR

    item "~/.config/gtk-3.0/gtk.css"
    install $SCRIPT_DIR/gtk.css $GTKDIR/gtk.css

    item "Terminal theme 'Oceanic Next'"
    $SCRIPT_DIR/terminal_theme.sh $1 &>/dev/null

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
install $SCRIPT_DIR/.gitconfig $HOME/.gitconfig

# Vim
category "Vim config"

if [ $UNIT == "HEADLESS" ]; then
    item "/usr/share/vim/"
    VIMDIR=/usr/share/vim
    mkdir -p $VIMDIR
else
    item "~/.vim/"
    VIMDIR=$HOME/.vim
    mkdir -p $VIMDIR
fi

item "~/.vim/vimrc"
if [ $UNIT == "HEADLESS" ]; then
    grep -v "RMHEADLESS" vimrc > $SCRIPT_DIR/.vimrc_headless
    install $SCRIPT_DIR/.vimrc_headless $VIMDIR/vimrc
else
    install $SCRIPT_DIR/vimrc $VIMDIR/vimrc
fi

item "~/.vim/autoload/plug.vim"
if [ $UNIT == "HEADLESS" ]; then
    curl -fLso $VIMDIR/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
else
    curl -fLso $VIMDIR/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# Done
echo -e " \e[1;33mDONE\e[0m"
