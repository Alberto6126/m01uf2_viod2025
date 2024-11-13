#!/bin/bash


clear
#ENVIAR CABEZERA
IPV4=localhost
PUERTO=2022
BUCLE=1

while [ $BUCLE == 1 ]; do

echo "----------------------------------------------------------------------------------"
echo "envia la cabecera DMAM para completar la conexión, envía otra para interrumpirla"
read CABECERA
echo "enviando cabecera $CABECERA a $IPV4 en el puerto $PUERTO"
sleep 1
echo $CABECERA | ncat $IPV4 $PUERTO
echo "----------------------------------------------------------------------------------"
echo "recibiendo cabecera del servidor"
CABECERA_SERVER=`ncat -l localhost $PUERTO`
ERROR_SERVER=`ncat -l localhost $PUERTO`
if [ "$CABECERA_SERVER" == "OK_HEADER" ]; then

	echo "la cabecera recibida es: $CABECERA_SERVER, CONEXIÓN COMPLETADA"
else 

	echo "la cabecera recibida es: $CABECERA_SERVER, CONEXIÓN INTERRUMPIDA"
	echo "$ERROR_SERVER"
	BUCLE=0
fi
echo "-----------------------------------------------------------------------------------"
sleep 3
done
