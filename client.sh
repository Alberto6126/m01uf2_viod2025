#!/bin/bash

IPserver=$1
clear 
IPlocal=localhost 
IPhost=`ip ad | grep "scope global" | xargs | cut -d " " -f 2 | cut -d "/" -f 1`
PUERTO=2022
BUCLE=1
CABECERA="DMAM $IPhost FILE_NAME"
while [ $BUCLE == 1 ]; do
clear
echo "----------------------------------------------------------------------------"
echo "envia la cabecera DMAM FILE_NAME seguido del nombre del archivo para completar la conexión, envia otra para interrumpirla"
echo "enviando cabecera $CABECERA a $IPserver en el puerto $PUERTO desde $IPhost"
sleep 1
echo $CABECERA | ncat $IPserver $PUERTO
echo "----------------------------------------------------------------------------"
echo "recibiendo cabecera del servidor"
CABECERA_SERVER=`ncat -l $IPhost $PUERTO`
ERROR_SERVER=`ncat -l $IPhost $PUERTO`
 	if [ "$CABECERA_SERVER" == "OK HEADER" ]; then
		 echo "la cabecera recibida es $CABECERA_SERVER, CONEXIÓN COMPLETADA"
	else
 		 echo "la cabecera recibida es $CABECERA_SERVER, CONEXIÓN INTERRUMPIDA"
		 echo "$ERROR_SERVER"
		 BUCLE=0
	fi
echo "----------------------------------------------------------------------------"
	if [ $BUCLE == 1 ]; then
		cat client/dragon.txt | ncat $IPserver $PUERTO
		DATA=`ncat -l $PUERTO`
		echo $DATA > dragon_server.txt

	fi
sleep 3
done
