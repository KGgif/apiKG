# Nazwa hosta
function Get-SystemHostname {
     # hostname to wbudowane polecenie systemowe zwracajace nazwe komputera w sieci
    $Hostname = hostname
    Write-Host "Nazwa hosta: $Hostname"
}

# Uzycie dyskow
function Get-SystemDiskUsage {
    Write-Host "Uzycie dyskow:"
     # "df -h" (disk free) wyswietla informacje o wszystkich zamontowanych dyskach
    # flaga -h (human-readable) pokazuje rozmiary w GB/MB zamiast bajtow
    # Select-Object -Skip 1 pomija pierwsza linie (naglowek tabeli)
    $df = df -h | Select-Object -Skip 1
     # Iterujemy po kazdej linii reprezentujacej jeden dysk/partycje
    foreach ($line in $df) {
     # -split '\s+' dzieli linie po dowolnej ilosci bialych znakow
        # Kolejnosc pol: [0]=urzadzenie [1]=rozmiar [2]=zajete [3]=wolne [4]=% [5]=punkt montowania
        $parts = $line -split '\s+'
        Write-Host "  Dysk $($parts[0]) -> Razem: $($parts[1]) GB | Zajete: $($parts[2]) | Wolne: $($parts[3])"
    }
}

# RAM
function Get-SystemRam {
 # /proc/meminfo to wirtualny plik Linuxa z informacjami o pamieci w czasie rzeczywistym
    # Get-Content czyta caly plik linia po linii
    $memInfo = Get-Content /proc/meminfo
    # Filtrujemy linie zaczynajaca sie od "MemTotal" - calkowita pamiec RAM
    # -replace '\D', '' usuwa wszystkie znaki nie-cyfrowe, zostawiajac tylko liczbe w KB
    # np. "MemTotal:       16384000 kB" -> "16384000"
    $totalKB = ($memInfo | Where-Object { $_ -match "^MemTotal" }) -replace '\D', ''
     # Przeliczamy KB na GB: 1GB = 1024*1024 KB = 1MB (w PowerShell 1MB = 1048576)
    # [math]::Round zaokragla do 2 miejsc po przecinku
    $totalGB = [math]::Round([int]$totalKB / 1MB, 2)
    Write-Host "Ilosc pamieci RAM: $totalGB GB"
}

# System operacyjny
function Get-SystemOperatingSystem {
 # /etc/os-release zawiera metadane systemu w formacie KLUCZ="WARTOSC"
    # Szukamy linii PRETTY_NAME ktora zawiera pelna, czytalna nazwe systemu
    # -replace 'PRETTY_NAME=|"', '' usuwa klucz i cudzyslowy
    # np. PRETTY_NAME="Kali GNU/Linux Rolling" -> Kali GNU/Linux Rolling
    $os = (Get-Content /etc/os-release | Where-Object { $_ -match "^PRETTY_NAME" }) -replace 'PRETTY_NAME=|"', ''
    Write-Host "System operacyjny: $os"
}

# Glowna czesc skryptu wywolujaca wszystkie funkcje
Get-SystemHostname
Get-SystemDiskUsage
Get-SystemRam
Get-SystemOperatingSystem
Get-SystemOperatingSystem



