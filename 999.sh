#!/bin/bash
r="\033[1;31m"
g="\033[1;32m"
c="\033[1;36m"
b="\033[1;34m"
n="\033[0m"
boxq="\033[1;34m[\033[1;32m?\033[1;34m]"
boxg="\033[1;34m[\033[1;32m+\033[1;34m]"
boxr="\033[1;34m[\033[1;31m!\033[1;34m]"
. <(curl -sLo- "https://raw.githubusercontent.com/RUR999/spinner/refs/heads/main/spin.sh")

banner() {
    echo -e "${g}╔═══╗╔═══╗╔═══╗╔═╦╦═╦╗\n║╔═╗║║╔═╗║║╔═╗║║═╬╣═╣╚╗\n║╚═╝║║╚═╝║║╚═╝║║╔╣╠═║║║\n╚══╗║╚══╗║╚══╗║╚╝╚╩═╩╩╝\n╔══╝║╔══╝║╔══╝║ ${c}by RUR99\n\n${n}"
}

clear;banner
rm -rf ~/../usr/etc/motd
rm -rf ~/.config/fish/functions/*
rm -rf ~/.config/fish/config.fish
pkgs=( fish figlet )
for pkg in "${pkgs[@]}";do
    echo -e "${boxg} ${g}Installing ${pkg}${n}"
    (pkg install -y ${pkg}) &> /dev/null & spin
    if [[ $(command -v ${pkg}) ]]; then
    echo -e "${boxg}${g} ${pkg} Installed Successfull${n}"
    else
    echo -e "${boxr} ${r}Install Error ${pkg}. ${g}First Install ${pkg} Manually Then Run Again${n}"
    exit
    fi
done
echo -e "${boxg} ${g}Downloading Functions File${n}"
(curl https://raw.githubusercontent.com/RUR999/999.fish/refs/heads/main/functions/fish_greeting.fish -o ~/.config/fish/functions/fish_greeting.fish) &> /dev/null & spin
(curl https://raw.githubusercontent.com/RUR999/999.fish/refs/heads/main/functions/fish_prompt.fish -o ~/.config/fish/functions/temp.fish) &> /dev/null & spin
(curl https://raw.githubusercontent.com/RUR999/999.fish/refs/heads/main/functions/config.fish -o ~/.config/fish/temp2.fish) &> /dev/null & spin
    
termpro(){
    echo -en "${boxq} ${g}Do You Want To Change Extra Key & Cursor Style? (y/n)${n} "
    read tp
    case $tp in
    Y|y)
    rm -rf .termux/termux.properties
    (curl https://raw.githubusercontent.com/RUR999/999.fish/refs/heads/main/files/termux.properties -o .termux/termux.properties) &> /dev/null & spin
    ;;
    N|n) 
    echo ""
    ;;
    *) echo -e "${boxr} ${r}Wrong Input"
    termpro
    ;;
    esac
}



setban(){
    clear;banner
    echo -en "${boxq} ${g}Enter Bar Name${n}: "
    read name
    while true; do
    echo -en "${boxq} ${g}Enter Banner Name${n}: "
    read bname
    if [[ ${#bname} -gt 8 ]]; then
    echo -e "${boxr} ${r}Enter Banner Name Less Than 8 Characters${n}"
    continue
    else
    break
    fi
    done
    echo "set name \"${name}\""> ~/.config/fish/functions/fish_prompt.fish
    cat ~/.config/fish/functions/temp.fish >> ~/.config/fish/functions/fish_prompt.fish
    echo "set bname \"${bname}\"
    set name \"${name}\""> ~/.config/fish/config.fish
    cat ~/.config/fish/temp2.fish >> ~/.config/fish/config.fish
    rm -rf ~/.config/fish/functions/temp.fish
    rm -rf ~/.config/fish/temp2.fish
}

main(){
    clear; banner
    setban
    termpro
    chsh -s fish
    termux-reload-settings
    clear; banner
    echo -e "${boxg} ${g}Now Exit From Termux And Again Open Termux${n}"
}
main
