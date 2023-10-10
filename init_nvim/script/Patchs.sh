#!/bin/bash
function init_patchs(){
    echo "now init patchs"
    cp -rf ~/.config/nvim/init_nvim/unique/patchs/* ~/.config/nvim/lua/patchs/
}

init_patchs()
