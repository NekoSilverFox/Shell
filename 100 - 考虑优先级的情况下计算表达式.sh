#!/bin/bash

ARRAY_SIZE=$#
TEMP_ANSWER=
ANSWER=0
COUNT_MUL_DIV=0
COUNT_MERGE_ARR=0
# Make a array
declare -a ARRAY


#############################################
# Simply arithmetic
#############################################
Calculation ()
{
	case "$2" in
	"+")
		TEMP_ANSWER=`bc <<< "$1 + $3"`
		;;
	"-")
		TEMP_ANSWER=`bc <<< "$1 - $3"`
		;;
	"x"|"X")
		TEMP_ANSWER=`bc <<< "$1 * $3"`
		;;
	"/")
		if [[ $3 -eq "0" ]]; then
			echo -e "\033[31mMath error! Cannot divide by zero!\033[0m"
			kill $$
		fi
		TEMP_ANSWER=`bc <<< "$1 / $3"`
		;;
	esac
}


#############################################
# Check that expressions are formatted correctly
#############################################
Check ()
{
	declare INDEX=1
	echo "=============Cheack============="
    #for i in ${ARRAY[@]}
    while [ 1 ]
    do
    	if [ "$INDEX" = $ARRAY_SIZE ]; then
    		if grep '^[[:digit:]]*$' <<< "${ARRAY[$INDEX]}">/dev/null; then
    			echo -e "--> Check num \033[32m${ARRAY[$INDEX]}\033[0m right"
    			echo "================================"
    			echo
    			return
    		else
				echo -e "\033[31mExpression format error! [Check-1]\033[0m"
    			echo "================================"
    			echo
				kill $$
			fi
		fi

        if grep '^[[:digit:]]*$' <<< "${ARRAY[$INDEX]}">/dev/null; then
        		echo -e "--> Check num \033[32m${ARRAY[$INDEX]}\033[0m right"
				let INDEX=INDEX+1

				case "${ARRAY[$INDEX]}" in
				"+"|"-"|"x"|"X"|"/")
					echo -e "--> Check sign \033[32m${ARRAY[$INDEX]}\033[0m right"
					let INDEX=INDEX+1
					;;
				*)
					echo -e "\033[31mxpression format error ${ARRAY[$INDEX]} ! [Check-2]\033[0m"
					kill $$
					;;
				esac
		else 
			echo -e "\033[31mExpression format error! [Check-3]\033[0m"
			kill $$
		fi 

    done
}


#############################################
# Calculating and combining multiplication and division into expressions
#############################################
MergeArry()
{
	declare FROUNT_INDEX=0
	declare INDEX=1
	declare AFTER_INDEX=2
	declare AFTER2_INDEX=2
	
	while [ "$INDEX" != "$ARRAY_SIZE" ]
	do
#		echo "$INDEX"
#		echo "$ARRAY_SIZE"

		case "${ARRAY[$INDEX]}" in
		"x"|"X"|"/")
			let FROUNT_INDEX=INDEX-1
			let AFTER_INDEX=INDEX+1
			Calculation ${ARRAY[$FROUNT_INDEX]} ${ARRAY[$INDEX]} ${ARRAY[$AFTER_INDEX]}
#			echo -e "\033[31mTEST UNIT 1\033[0m" #################################
			;;
		*)
			let INDEX=INDEX+1
#			echo -e "\033[31mTEST UNIT 2 $INDEX\033[0m" #################################
			continue
			;;
		esac

		ARRAY[$FROUNT_INDEX]=$TEMP_ANSWER
		

		while [ "$INDEX" != "$ARRAY_SIZE" ]; do
			let AFTER2_INDEX=INDEX+2
			ARRAY[$INDEX]=${ARRAY[$AFTER2_INDEX]}
			let INDEX=INDEX+1
#			echo -e "\033[31mTEST UNIT 3 $INDEX\033[0m" #################################
		done

		ARRAY_SIZE=$[$ARRAY_SIZE-2]
		#let INDEX=INDEX+1
		ARRAY[$INDEX]=
		
		echo -e "\033[32mMergeArry done, array structure:\033[0m"
		ShowArray
		return
	done	
}


#############################################
# Calculating and combining multiplication and division into 
# expressionsTotal number of multiplications and divisions in 
# statistical expressions
#############################################
MulAndDiv()
{
	for i in ${ARRAY[@]}; do
		case "$i" in
		"x"|"X"|"/" )
			COUNT_MUL_DIV=$[$COUNT_MUL_DIV+1]
			;;
		esac
    done
#    echo "$COUNT_MUL_DIV"

	while [ "$COUNT_MERGE_ARR" != "$COUNT_MUL_DIV" ]; do
		MergeArry
		COUNT_MERGE_ARR=$[$COUNT_MERGE_ARR+1]
	done
}


#############################################
# When all multiplication and division are completed, 
# call this function to complete the remaining addition and subtraction.
#############################################
AddAndSub()
{
	echo -e "\033[32mMultiplication and division have been calculated. Start calculating addition and subtraction\033[0m"
    
	#declare LEFT=1
	declare INDEX=1
	declare SIGN=2
	declare RIGHT=3
	ANSWER=${ARRAY[1]}

	while [ "$INDEX" != "$ARRAY_SIZE" ]; do
		Calculation $ANSWER ${ARRAY[SIGN]} ${ARRAY[RIGHT]}
		let INDEX=INDEX+2
		let SIGN=INDEX+1
		let RIGHT=INDEX+2
		ANSWER="$TEMP_ANSWER"
	done
}


#############################################
# Print out the contents of the array
#############################################
ShowArray()
{
    echo "=============Array============="

    for i in ${ARRAY[@]}; do
        echo "--> "$i
    done

    echo "==============================="
    echo
}


#############################################
# The main function. Putting expressions into arrays
#############################################
Main ()
{
	TEMP_COUNT=0

    if [ -z "$1" ]; then
        echo -e "\033[31mError! The input parameter is empty!\033[0m"
		kill $$
    fi

    while [ $# != 0 ]; do
    	let TEMP_COUNT=TEMP_COUNT+1
    	ARRAY[$TEMP_COUNT]=$1
    	shift
    done    
}

Main $*

ShowArray

Check

MulAndDiv

AddAndSub

echo -e "Answer: \033[42;31m$ANSWER\033[0m"