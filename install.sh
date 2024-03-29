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

# Misc config
category "Misc config"
item "~/.todo.cfg"
install $SCRIPT_DIR/.todo.cfg $HOME/.todo.cfg
item "~/.xonshrc"
install $SCRIPT_DIR/.xonshrc $HOME/.xonshrc
item "~/.xonsh_aliases"
install $SCRIPT_DIR/.xonsh_aliases $HOME/.xonsh_aliases

category "Common folders"
item "~/src/"
SRCFOLDER=$HOME/src
mkdir -p $SRCFOLDER
item "~/.local/bin/"
LOCALBIN=$HOME/.local/bin
mkdir -p $LOCALBIN
item "~/.local/share/"
mkdir -p $HOME/.local/share

# Local scripts
if [ $UNIT != "HEADLESS" ] && [ $(whoami) != "root" ]; then
    category "Local scripts"
    item "~/.local/bin/middle-mouse-scroll"
    install $SCRIPT_DIR/middle-mouse-scroll $LOCALBIN/middle-mouse-scroll
    item "~/.local/bin/middle-mouse-reset"
    install $SCRIPT_DIR/middle-mouse-reset $LOCALBIN/middle-mouse-reset
fi

if ! command -v minesweeper &> /dev/null
then
    if [ $(whoami) == "root" ]; then
        item "/usr/local/bin/minesweeper"
    else
        item "~/.local/bin/minesweeper"
    fi
    git clone --depth=1 git://joshstock.in/ncurses-minesweeper.git $SRCFOLDER/ncurses-minesweeper
    cd $SRCFOLDER/ncurses-minesweeper
    make compile build
    if [ $(whoami) == "root" ]; then
        install bin/minesweeper /usr/local/bin/minesweeper
    else
        install bin/minesweeper $LOCALBIN/minesweeper
    fi
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

    item "Terminal theme"
    $SCRIPT_DIR/terminal_theme.sh $1 &>/dev/null

    if [ $(whoami) == "root" ]; then
        # Fonts
        category "Fonts"
        FONTDIR=/usr/share/fonts

        item "Fira Sans pack"
        if [ ! -f $FONTDIR/FiraSans-Regular.ttf ]; then
            curl -fLso /tmp/Fira.zip https://fonts.google.com/download?family=Fira%20Sans
            unzip -q /tmp/Fira.zip -d $FONTDIR
        fi

        item "Fira Mono (Nerd Fonts) pack"
        if [ ! -f $FONTDIR/FiraMono-Regular.otf ]; then
            curl -fLso $FONTDIR/FiraMono-Regular.otf https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/FiraMono/Regular/complete/Fura%20Mono%20Regular%20Nerd%20Font%20Complete%20Mono.otf
        fi
        if [ ! -f $FONTDIR/FiraMono-Medium.otf ]; then
            curl -fLso $FONTDIR/FiraMono-Medium.otf https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/FiraMono/Medium/complete/Fura%20Mono%20Medium%20Nerd%20Font%20Complete%20Mono.otf
        fi
        if [ ! -f $FONTDIR/FiraMono-Bold.otf ]; then
            curl -fLso $FONTDIR/FiraMono-Bold.otf https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/FiraMono/Bold/complete/Fura%20Mono%20Bold%20Nerd%20Font%20Complete%20Mono.otf
        fi

        item "Refreshing font cache"
        fc-cache
    fi
fi

# Global git config
category "Global git config"

if [ $(whoami) == "root" ]; then
    item "/etc/gitconfig"
    install $SCRIPT_DIR/.gitconfig /etc/gitconfig
else
    item "~/.gitconfig"
    install $SCRIPT_DIR/.gitconfig $HOME/.gitconfig
fi

# Vim
category "Vim config"

if [ $UNIT == "HEADLESS" ]; then
    if [ $(whoami) == "root" ]; then
        item "/usr/share/vim/"
        VIMDIR=/usr/share/vim
        mkdir -p $VIMDIR
        item "/usr/share/vim/vimrc"
        grep -v "RMHEADLESS" vimrc > $SCRIPT_DIR/.vimrc_headless
        install $SCRIPT_DIR/.vimrc_headless $VIMDIR/vimrc
        VIMRUNTIME=`vim -e -T dumb --cmd 'exe "set t_cm=\<C-M>"|echo $VIMRUNTIME|quit' | tr -d '\015' `
        item "$VIMRUNTIME/autoload/plug.vim"
        if [ ! -f $VIMRUNTIME/autoload/plug.vim  ]; then
            curl -fLso $VIMRUNTIME/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        fi
    fi
else
    item "~/.vim/"
    VIMDIR=$HOME/.vim
    mkdir -p $VIMDIR
    item "~/.vim/vimrc"
    install $SCRIPT_DIR/vimrc $VIMDIR/vimrc
    item "~/.vim/autoload/plug.vim"
    if [ ! -f $VIMDIR/autoload/plug.vim  ]; then
        curl -fLso $VIMDIR/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    fi
fi

# Done
echo -e " \e[1;33mDONE\e[0m"
