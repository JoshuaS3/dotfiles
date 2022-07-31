#!/bin/bash

HELPTEXT="./terminal_theme.sh <desktop|laptop>"
case $1 in
    h|help|\?|-h|-help|-\?|--h|--help|--\?)
        echo -e $HELPTEXT
        exit 0
        ;;
    desktop)
        export TERMINAL="gnome-terminal"
        ;;
    laptop)
        export TERMINAL="gnome-terminal"
        ;;
    *)
        echo "Bad input $1"
        echo -e $HELPTEXT
        exit 0
        ;;
esac

cd "/tmp"
if [ ! -f apply-colors.sh ]; then
    wget -qO apply-colors.sh https://raw.githubusercontent.com/Mayccoll/Gogh/master/apply-colors.sh
    chmod +x apply-colors.sh
fi

export COLOR_01="#292D3E"           # Black
export COLOR_02="#F07178"           # Red
export COLOR_03="#62DE84"           # Green
export COLOR_04="#FFCB6B"           # Yellow
export COLOR_05="#75A1FF"           # Blue
export COLOR_06="#F580FF"           # Magenta
export COLOR_07="#60BAEC"           # Cyan
export COLOR_08="#ABB2BF"           # Light gray

export COLOR_09="#959DCB"           # Dark gray
export COLOR_10="#F07178"           # Light Red
export COLOR_11="#C3E88D"           # Light Green
export COLOR_12="#FF5572"           # Light Yellow
export COLOR_13="#82AAFF"           # Light Blue
export COLOR_14="#FFCB6B"           # Light Magenta
export COLOR_15="#676E95"           # Light Cyan
export COLOR_16="#FFFEFE"           # White


export BACKGROUND_COLOR="#1b2b34"   # Background Color
export FOREGROUND_COLOR="#BFC7D5"   # Foreground Color (text)
export CURSOR_COLOR="$FOREGROUND_COLOR" # Cursor color
export PROFILE_NAME="Gogh"


./apply-colors.sh
