#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=<database_name> -t --no-align -c"

if [[ -z $1 ]]; then
  echo "Please provide an element as an argument."
else
  # TODO: get the info of an element from the given argument
fi