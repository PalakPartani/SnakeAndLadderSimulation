#!/bin/bash 
echo "Welcome to Snake and Ladder game ! Good Luck!"
readonly PLAYER_POSITION=0
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
	currentPosition=$PLAYER_POSITION
	while [[ $currentPosition -ne 100 ]]
	do
		rollDice
		((diceCount++))
		currentPosition=${diceResult[$((diceCount-1))]}
		checkExactWinningPosition
		checkPlayerTurn
	done
	#checkPlayerTurn
}

checkExactWinningPosition()
{
#check until it reaches exact winning position 
		if (( $(($currentPosition+$storeDice)) == 100))
		then 	
			diceResult[$diceCount]=100
			echo "Player $player wins the game!"
			#break
		elif (( $(($currentPosition+$storeDice)) > 100))
		then
			diceResult[$diceCount]=$currentPosition
		else
		   checkOption	
		fi	
		
	
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
		currentPosition=$(($currentPosition - $storeDice))
		diceResult[$diceCount]=$currentPosition
		if (($currentPosition < 0))
      	        then
		      	currentPosition=$PLAYER_POSITION
			diceResult[$diceCount]=$currentPosition
	        fi
		;;
	esac
}

repeatTillWinningPosition

