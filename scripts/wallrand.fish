set confDir ~/.config/hypr
set theme $(grep \$ThemeName -m 1 $confDir/hyprland.conf | cut -d '=' -f 2)
set wallDir $confDir/themes/$theme/walls/

function wallrand
    set mode $(cat  $confDir/hyprland.conf | grep "\$ThemeMode=" | cut -d '=' -f 2)
    find $wallDir/$mode/* -type f | shuf -n 1 | xargs swww img --transition-fps 500 --transition-type wave 
end
