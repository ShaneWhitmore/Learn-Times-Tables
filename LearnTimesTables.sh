#{/bin/bash
MAX=20
TABLE_NUM=0
LEVEL=2
MENU_CHOICE=0
NUM_QUESTIONS=20
declare -A QUIZ_RESULTS


function main()
{
	echo "1. Teacher Menu"
	echo "2. Student Menu"
	echo "3. Quit Program"
	USERTYPE=0

	until [ $USERTYPE -ge 1 -a $USERTYPE -le 3 ]
	do
		
		read USERTYPE
		if [ $USERTYPE -lt 1 -o $USERTYPE -gt 3 ]
		then
			echo "Invalid choice, please try again"
		fi
	done
 	case $USERTYPE in
		1)
			teacher_menu # Enter Teachers Menu
			;;
		2)
			student_menu # Enter Students Menu
            ;;
		3)
			exitProgram
            ;;
		*)
			echo "Invalid Option for teacher"
            ;;
	esac
}

function teacher_menu()
{
	MENU_CHOICE=0
	echo "_____________________________________________________________"
	echo "|________________________Teacher Menu _______________________|"
	echo "1. Manage Students"
	echo "2. View Quiz Attempts"
	echo "3. View statistics"
	echo "4. Quit Program"

	until [ $MENU_CHOICE -ge 1 -a $MENU_CHOICE -le 4 ]
	do
		read MENU_CHOICE
		if [ $MENU_CHOICE -lt 1 -o $MENU_CHOICE -gt 4 ]
		then
			echo "Invalid choice, please try again"
		fi
	done
 	case $MENU_CHOICE in
		1)
			manageStudents # call managestudents fucntion
			;;
		2)
			viewQuizAttempts #managequiz function
            ;;
		3)
			viewStats
            ;;
		4)
			exitProgram
			;;	
		*)
			echo "Invalid number"
			;;
	esac
}
function student_menu()
{
	echo "_____________________________________________________________"
	echo "|________________________Student Menu _______________________|"
	echo "1. Learn Tables"
	echo "2. Take Quiz"
	echo "3. Quit the Program"
	MENU_CHOICE=0
	until [ $MENU_CHOICE -ge 1 -a $MENU_CHOICE -le 3 ]
	do 
		read MENU_CHOICE
		if [ $MENU_CHOICE -lt 1 -o $MENU_CHOICE -gt 3 ]
		then 
			echo "Invalid choice for student menu"
		fi
	done

	case $MENU_CHOICE in
		1)
			learnTables
			;;
		2) 
			takeQuiz
			;;

		3)
			exitProgram
			;;	
		*)
			echo "Invalid number"
			;;
	esac
	
}


function chooseNum()
{
	TABLE_NUM=0
	until [ $TABLE_NUM -ge 1 -a $TABLE_NUM -le $MAX ]
	do
		echo "Enter table number from 1 to,  $MAX"
		read TABLE_NUM

		if [ $TABLE_NUM -lt 1 -o $TABLE_NUM -gt $MAX ]
		then
			echo ""
		fi
	done
}



function chooseArithOp()
{
	AUTH_OP=0
	until [ $AUTH_OP -ge 1 -a $AUTH_OP -le 4 ]
	do
		echo "Choose one of the following"
		echo "1. Addition"
		echo "2. Subtraction"
		echo "3. Mulitplication"
		echo "4. Division"
		read AUTH_OP
	
		if [ $AUTH_OP -lt 1 -o $AUTH_OP -gt 4 ]
		then 
			echo "Invalid Option"
		fi
	done

}




