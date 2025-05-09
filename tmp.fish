function confirm -a name
	while true
		read -l -P "Do you want to use $name config? [Y/n]" ans
		
		switch $ans
			case Y y yes YES Yes yEs yeS
				return 1
			case '' N n No NO no
				return 0
		end
	end
end

set test $(confirm ass)

echo test
