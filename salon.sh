#! /bin/bash

#TYPE on bash terminal to grant permission
#chmod +x salon.sh
#./ salon.sh
#--------

PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"
echo -e "\n ----- Barbershop -----\n"


echo -e "\nPlease select your service:"

MAIN_MENU() {

if [[ $1 ]]
then 
  echo -e "\n$1" 
fi

#------ MENU 

SERVICES=$($PSQL "SELECT * FROM services;")

echo "$SERVICES" | while read SERVICE_ID BAR NAME
do
    echo "$SERVICE_ID) $NAME"
done

#------ SERVICE SELECTION 

read SERVICE_ID_SELECTED
SERVICE_EXIST=$($PSQL "SELECT service_id FROM services WHERE service_id=$SERVICE_ID_SELECTED")

if [[ -z $SERVICE_EXIST ]]
then 
  MAIN_MENU "Couldn't find that service. Please choose again!"
fi

# READ PHONE NUMBER

echo -e "\nInsert phone number please: "

read CUSTOMER_PHONE
CUSTOMER_EXIST=$($PSQL "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE'")

if [[ -z $CUSTOMER_EXIST ]]
  then 
  echo -e "New here? Insert your name please"
  read CUSTOMER_NAME
  INSERTED=$($PSQL "INSERT INTO customers (name, phone) VALUES ('$CUSTOMER_NAME', '$CUSTOMER_PHONE')")
  echo -e "Thanks $CUSTOMER_NAME! Please pick the time for your appointment:"
fi

#----- SERVICE NAME

SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id='$SERVICE_ID_SELECTED'")

#---- READ TIME
read SERVICE_TIME
echo -e "\nI have put you down for a '$SERVICE_NAME' at '$SERVICE_TIME', '$CUSTOMER_NAME'."


}

MAIN_MENU

 ------------------------------------------
#LAST VER

 MAIN_MENU() {

echo -e "\nPlease select your service:"

if [[ $1 ]]
then 
  echo -e "\n$1" 
fi

#------ MENU 

SERVICES=$($PSQL "SELECT * FROM services;")

echo "$SERVICES" | while read SERVICE_ID BAR NAME
do
    echo "$SERVICE_ID) $NAME"
done

#------ SERVICE SELECTION 

read SERVICE_ID_SELECTED
SERVICE_EXIST=$($PSQL "SELECT service_id FROM services WHERE service_id=$SERVICE_ID_SELECTED")

if [[ -z $SERVICE_EXIST ]]
then 
  MAIN_MENU "Couldn't find that service. Please choose again!"
fi

# READ PHONE NUMBER

echo -e "\nInsert phone number please: "

read CUSTOMER_PHONE
CUSTOMER_EXIST=$($PSQL "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE'")

if [[ -z $CUSTOMER_EXIST ]]
  then 
  echo -e "New here? Insert your name please"
  read CUSTOMER_NAME
  INSERTED=$($PSQL "INSERT INTO customers (name, phone) VALUES ('$CUSTOMER_NAME', '$CUSTOMER_PHONE')")
  echo -e "Thanks $CUSTOMER_NAME! Please pick the time for your appointment:"
fi

#----- SERVICE NAME

SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id='$SERVICE_ID_SELECTED'")

#---- READ TIME
read SERVICE_TIME
echo -e "\nI have put you down for a '$SERVICE_NAME' at '$SERVICE_TIME', '$CUSTOMER_NAME'."


}

MAIN_MENU

 
