# =============================================================
# Skrypt: zad5_funkcje.ps1
# Opis:   Wyswietla informacje o systemie - kazda w osobnej funkcji
# Użycie: pwsh ./zad5_funkcje.ps1
# Autor:  student
# =============================================================

# Zmienna z nazwa komputera - uzywana we wszystkich funkcjach
$NazwaKomputera = hostname

# Aktualna data
function Get-AktualnaData {
    $Data = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    Write-Host "Aktualna data na ($NazwaKomputera) to $Data"
}

# Wersja systemu
function Get-WersjaSystemu {
    $Wersja = (Get-Content /etc/os-release | Where-Object { $_ -match "^PRETTY_NAME" }) -replace 'PRETTY_NAME=|"', ''
    Write-Host "Wersja systemu na ($NazwaKomputera) to $Wersja"
}

# Aktualny uzytkownik
function Get-Uzytkownik {
    $Uzytkownik = whoami
    Write-Host "Uzytkownik na ($NazwaKomputera) to $Uzytkownik"
}

# Adres IP
function Get-AdresIP {
    $IP = & ip addr show | Select-String "inet " | Where-Object { $_ -notmatch "127.0.0.1" } | Select-Object -First 1
    $Adres = ($IP -split '\s+')[2] -replace '/.*', ''
    Write-Host "Adres IP na ($NazwaKomputera) to $Adres"
}

# Glowna czesc skryptu wywolujaca wszystkie funkcje
Get-AktualnaData
Get-WersjaSystemu
Get-Uzytkownik
Get-AdresIP
