A simple scrinpt to install and run my hprland arch rice.

# Installing and running

## Installing fish
    sudo pacman -Syyu && sudo pacman -S fish

## Running the program
    git clone https://github.com/unbahed/DotConf.git
    cd DotConf
    fish install.fish

# How it works

After running the program it will backup the your config files and store them at ~/.backup.
Then it will update your arch and try to install the dependencies.
When the update and the installation of dependencies are done, it will copy the config files into your .config folder and reloading hyprland(it assumes that you are running it in hyprland).

