#!/usr/bin/env bash

isY() {
    if [ $1 = 'Y' ] || [ $1 = 'y' ]; then
        true
    else
        false
    fi
}

bold=$(tput bold)
norm=$(tput sgr0)

read -p "Do you want to swap ${bold}Esc${norm} and ${bold}~${norm} ? (Y/N) :" isSwapEsc

read -p "Do you want to turn ${bold}Capslock${norm} into ${bold}Control${norm} ? (Y/N) :" isSwapCtrl

isSwapEsc=`isY $isSwapEsc`
isSwapCtrl=`isY $isSwapCtrl`

if $isSwapEsc || $isSwapCtrl; then
    touch ~/.Xmodmap
fi

if $isSwapEsc; then
    echo "keycode  49 = Escape NoSymbol Escape" >> ~/.Xmodmap
    echo "keycode 9 = grave asciitilde grave asciitilde" >> ~/.Xmodmap
fi

if $isSwapCtrl; then
    echo "clear lock" >> ~/.Xmodmap
    echo "clear control" >> ~/.Xmodmap
    echo "keycode 66 = Control_L NoSymbol Control_L" >> ~/.Xmodmap
    echo "add control = Control_L Control_R" >> ~/.Xmodmap
fi

if $isSwapEsc || $isSwapCtrl; then
    xmodmap ~/.Xmodmap
    if [ $? = 0 ]; then
        echo "Config has been written to ~/.Xmodmap and applied successfully ".
    fi
fi
