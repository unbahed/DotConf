function exist -a instance dir
	set list $(ls -a $dir)
	if contains $instance $list
		echo true
	else
		echo false
	end
end

function confirm -a name
	while true
		read -l -P "Do you want to use $name config? [Y/n]: " ans
		
		switch $ans
			case '' Y y yes YES Yes yEs yeS
				return 0
			case N n No NO no
				return 1
		end
	end
end

function backup
	if [ $(exist .backup $home_dir) = false ]
		mkdir $home_dir/.backup
	end

	set backup_name $(date | sha256sum | cut -d ' ' -f 1)
	set backup_dir $home_dir/.backup/$backup_name
	set backup_list $(cat backup_list)
	mkdir $backup_dir

	for i in $backup_list
		mkdir $backup_dir/$i
		rsync -a $conf_dir/$i/ $backup_dir/$i
	end
end

function dep
	set deps $(cat dependencies)
	echo "Updating system and installing dependencies"
	sudo pacman -Syyu
	for i in $deps
		set -a ins $(echo $i)
	end
	echo $ins
	sudo pacman -S $ins
end

function install
	echo "creating a backup at ~/.backup/ directory"
	backup
	clear
	dep
	clear
	set in_dir $(ls myConf)
	for i in $in_dir
		if confirm $i
			rm -rf $conf_dir/$i
			cp -r myConf/$i $conf_dir
		end
	end
	cp -r scripts/* $conf_dir/fish/functions/
	hyprctl reload
	fish scripts/themeSelection.fish
	clear
	echo "we are done! enjoy!" | lolcat
end


set conf_dir /home/$USER/.config
set home_dir /home/$USER

install
