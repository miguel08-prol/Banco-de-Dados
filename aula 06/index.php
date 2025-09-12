<?php 
echo "Olá mundo!";

?>

#Connerct to the MySQL server
conn = MySQL.connerctor.connect(
host="localhost",
user="root",
password="senaisp"
database="Instituição"
)

cursor= conn.cursor()

#Run a query 
cursor.execute("Select * from users")