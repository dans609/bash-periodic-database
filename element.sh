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
    if [[ -z $ELEMENT_INFO ]]; then
      echo "I could not find that element in the database."
    fi
  fi
fi