#TYPE on bash terminal to grant permission
#chmod +x salon.sh
#./ salon.sh
#--------

PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"
echo -e "\n ----- Barbershop -----\n"

PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

# Función para mostrar el menú y manejar la selección de servicios
MAIN_MENU() {
  while true
  do
    echo -e "\nPlease select your service:"

    # Muestra el menú de servicios
    SERVICES=$($PSQL "SELECT * FROM services;")
    echo "$SERVICES" | while read SERVICE_ID BAR NAME
    do
      echo "$SERVICE_ID) $NAME"
    done

    # Lee la selección del servicio
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

# Llama a la función para mostrar el menú y manejar la selección de servicios
MAIN_MENU

# Lee el número de teléfono del cliente
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

# Obtén el nombre del servicio seleccionado
SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id='$SERVICE_ID_SELECTED'")

# Lee la hora del servicio
echo -e "\nPlease pick the time for your appointment:"
read SERVICE_TIME
echo -e "\nI have put you down for a $SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME."



