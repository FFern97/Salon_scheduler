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

read SERVICE_SELECTION
SERVICE_EXIST=$($PSQL "SELECT service_id FROM services WHERE service_id=$SERVICE_SELECTION")

if [[ -z $SERVICE_EXIST ]]
then 
  MAIN_MENU "Couldn't find that service. Please choose again!"
fi

#------ NUMBER INSERTION

echo -e "\nInsert phone number please: "
read PHONE_NUMBER

CUSTOMER_EXIST=$($PSQL "SELECT customer_id name FROM customers WHERE phone=$PHONE_NUMBER")

if [[ -z $CUSTOMER_EXIST ]]
  then 
  echo -e "New here? Insert your name please"
  read NAME
  INSERTED=$($PSQL "INSERT INTO customers (name, phone) VALUES ('$NAME', '$PHONE_NUMBER')")
  echo -e "Thanks $NAME! Please pick the time for your appointment:"
  #29--------------------------------------------------------------------------------
fi
}

 MAIN_MENU 

 
