#!/bin/bash -x
echo "Welcome to Snake and Ladder game ! Good Luck!"
readonly PLAYERPOSITION=0
declare -A diceResult
diceCount=0
player=1

#Checking the player's turn and change accordingly. 
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
#Rolling the dice using RANDOM function to generate 6 random values
rollDice()
{
	storeDice=$(($((RANDOM%6))+1))	
}

#Check untill it reaches the winning position 100
repeatTillWinningPosition()
{ 	
	currentPosition=$PLAYERPOSITION
	while [[ $currentPosition -le 100 ]]
	do
		rollDice
		currentPosition=${diceResult[$((diceCount-1))]}
		((diceCount++))
#check until it reaches exact winning position 
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
#Check whether option is noplay,ladder or snakebite
checkOption() 
{
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
		      	currentPosition=$PLAYERPOSITION
			diceResult[$diceCount]=$currentPosition
	        fi
		;;
	esac
}

repeatTillWinningPosition

