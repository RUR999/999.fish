function center -a width
    set -e argv[1] #Remove width argument
    set -l len (string length -- "$argv")
    if test $len -lt $width
        set -l half (math -s 0 "($width / 2)" + "($len / 2)")
        set -l rem (math -s 0 $width - $half)
        printf "%*.*s%*s\n" $half $len "$argv" $rem ' '
    else
        printf "%*.*s\n" $width $width "$argv"
    end
end

echo ""
set_color -o green
echo "$bname"|figlet -w $(tput cols) -cf ar
set_color -o blue
center $COLUMNS "Hello $name ..."|pv -qL 10
center $COLUMNS "Welcome To Termux ..."
echo ""
set_color normal