function learnTables()
{
	chooseNum     #call function from chooseNum
	chooseArithOp # call function chooseArithO
	ANS=999
	case $AUTH_OP in 
		1)
			for ((i=0; i<= 12; i++))		#Add
			do
				until [ $ANS -eq $(($i + $TABLE_NUM)) ]
				do
					echo "What is $i + $TABLE_NUM"
					read ANS

					if [ $ANS  -eq $(($i + $TABLE_NUM)) ]
					then
						echo "Correct! The answer is $ANS"
					else
						if [ $(($i + $TABLE_NUM)) -gt $ANS ]
						then
							echo "Incorrect, but the answer is greater than $ANS, please try again" 
						else
							echo "Incorrect, but the answer is less than $ANS, please try again"
						fi
					fi 
				done
				echo ""
			done
			;;

		2)
			for ((i=12; i>=0;i--))        #Sub
                do
                    until [ $ANS  -eq $(($i - $TABLE_NUM)) ]
					do 
				 		echo "What is $i - $TABLE_NUM"
                        read ANS

                        if [ $ANS  -eq $(($i - $TABLE_NUM)) ]
                        then
							echo "Correct! The answer is $ANS"
						else
							if [ $(($i - $TABLE_NUM)) -gt $ANS ]
							then
								echo "Incorrect, but the answer is greater than $ANS, please try again" 
							else
								echo "Incorrect, but the answer is less than $ANS, please try again"
							fi
						fi
                    done
					echo ""
				done
            ;;
		3)
			#mult
			for ((i=0; i<=12;i++)) 
                do
                    until [ $ANS  -eq $(($i * $TABLE_NUM)) ]
					do 
				 		echo "What is $i x $TABLE_NUM"
                        read ANS

                        if [ $ANS  -eq $(($i * $TABLE_NUM)) ]
                    	then
							echo "Correct! The answer is $ANS"
						else
							if [ $(($i * $TABLE_NUM)) -gt $ANS ]
							then
								echo "Incorrect, but the answer is greater than $ANS, please try again" 
							else
								echo "Incorrect, but the answer is less than $ANS, please try again"
							fi
                        fi
                    done
					echo ""
				done
            ;;
		4)
			#div
			for ((i=1; i<=12;i++)) 
                do
                    until [ $ANS  -eq $(($TABLE_NUM / $i)) ]
					do 
				 		echo "What is $TABLE_NUM / $i"
                        read ANS

                        if [ $ANS  -eq $(($TABLE_NUM / $i)) ]
                        then
							echo "Correct! The answer is $ANS"
						else
							if [ $(($i / $TABLE_NUM)) -gt $ANS ]
							then
								echo "Incorrect, but the answer is greater than $ANS, please try again" 
							else
								echo "Incorrect, but the answer is less than $ANS, please try again"
							fi
                        fi
                    done
					echo ""
				done
            ;;
		*)
			echo "Invalid Tables Option"
			;;
	esac
	student_menu

}


