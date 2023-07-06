#!/bin/bash
function init_colorscheme(){
    echo "Choose a ColorScheme:"
    declare -A colorscheme
    count=0
    for name in ` ls ~/.config/nvim/init_nvim/unique/colorscheme/ `
    do
        count=$((count+1))
        colorscheme[$count]=$name
        echo -e "${count})\t${name}"
    done
    unset $name
    # get what U like
    while true
    do
        read -p "Default: [1]" Choice_ColorScheme
        if [ ! $Choice_ColorScheme ]
        then
            Choice_ColorScheme=1
        fi
        echo "Your Choice is: $Choice_ColorScheme"
        if (( $Choice_ColorScheme <= $count && $Choice_ColorScheme > 0 ))
        then
            break
        else
            echo -e "\033[;31m Error\033[0m try again"
        fi
    done
    unset count
    # write to colorscheme.lua
    cp ../unique/colorscheme/${colorscheme[$Choice_ColorScheme]} ~/.config/nvim/lua/plugins/colorscheme.lua
    unset Choice_ColorScheme
    unset colorscheme
}
init_colorscheme
