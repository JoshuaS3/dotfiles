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

export COLOR_01="#121C21"           # HOST
export COLOR_02="#E44754"           # SYNTAX_STRING
export COLOR_03="#89BD82"           # COMMAND
export COLOR_04="#F7BD51"           # COMMAND_COLOR2
export COLOR_05="#5486C0"           # PATH
export COLOR_06="#B77EB8"           # SYNTAX_VAR
export COLOR_07="#50A5A4"           # PROMP
export COLOR_08="#FFFFFF"           #

export COLOR_09="#52606B"           #
export COLOR_10="#E44754"           # COMMAND_ERROR
export COLOR_11="#89BD82"           # EXEC
export COLOR_12="#F7BD51"           #
export COLOR_13="#5486C0"           # FOLDER
export COLOR_14="#B77EB8"           #
export COLOR_15="#50A5A4"           #
export COLOR_16="#FFFFFF"           #


export BACKGROUND_COLOR="#1b2b34"   # Background Color
export FOREGROUND_COLOR="#cdcfd4"   # Text
export CURSOR_COLOR="$FOREGROUND_COLOR" # Cursor
export PROFILE_NAME="Oceanic Next"

./apply-colors.sh
