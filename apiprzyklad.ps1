# 1. Przygotowanie danych i adresu
$URL = "http://api.przyklad.com/v1/resource"
$Token = "twoj_klucz_dostepu"
$SzukanaFraza = "cos_do_wyszukania"

# Składanie pełnego adresu URL
$PelnyAdres = "$URL?token=$Token&search=$SzukanaFraza"

# 2. Wysłanie żądania i automatyczne odebranie jako OBIEKT
$Wynik = Invoke-RestMethod -Uri $PelnyAdres -Method Get

# 3. Wyciąganie danych za pomocą kropki (.)
if ($Wynik.status -eq "success") {
    Write-Host "Znaleziono dane: " $Wynik.data.name
    Write-Host "Szczegoly: " $Wynik.data.details
} else {
    Write-Host "Blad z API: " $Wynik.error_message