#!/bin/bash
# Used to init the nvim in different devices

# --------------------
# IS First ?
# --------------------
if test -e ./init_nvim/IsFirst
then
    echo -e "This is \033[31mnot\033[0m the first time to use this script"
    echo "What do you want to do?"
    while true
    do
        echo -e "\033[33m"
        echo "c) ColorScheme"
        echo "q) Quit"
        echo -e "\033[0m"
        read Choice
        # if [ ! $Choice ]    # if nil
        # then
        #     continue
        # fi
        case $Choice in
            c)
                Choose_a_ColorScheme
                ;;
            q)
                echo "Quit"
                break
                ;;
            *)
                continue
                ;;
        esac
    done
    uset Choice
    echo "Done!"
else
    echo "This is the first time to use this script"
    Choose_a_ColorScheme
fi

# --------------------
# Choose a ColorScheme
# --------------------
function Choose_a_ColorScheme() {
    if test ! -e ~/.config/nvim/lua/plugins/colorscheme.lua
    then
        source ./init_nvim/script/Colorscheme.sh
    else
        echo "ColorScheme founde"
        echo "Do you want to change it?"
        read -p "Y/N Default: [N]" YorN
        if [ ! $YorN ]
        then
            YorN=N
        fi
        if [ $YorN = "Y" ]
        then
            rm -f ~/.config/nvim/lua/plugins/colorscheme.lua
            source ./init_nvim/script/Colorscheme.sh
        else
            echo "Skip"
        fi
    fi
    unset YorN
}
