#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

if [[ -z $1 ]]; then
  echo "Please provide an element as an argument."
else
  # TODO: get the info of an element from the given argument
  # 1. check whether the argument is number or not
  if [[ $1 =~ ^[0-9]+$ ]]; then
    # get the info by its atomic number
    ELEMENT_INFO=$($PSQL "SELECT * FROM elements WHERE atomic_number=$1")
  else
    # 2. get the info by its symbol OR its name
    ELEMENT_INFO=$($PSQL "SELECT * FROM elements WHERE symbol='$1' OR name='$1'")
  fi

  if [[ -z $ELEMENT_INFO ]]; then
    echo "I could not find that element in the database."
  else
    #TODO: the record is found, then get detailed element information
    echo $ELEMENT_INFO | while IFS="|" read ATOM SYMBOL NAME; do
      DETAILED_INFO=$($PSQL "SELECT atomic_mass, melting_point_celsius, boiling_point_celsius, type FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE atomic_number=$ATOM AND symbol='$SYMBOL' AND name='$NAME'")
      echo $DETAILED_INFO | while IFS="|" read MASS MELT_PT BOIL_PT TYPE; do
        echo "The element with atomic number $ATOM is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELT_PT celsius and a boiling point of $BOIL_PT celsius."
      done
    done
  fi
fi