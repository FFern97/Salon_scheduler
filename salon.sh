#! /bin/bash

# Type ==>  chmod +x salon.sh
#           ./salon.sh

#--------------------

PSQL="psql --username=freecodecamp --dbname=salon --t"

echo -e "\n ----- Barbershop -----\n"

MAIN_MENU(){

if [[ $1 ]]
then 
  echo -e "\n$1" 
fi

#------

SERVICES=$($PSQL "SELECT * FROM services;")

echo $SERVICES | while read SERVICE_ID BAR NAME
do
    echo "$SERVICE_ID) $NAME"
done

#-------
read SERVICE_SELECTION
SERVICE_EXIST=$($PSQL "SELECT service_id, name FROM services WHERE service_id=$SERVICE_SELECTION")

if [[ -z SERVICE_EXIST ]]
then 
  MAIN_MENU "Couldn't find that service. Please choose again!"
fi
}
 MAIN_MENU 
 
