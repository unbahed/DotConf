set stateFile ~/.config/hypr/spstate

function write_to_file -a address home
    echo $address","$home >> $stateFile
end
function sph
    set current_address $(hyprctl activewindow -j | jq ".pid")
    set current_home $(hyprctl activewindow -j | jq ".workspace.id")

    set stateFileContent $(cat $stateFile)

    if [ $current_home != -99 ]
        write_to_file $current_address $current_home
        hyprctl dispatch movetoworkspace special
    else
        if set -q stateFileContent[1]
            set home $(cat $stateFile | grep $current_address | cut -d ',' -f 2)
            if set -q home[1]
                set tmp 's/\b'$current_address'\b.*/''/'
                sed -i -e $tmp $stateFile
                hyprctl dispatch movetoworkspace $home
            else
                hyprctl dispatch movetoworkspace 1
            end
        end
    end
end
