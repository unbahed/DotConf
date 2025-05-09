set confDir $HOME/.config
set hyprConf $confDir/hypr/hyprland.conf
set themeDir $confDir/hypr/themes

function modeSelection -a dir
	set walls $(ls $dir/walls/)
	set modeSelected $(for i in $walls; echo $i; end | rofi -dmenu )

	if set -q modeSelected[1]
	
		sed -i -e "s/\(\$ThemeMode=\).*/\1$modeSelected/" $hyprConf
	end
	fish -c wallrand
end

function themeSelection
	set themeSelected $(ls $themeDir | rofi -dmenu)

	if set -q themeSelected[1]
		set tmp $(grep "\$ThemeName=" $hyprConf | cut -d '=' -f 2)
		if [ $themeSelected != $tmp ]

			sed -i -e "s/\(\$ThemeName=\).*/\1$themeSelected/" $hyprConf

			cp -r $themeDir/$themeSelected/waybar/* $confDir/waybar/
			cp -r $themeDir/$themeSelected/kitty/* $confDir/kitty/
			cp -r $themeDir/$themeSelected/rofi/* $confDir/rofi/
			cp -r $themeDir/$themeSelected/browser/firefox/includes/* ~/.librewolf/w2hfov3z.default-default/chrome/includes/

			modeSelection $themeDir/$themeSelected

			killall waybar
			exec waybar 

		else if [ $themeSelected = $tmp ]

			modeSelection $themeDir/$themeSelected

		end
	

	end

	fish -c wallrand

end
