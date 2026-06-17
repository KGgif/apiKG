#!/bin/bash

# 1. Przygotowanie danych i adresu
URL="http://api.przyklad.com/v1/resource"
TOKEN="twoj_klucz_dostepu"
SZUKANA="cos_do_wyszukania"

# 2. Pobranie danych przez curl (flaga -s wycisza paski pobierania, -G robi zapytanie GET)
# --data-urlencode automatycznie dba o bezpieczne zakodowanie spacji i znaków specjalnych
SUROWY_JSON=$(curl -s -G "$URL" \
    --data-urlencode "token=$TOKEN" \
    --data-urlencode "search=$SZUKANA")

# 3. Sprawdzenie statusu i wyciąganie danych za pomocą narzędzia 'jq'
# kropka i nazwa pola (.status) wyciąga konkretną wartość. Flaga -r usuwa zbędne cudzysłowy.
STATUS=$(echo "$SUROWY_JSON" | jq -r '.status')

if [ "$STATUS" == "success" ]; then
    NAZWA=$(echo "$SUROWY_JSON" | jq -r '.data.name')
    SZCZEGOLY=$(echo "$SUROWY_JSON" | jq -r '.data.details')
    
    echo "Znaleziono dane: $NAZWA"
    echo "Szczegoly: $SZCZEGOLY"
else
    BLAD=$(echo "$SUROWY_JSON" | jq -r '.error_message')
    echo "Blad z API: $BLAD"
fi