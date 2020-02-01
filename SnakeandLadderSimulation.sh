#!/bin/bash -x
echo "Welcome to Snake and Ladder game ! Good Luck!"
readonly playerPostion=0
declare -A diceResult
diceCount=0
player=1

checkPlayerTurn()
{
	if (( $player == 1 ))
	then
		player=2
	elif (( $player == 2 ))
	then
		player=1
	fi
}
rollDice() {
	storeDice=$(($((RANDOM%6))+1))	
	}

repeatTillWinningPosition(){ 
	
	currentPosition=$playerPosition
	while [[ $currentPosition -le 100 ]]
	do
		rollDice
		currentPosition=${diceResult[$diceCount]}
		((diceCount++))
			if (( $(($currentPosition+$storeDice)) == 100))
			then 	
				diceResult[$diceCount]=100
				echo "Player $player wins the game!"
				break
			elif (( $(($currentPosition+$storeDice)) > 100))
			then
				 diceResult[$diceCount]=$currentPosition
			else
				checkOption	
			fi	
	checkPlayerTurn
	done
	}
checkOption() {
	option=$(($((RANDOM%3))+1)) 
	case $option in
			1)
				 diceResult[$diceCount]=$currentPosition
				;;		
			2)
				 diceResult[$diceCount]=$(($currentPosition + $storeDice))	
				;;
			3)
				diceResult[$diceCount]=$(($currentPosition - $storeDice))
				  if (($currentPosition < 0))
      			then
        				 currentPosition=$playerPosition
						diceResult[$diceCount]=$currentPosition
    				fi
				;;
	esac
}

repeatTillWinningPosition

