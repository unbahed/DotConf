function pmh

    set clients $(hyprctl clients -j)
    set length $(echo $clients | jq length)
    set mpcounter 0
    set index 0

    for i in (seq 0 $(math $length - 1))
        set class $(echo $clients | jq ".["$i"].class")
        if [ $class = "\"AudioControl\"" ]
            set mpcounter $(math $mpcounter + 1)
            set index $i
        end
    end
    if [ $mpcounter = 0 ]
        kitty --app-id AudioControl -e pulsemixer
    else
        for i in $index
            set pid $(echo $clients | jq ".["$i"].pid")
            kill $pid
        end
    end
end
