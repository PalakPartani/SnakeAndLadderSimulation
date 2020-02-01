#!/bin/bash -x
echo "Welcome to Snake and Ladder game ! Good Luck!"
readonly playerPostion=0

rollDice() {
	storeDice=$(($((RANDOM%6))+1))	
}

repeatTillWinningPosition(){ 
	
	currentPosition=$playerPosition
	while [[ $currentPosition -le 100 ]]
	do
		rollDice
		if (( $(($currentPosition+$storeDice)) == 100))
		then 	
			currentPosition=100
			break
		elif (( $(($currentPosition+$storeDice)) > 100))
		then
			currentPosition=$currentPosition
		else
			checkOption	
		fi	
	done
	}
checkOption() {
	option=$(($((RANDOM%3))+1)) 
	case $option in
			1)
				currentPosition=$currentPosition
				;;		
			2)
				currentPosition=$(($currentPosition + $storeDice))	
				;;
			3)
				currentPosition=$(($currentPosition - $storeDice))
				  if (($currentPosition < 0))
      			then
        				 currentPosition=0
    				fi
				;;
	esac
}

repeatTillWinningPosition

