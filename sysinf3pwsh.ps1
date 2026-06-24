# --- FUNKCJA 5: Adres IP ---
function Get-SystemIP {
    # "ip addr show" wyswietla wszystkie interfejsy sieciowe
    # Select-String "inet " filtruje linie z adresami IPv4 (inet = IPv4, inet6 = IPv6)
    # Where-Object odfiltrowuje petlę zwrotna localhost 127.0.0.1
    # Select-Object -First 1 bierze pierwszy prawdziwy interfejs sieciowy
    $ip = & ip addr show | Select-String "inet " | Where-Object { $_ -notmatch "127.0.0.1" } | Select-Object -First 1

    # Przyklad linii: "    inet 192.168.1.5/24 brd 192.168.1.255 scope global eth0"
    # Po podziale po bialych znakach element [2] to adres z maska np. "192.168.1.5/24"
    # -replace '/.*', '' ucina maske podsieci zostawiajac sam adres IP
    $adres = ($ip -split '\s+')[2] -replace '/.*', ''
    Write-Host "Adres IP: $adres"
}

# --- FUNKCJA 6: Czas dzialania systemu ---
function Get-SystemUptime {
    # /proc/uptime zawiera dwie liczby: sekundy od startu systemu i czas bezczynnosci CPU
    # Interesuje nas pierwsza liczba - calkowity czas dzialania w sekundach
    $uptimeRaw = Get-Content /proc/uptime
    $sekundy   = [int]($uptimeRaw -split ' ')[0]

    # Przeliczamy sekundy na dni, godziny i minuty przy uzyciu modulo
    # 1 dzien = 86400 sekund, 1 godzina = 3600 sekund, 1 minuta = 60 sekund
    # [math]::Floor zaokragla w dol (np. 1.9 -> 1)
    $dni     = [math]::Floor($sekundy / 86400)
    $godziny = [math]::Floor(($sekundy % 86400) / 3600)
    $minuty  = [math]::Floor(($sekundy % 3600) / 60)
    Write-Host "Czas dzialania: $dni dni, $godziny godz, $minuty min"
}

# --- GLOWNA CZESC SKRYPTU ---
# Wywolujemy wszystkie funkcje kolejnoingSystem
Get-SystemIP
Get-SystemUptime
