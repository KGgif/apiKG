${Apikey}= "twój_klucz_api"
$Url = "http://www.omdbapi.com/"
#Pobranie tytułu
$Tytul = Read-Host "Podaj tytul filmu lub serialu"
#Wysłanie zapytania 
$calyurl = $url + "?apikey=" + $apikey + "&t=" + $tytul
$Odpowiedz = Invoke-RestMethod -Uri $calyurl -Method Get
#Sprawdzanie czy film istnieje
if($Odpowiedz.Response -eq "True") {
Write-Host "Rezyser: " $Odpowiedz.Director 
Write-Host "Ocena IMDb: " $Odpowiedz.imdbRating
Write-Host "Rok: " $Odpowiedz.Year
Write-Host "Gatunek " $Odpowiedz.Genre
} else {
	Write-Host " Blad z Api: " $Odpowiedz.Error
}