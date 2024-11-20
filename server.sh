#!/bin/bash

clear
PUERTO=2022
CABECERA_REAL="DMAM"
echo "ESCUCHANDO EL PUERTO $PUERTO" 
BUCLE_SERVER=1

while [ $BUCLE_SERVER == 1 ]; do
	SERVERISWAITING=0
	CABECERA=`ncat -l $CABECERA_IP $PUERTO`
	CABECERA_FILENAME=$( echo "$CABECERA" | cut -d " " -f 3 )
	CABECERA_NOMBRE=$( echo "$CABECERA" | cut -d " " -f 1 )
	CABECERA_IP=$( echo "$CABECERA" | cut -d " " -f 2 )

	if [ "$CABECERA_NOMBRE" == "$CABECERA_REAL" ]; then

		 echo "se na recibido la cabecera correcta"
		 echo "OK HEADER" | ncat $CABECERA_IP  $PUERTO
		 echo "SE HA RECIBIDO EL ARCHIVO $CABECERA_NOMBRE"
		 echo "ERROR_0: Cabecera correcta" | ncat $CABECERA_IP $PUERTO
		 SERVERISWAITING=1
		 if [ "$SERVERISWAITING" == 1 ]; then 
			 DATA=`ncat -l $PUERTO`
		       	echo "$DATA" | ncat $CABECERA_IP $PUERTO
		fi
	else
		echo "ERROR_1: Cabecera incorrecta"
		echo "KO_HEADER" | ncat $CABECERA_IP $PUERTO
		echo "	RECIBIDO: $CABECERA, CABECERA RECIBIDA: $CABECERA_FILENAME | CABECERA ESPERADA: $CABECERA_REAL"
		echo "ERROR_1: Cabecera incorrecta" | ncat $CABECERA_IP $PUERTO
		if [ "$CABECERA" == "101" ]; then
 		BUCLE_SERVER=0
		fi
	fi

done
