declare -a apps=(
                "firefox"
                "konsole"
                "dolphin"
                "telegram"
                "kate"
                "settings"
                "libreoffice"
                "okular"
                )

for i in "${apps[@]}"
do
    widarray=( $(xdotool search --class $i) )

    for j in "${widarray[@]}"
    do
        max_state=`xprop -id $j _NET_WM_STATE`

        wmctrl -ir $j -b remove,maximized_vert,maximized_horz
        eval `xdotool getwindowgeometry --shell $j`

        ((new_x=1920+$X))
        if [[ "$X" -ge 1920 ]]; then
            ((new_x=0+$X-1920))
        fi

        xdotool windowmove $j $new_x $Y
        if [ -z "${max_state/*_NET_WM_STATE_MAXIMIZED_*/}" ]; then
            wmctrl -ir $j -b add,maximized_vert,maximized_horz
        fi
    done
done
