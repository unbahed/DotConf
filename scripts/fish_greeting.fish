function fish_greeting
        set greetDir ~/.config/hypr/greeter_art

        set themename $(grep "\$ThemeName=" ~/.config/hypr/hyprland.conf | cut -d '=' -f 2)
        if [ $themename = "bw" ]
                echo "H3ll0 "$USER | xargs cowsay -r
                echo "T!M3: " (date +%T)
                echo 
        else
                echo "H3ll0 "(set_color green) $USER | xargs cowsay -r | lolcat 
                echo (set_color red)"T!M3: " (set_color yellow)(date +%T) | lolcat 
                echo 
        end
end 
