#!/bin/bash
clear
PUERTO=2022
CABECERA_REAL="DMAM"
echo "ESCUCHANDO EL PUERTO $PUERTO"
BUCLE_SERVER=1

while [ $BUCLE_SERVER == 1 ]; do

CABECERA=`ncat -l localhost $PUERTO`

if [ "$CABECERA" == "$CABECERA_REAL" ]; then

	echo "se ha recibido la cabecera correcta"
	echo "OK_HEADER" | ncat localhost $PUERTO
	echo "ERROR_0: Cabecera correcta" | ncat localhost $PUERTO
else 
	echo "ERROR 1: Cabecera incorrecta"
	echo "KO_HEADER" | ncat localhost $PUERTO
	echo "ERROR_1: Cabecera incorrecta" | ncat localhost $PUERTO
	BUCLE_SERVER=0
fi
done
