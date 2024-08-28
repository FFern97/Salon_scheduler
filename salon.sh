#! /bin/bash
#TYPE on bash terminal to grant permission
#chmod +x salon.sh
#./ salon.sh
#--------

PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"


echo -e "\n ----- Barbershop -----\n"

# FUNCIÓN MENU
MAIN_MENU() {
  while true
  do
    echo -e "\nPlease select your service:"

# MUESTRA MENU    
    SERVICES=$($PSQL "SELECT * FROM services;")
    echo "$SERVICES" | while read SERVICE_ID BAR NAME
    do
      echo "$SERVICE_ID) $NAME"
    done

# LEE SERVICIO
    read SERVICE_ID_SELECTED
    SERVICE_EXIST=$($PSQL "SELECT service_id FROM services WHERE service_id=$SERVICE_ID_SELECTED")

    if [[ -z $SERVICE_EXIST ]]
    then
      echo -e "Couldn't find that service. Please choose again!"
    else
      break
    fi
  done
}

# FUNCIÓN MENU
MAIN_MENU

# LEE TELEFONO Y NOMBRE 
echo -e "\nInsert phone number please: "
read CUSTOMER_PHONE
CUSTOMER_EXIST=$($PSQL "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE'")

if [[ -z $CUSTOMER_EXIST ]]
then
  echo -e "New here? Insert your name please"
  read CUSTOMER_NAME
  INSERTED=$($PSQL "INSERT INTO customers (name, phone) VALUES ('$CUSTOMER_NAME', '$CUSTOMER_PHONE')")
  echo -e "Thanks $CUSTOMER_NAME! Please pick the time for your appointment:"
else
  CUSTOMER_NAME=$(echo $CUSTOMER_EXIST | sed -E 's/^ *| *$//g')
  echo -e "Welcome back, $CUSTOMER_NAME!"
fi

# NOMBRE DEL SERVICIO SELECCIONADO
SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id='$SERVICE_ID_SELECTED'")

# ID DEL CLIENTE
CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE name='$CUSTOMER_NAME'")

# LEE HORARIO DEL TURNO
echo -e "\nPlease pick the time for your appointment:"
read SERVICE_TIME
INSERTED=$($PSQL "INSERT INTO appointments (time, customer_id, service_id) VALUES ('$SERVICE_TIME','$CUSTOMER_ID','$SERVICE_ID_SELECTED')")
echo -e "\nI have put you down for a $SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME."