function takeQuiz()
{
	local Y=4 X=1 MAX=13 NUM=5

	LIVES=3
	COUNT=1
	USERNAME=""
	OPERATOR=""
	Q=0
	PASS=0

	echo "What is your first name?"
	read USERNAME
	echo "Thank you $USERNAME, best of luck!"


	
	for((i=0;i<=$NUM_QUESTIONS; i++))
	do
		NUM=$((RANDOM%MAX+1))
		case $((RANDOM%4+1)) in
			1) #ask add question
				echo "What is $NUM + $i"
				read ANS
				OPERATOR="+"
				Q=$((NUM + i))
				if [ $ANS  -eq $(($NUM + $i)) ]
				then
					echo "Correct"
					((COUNT += 1))
					
					PASS=1
					if [ $(($COUNT % 4)) -eq 0 ]
					then 
						((LIVES += 1))
						echo "!!! Congratulations !!! You gained an extra life! Lives: {$LIVES}"
						COUNT=1
						
					fi
				else
					echo "Incorrect"
					echo "Answer is: " $(($NUM + $i))
					((LIVES -= 1))
					echo "Number of lives left is: $LIVES"

					COUNT=1
					PASS=0

					if [ $LIVES -eq 0 ]
					then
						echo "You Ran Out of Lives"
						break
					fi
				fi 
				;;
			2) #ask minus q
				echo "What is $NUM - $i"
                read ANS
				OPERATOR="-"
				Q=$((NUM - i))

                if [ $ANS  -eq $(($NUM - $i)) ]
                then
                    echo "Correct"
					((COUNT += 1))
					PASS=1


					if [ $(($COUNT % 4)) -eq 0 ]
					then 
						((LIVES += 1))
						echo "!!! Congratulations !!! You gained an extra life! Lives: {$LIVES}"
						COUNT=1
						
					fi
                else
                    echo "Incorrect"
					echo "Answer is: " $(($NUM - $i))
					((LIVES -= 1))
					PASS=0

					echo "Number of lives left is: $LIVES"
					COUNT=1

					if [ $LIVES -eq 0 ]
					then
						echo "You Ran Out of Lives"
						break
					fi
                fi
				;;
			3) #ask mult q
				echo "What is $NUM x $i"
                read ANS
				OPERATOR="x"
				Q=$((NUM * i))

                if [ $ANS  -eq $(($NUM * $i)) ]
                then
                    echo "Correct"
					((COUNT += 1))
					PASS=1


					if [ $(($COUNT % 4)) -eq 0 ]
					then 
						((LIVES += 1))
						echo "!!! Congratulations !!! You gained an extra life! Lives: {$LIVES}"
						COUNT=1
						
					fi
                else
                    echo "Incorrect"
					echo "Answer is: " $(($NUM * $i))
					((LIVES -= 1))
					echo "Number of lives left is: $LIVES"
					PASS=0

					COUNT=1

					if [ $LIVES -eq 0 ]
					then
						echo "You Ran Out of Lives"
						break
					fi
                fi
				;;
			4) #ask div q
				echo "What is $NUM /$i "
                read ANS
				OPERATOR="/"
				Q=$((NUM / i))

                if [ $ANS  -eq $(($NUM  / $i )) ]
                then
                    echo "Correct"
					((COUNT += 1))
					PASS=1


					if [ $(($COUNT % 4)) -eq 0 ]
					then 
						((LIVES += 1))
						echo "!!! Congratulations !!! You gained an extra life! Lives: {$LIVES}"
						COUNT=1
						
					fi
                else
                    echo "Incorrect"
					echo "Answer is: " $(($NUM / $i))
					((LIVES -= 1))
					echo "Number of lives left is: $LIVES"

					COUNT=1
					PASS=0

					if [ $LIVES -eq 0 ]
					then
						echo "You Ran Out of Lives"
						break
					fi
                fi
				;;
			*)
				echo "Not an arithmetic choice, please ask your teacher for help"
				;;	
		esac

		
		QUIZ_RESULTS[${i},0]=$NUM
		QUIZ_RESULTS[${i},1]=$OPERATOR
		QUIZ_RESULTS[${i},2]=$i
		QUIZ_RESULTS[${i},3]=$Q
		QUIZ_RESULTS[${i},4]=$ANS
		QUIZ_RESULTS[${i},5]=$PASS
	
		
	done
	echo "Thanks for taking the quiz"
	write_quiz_attempts_to_array
	showResults
	student_menu
}

function write_quiz_attempts_to_array() 
{
	for i in {1..4} 
	do
  		RAND+=$((RANDOM % 10))
	done

	file="$USERNAME-$(date +%F_%H-%M-%S)-$RAND.txt"
	

    if [ ! -f "$file" ]   
    then
    	touch "$file"   
    fi

    >$file  

	for((i=0;i<NUM_QUESTIONS;i++))
	do
		for((j=0;j<7;j++))
		do
			echo -ne "${QUIZ_RESULTS[$i,$j]}" >> "$file"	
		done
		echo "" >> "$file"
	done

	echo "File stored as: $file"
	echo "" >> "$file"
}



function showResults()
{

	CORRECTANS=0

	for((i = 0; i <= $NUM_QUESTIONS; i++))
	do	
		echo "${QUIZ_RESULTS[$i,5]}"
		if [[ ${QUIZ_RESULTS[$i,5]} -eq 1 ]]
    	then
        	((CORRECTANS += 1))
        	echo "$CORRECTANS"
    	fi
	done

	echo "The number of correct answers you scored is $CORRECTANS out of $NUM_QUESTIONS"
}


function exitProgram()
{
	echo "Thank You!"
	exit
}

#Teacher Section ******************************************************


function manageStudents()
{
	echo "Page Coming Soon"
	teacher_menu
}


function viewQuizAttempts()
{
	echo "Enter file name"
	read MYFILE

	filecontent=( $(cat $MYFILE) )

	for i in "${filecontent[@]}"
	do
  		echo $i
	done

	echo "Reading of file completed"
}


function viewStats()
{
	echo "Enter file name"
	read MYFILE

	filecontent=( $(cat $MYFILE) )

	for i in "${filecontent[@]}"
	do
  		echo $i
	done

	echo "Reading of file completed"

}


main