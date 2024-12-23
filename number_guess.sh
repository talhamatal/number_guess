#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

#generate random number
RANDOM_NUMBER=$((($RANDOM % 1000) + 1))
echo $RANDOM_NUMBER
#Get username
echo Enter your username:
read USERNAME
#Query database to get username
USER_QUERY=$($PSQL "select username from userlist where username='$USERNAME'")
if [[ -z $USER_QUERY ]]
then
echo Welcome, $USERNAME! It looks like this is your first time here.
#Add username and to the database
USER_ADD_RESULT=$($PSQL "insert into userlist(username) values('$USERNAME');")
USER_ID=$($PSQL "select username_id from userlist where username='$USERNAME'")
GUESS_STATS_ADD_RESULT=$($PSQL "insert into guess_stats(username_id) values($USER_ID);")
#Play the game
COUNTER=0
NO_OF_GAME=1
echo Guess the secret number between 1 and 1000:
read SECRET_NUMBER
((COUNTER++))
while ! [[ $SECRET_NUMBER =~ ^[0-9]+$ ]]
do
echo That is not an integer, guess again:
read SECRET_NUMBER
((COUNTER++))
done
while [[ $SECRET_NUMBER > $RANDOM_NUMBER || $SECRET_NUMBER < $RANDOM_NUMBER ]]
do
if [[ $SECRET_NUMBER > $RANDOM_NUMBER ]]
then
echo It\'s lower than that, guess again:
read SECRET_NUMBER
((COUNTER++)) 
fi
if [[ $SECRET_NUMBER < $RANDOM_NUMBER ]]
then
echo It\'s higher than that, guess again:
read SECRET_NUMBER
((COUNTER++))
fi
done
#echo You guessed it in $COUNTER tries. The secret number was $RANDOM_NUMBER. Nice job!
#Add values to the table
GUESS_STATS_ADD_RESULT=$($PSQL "update guess_stats set games_played=$NO_OF_GAME, best_game=$COUNTER where username_id =$USER_ID;")

else
USER_ID=$($PSQL "select username_id from userlist where username='$USERNAME'")
GUESS_STATS_QUERY=$($PSQL "select * from guess_stats where username_id= $USER_ID;")
echo $GUESS_STATS_QUERY | while IFS='|' read USER_ID GAMES_PLAYED BEST_GAME
do
echo Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses.
done
#Play the game
COUNTER=0
echo Guess the secret number between 1 and 1000:
read SECRET_NUMBER
((COUNTER++))
while ! [[ $SECRET_NUMBER =~ ^[0-9]+$ ]]
do
echo That is not an integer, guess again:
read SECRET_NUMBER
((COUNTER++))
done
while [[ $SECRET_NUMBER > $RANDOM_NUMBER || $SECRET_NUMBER < $RANDOM_NUMBER ]]
do
if [[ $SECRET_NUMBER > $RANDOM_NUMBER ]]
then
echo It\'s lower than that, guess again:
read SECRET_NUMBER
((COUNTER++)) 
fi
if [[ $SECRET_NUMBER < $RANDOM_NUMBER ]]
then
echo It\'s higher than that, guess again:
read SECRET_NUMBER
((COUNTER++))
fi
done
#echo You guessed it in $COUNTER tries. The secret number was $RANDOM_NUMBER. Nice job!
GAMES_PLAYED=$($PSQL "select games_played from guess_stats where username_id= $USER_ID")
BEST_GAME=$($PSQL "select best_game from guess_stats where username_id=$USER_ID")
((GAMES_PLAYED++))
#Update values in the database
if [[ $COUNTER < $BEST_GAME ]]
then
GUESS_STATS_ADD_RESULT=$($PSQL "update guess_stats set games_played=$GAMES_PLAYED, best_game=$COUNTER where username_id =$USER_ID;")
else
GUESS_STATS_ADD_RESULT=$($PSQL "update guess_stats set games_played=$GAMES_PLAYED where username_id =$USER_ID;")
fi
fi

echo You guessed it in $COUNTER tries. The secret number was $RANDOM_NUMBER. Nice job!