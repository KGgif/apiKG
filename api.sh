#!/bin/bash
# $1 to pierwszy argument podany przy wywołaniu skryptu (np. ./film.sh "Matrix")
TYTUL=$1
KLUCZ_API="TWOJ_KLUCZ_OMDB"
if [ -z "$TYTUL" ]; then
echo "Podaj tytuł filmu!"
exit 1
fi
# Zamiana spacji na '%20', żeby URL był poprawny (np. "Pulp Fiction" -> "Pulp%20Fiction")
TYTUL_URL=$(echo $TYTUL | tr ' ' '+')
# Zapytanie do API
URL="http://www.omdbapi.com/?t=${TYTUL_URL}&apikey=${KLUCZ_API}"
ODPOWIEDZ=$(curl -s "$URL")
# Wyciąganie danych za pomocą jq (parametr -r usuwa cudzysłowy z wyniku)
REZYZER=$(echo $ODPOWIEDZ | jq -r '.Director')
ROK=$(echo $ODPOWIEDZ | jq -r '.Year')
OCENA=$(echo $ODPOWIEDZ | jq -r '.imdbRating')
echo "--- Informacje o filmie ---"
echo "Tytuł: $TYTUL"
echo "Reżyser: $REZYZER"
echo "Rok: $ROK"
echo "Ocena: $OCENA/10"