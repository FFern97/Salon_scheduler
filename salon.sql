psql --username=freecodecamp --dbname=postgres

CREATE DATABASE salon;

\c salon;

CREATE TABLE customers (customer_id SERIAL PRIMARY KEY NOT NULL, name VARCHAR(50) NOT NULL, phone VARCHAR(50) UNIQUE NOT NULL);

CREATE TABLE appointments(appointment_id SERIAL PRIMARY KEY NOT NULL, time VARCHAR(50) UNIQUE NOT NULL, customer_id INT, service_id INT);

CREATE TABLE  services(service_id SERIAL PRIMARY KEY NOT NULL, name VARCHAR(50) NOT NULL); 

ALTER TABLE appointments 
  ADD CONSTRAINT appointment_service FOREIGN KEY(service_id) REFERENCES services(service_id);  
ALTER TABLE appointments 
  ADD CONSTRAINT appointment_customer FOREIGN KEY(customer_id) REFERENCES customers(customer_id);

-- INSERT INTO services (name) VALUES ('Haircut', 'Beard', 'Manicure', 'Color', 'Massage');

INSERT INTO services (name) VALUES ('Haircut');
INSERT INTO services (name) VALUES ('Beard');  
INSERT INTO services (name) VALUES ('Manicure');
INSERT INTO services (name) VALUES ('Color');
INSERT INTO services (name) VALUES ('Massage');
