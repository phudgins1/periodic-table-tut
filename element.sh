#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t -c"

BASE_QUERY="select elements.atomic_number, symbol, name, type, atomic_mass, melting_point_celsius, boiling_point_celsius from elements inner join properties on elements.atomic_number = properties.atomic_number inner join types on properties.type_id = types.type_id where"

if [[ -z $1 ]]
then
  echo Please provide an element as an argument.
elif [[ $1 =~ ^[0-9]+$ ]]
then
  BASE_QUERY="$BASE_QUERY elements.atomic_number=$1"
  RESULT=$($PSQL "$BASE_QUERY")
  if [[ -z $RESULT ]]
  then
    echo I could not find that element in the database.
  else
    echo $RESULT | while read ATOMIC_NUMBER BAR SYMBOL BAR NAME BAR TYPE BAR MASS BAR MELTING BAR BOILING
    do
      echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
    done
  fi
else
  BASE_QUERY="$BASE_QUERY elements.name='$1' or elements.symbol='$1'"
  RESULT=$($PSQL "$BASE_QUERY")
  if [[ -z $RESULT ]]
  then
    echo I could not find that element in the database.
  else
    echo $RESULT | while read ATOMIC_NUMBER BAR SYMBOL BAR NAME BAR TYPE BAR MASS BAR MELTING BAR BOILING
    do
      echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
    done
  fi
fi
