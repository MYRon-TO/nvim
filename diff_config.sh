#!/bin/bash
# Used to init the nvim in different devices

#  ______   __  __  ______  ______                __    __ 
# /\__  _\ /\ \/\ \/\__  _\/\__  _\      /'\_/`\ /\ \  /\ \
# \/_/\ \/ \ \ `\\ \/_/\ \/\/_/\ \/     /\      \\ `\`\\/'/
#    \ \ \  \ \ , ` \ \ \ \   \ \ \     \ \ \__\ \`\ `\ /' 
#     \_\ \__\ \ \`\ \ \_\ \__ \ \ \     \ \ \_/\ \ `\ \ \ 
#     /\_____\\ \_\ \_\/\_____\ \ \_\     \ \_\\ \_\  \ \_\
#     \/_____/ \/_/\/_/\/_____/  \/_/      \/_/ \/_/   \/_/
#                                                          
#                                                          
#    ____     _____   __  __  ____    ______   ____      
#   /\  _`\  /\  __`\/\ \/\ \/\  _`\ /\__  _\ /\  _`\    
#   \ \ \/\_\\ \ \/\ \ \ `\\ \ \ \L\_\/_/\ \/ \ \ \L\_\  
#    \ \ \/_/_\ \ \ \ \ \ , ` \ \  _\/  \ \ \  \ \ \L_L  
#     \ \ \L\ \\ \ \_\ \ \ \`\ \ \ \/    \_\ \__\ \ \/, \
#      \ \____/ \ \_____\ \_\ \_\ \_\    /\_____\\ \____/
#       \/___/   \/_____/\/_/\/_/\/_/    \/_____/ \/___/ 
#                                                        

# --------------------
# Choose a ColorScheme
# --------------------
function Choose_a_ColorScheme() {
    if test ! -e ~/.config/nvim/lua/plugins/colorscheme.lua
    then
        source ./init_nvim/script/Colorscheme.sh
    else
        while true
        do
            echo "ColorScheme found"
            echo "Do you want to change it?"
            read -p "Y/N Default: [N]" YorN
            if [ ! $YorN ]
            then
                YorN=N
            fi
            if [ $YorN = "Y" -o $YorN = "y" ]
            then
                rm -f ~/.config/nvim/lua/plugins/colorscheme.lua
                source ./init_nvim/script/Colorscheme.sh
                break
            elif [ $YorN = "N" -o $YorN = "n" ]
            then
                echo "Skip"
                break
            else
                echo "Wrong input"
                continue
            fi
        done
    fi
    unset YorN
}

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
