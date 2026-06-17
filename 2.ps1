# 1. DEFINICJE FUNKCJI
function Get-HostNameInfo { 
    $env:COMPUTERNAME 
}

function Get-IPInfo { 
    (Get-NetIPAddress -AddressFamily IPv4 | Where-Object IPAddress -notlike "127*")[0].IPAddress
}

function Get-MACInfo { 
    (Get-NetAdapter | Where-Object Status -eq "Up")[0].MacAddress.Replace(":", "-")
}

function Get-RAMInfo { 
    $raw = (Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory
    $gb = [math]::Round($raw / 1GB, 2)
    return "$gb GB"
}

function Get-OSInfo { 
    (Get-CimInstance Win32_OperatingSystem).Caption 
}

function Get-ModelInfo { 
    (Get-CimInstance Win32_ComputerSystem).Model 
}

# 2. GENEROWANIE RAPORTU DO KONSOLI
Write-Host "Hostname:   $(Get-HostNameInfo)"
Write-Host "IP Address: $(Get-IPInfo)"
Write-Host "MAC Address: $(Get-MACInfo)"
Write-Host "RAM:        $(Get-RAMInfo)"
Write-Host "OS:         $(Get-OSInfo)"
Write-Host "Model:      $(Get-ModelInfo)"

# 3. ZAPIS DO PLIKU
$Data = Get-Date -Format "yyyyMMdd-HHmmss"
$Sciezka = "$HOME\Desktop\SystemReport_$Data.txt"

# Ponowne wywołanie funkcji i zapisanie ich prosto do pliku
"Hostname:   $(Get-HostNameInfo)" | Out-File $Sciezka -Append
"IP Address: $(Get-IPInfo)"   | Out-File $Sciezka -Append
"MAC Address: $(Get-MACInfo)"  | Out-File $Sciezka -Append
"RAM:        $(Get-RAMInfo)"  | Out-File $Sciezka -Append
"OS:         $(Get-OSInfo)"   | Out-File $Sciezka -Append
"Model:      $(Get-ModelInfo)"| Out-File $Sciezka -Append

# 4. KOMUNIKAT KOŃCOWY
Write-Host "Raport zapisany w pliku: $Sciezka"