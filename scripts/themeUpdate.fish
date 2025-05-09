set confDir $HOME/.config
set hyprConf $confDir/hypr/hyprland.conf
set themeDir $confDir/hypr/themes
set themeSelected $(grep \$ThemeName -m 1 $hyprConf | cut -d '=' -f 2)


#Changing to new theme

sed -i -e "s/\(\$ThemeName=\).*/\1$themeSelected/" $hyprConf

cp -r $themeDir/$themeSelected/waybar/* $confDir/waybar/
cp -r $themeDir/$themeSelected/kitty/* $confDir/kitty/
cp -r $themeDir/$themeSelected/rofi/* $confDir/rofi/
cp -r $themeDir/$themeSelected/browser/firefox/includes/* ~/.librewolf/w2hfov3z.default-default/chrome/includes/

killall waybar
exec waybar && hyprctl reload
