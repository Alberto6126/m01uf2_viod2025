#!/bin/bash

clear
PUERTO=2022
CABECERA_REAL="DMAM FILE_NAME"
echo "ESCUCHANDO EL PUERTO $PUERTO" 
BUCLE_SERVER=1

while [ $BUCLE_SERVER == 1 ]; do

	CABECERA=`ncat -l localhost $PUERTO`
	CABECERA_FILENAME=$( echo "$CABECERA" | cut -b 1-14 )
	CABECERA_NOMBRE=$( echo "$CABECERA" | cut -b 16- )

	if [ "$CABECERA_FILENAME" == "$CABECERA_REAL" ]; then

		 echo "se na recibido la cabecera correcta"
		 echo "OK HEADER" | ncat localhost $PUERTO
		 echo "SE HA RECIBIDO EL ARCHIVO $CABECERA_NOMBRE"
		 echo "ERROR_0: Cabecera correcta" | ncat localhost $PUERTO
	else
		echo "ERROR_1: Cabecera incorrecta"
		echo "KO_HEADER" | ncat localhost $PUERTO
		echo "	RECIBIDO: $CABECERA, CABECERA RECIBIDA: $CABECERA_FILENAME | CABECERA ESPERADA: $CABECERA_REAL"
		echo "ERROR_1: Cabecera incorrecta" | ncat localhost $PUERTO
		if [ "$CABECERA" == "101" ]; then
 		BUCLE_SERVER=0
	fi
	fi
done
