# Nazwa hosta
function Get-SystemHostname {
    $Hostname = hostname
    Write-Host "Nazwa hosta: $Hostname"
}

# Uzycie dyskow
function Get-SystemDiskUsage {
    Write-Host "Uzycie dyskow:"
    $df = df -h | Select-Object -Skip 1
    foreach ($line in $df) {
        $parts = $line -split '\s+'
        Write-Host "  Dysk $($parts[0]) -> Razem: $($parts[1]) GB | Zajete: $($parts[2]) | Wolne: $($parts[3])"
    }
}

# RAM
function Get-SystemRam {
    $memInfo = Get-Content /proc/meminfo
    $totalKB = ($memInfo | Where-Object { $_ -match "^MemTotal" }) -replace '\D', ''
    $totalGB = [math]::Round([int]$totalKB / 1MB, 2)
    Write-Host "Ilosc pamieci RAM: $totalGB GB"
}

# System operacyjny
function Get-SystemOperatingSystem {
    $os = (Get-Content /etc/os-release | Where-Object { $_ -match "^PRETTY_NAME" }) -replace 'PRETTY_NAME=|"', ''
    Write-Host "System operacyjny: $os"
}

# Glowna czesc skryptu wywolujaca wszystkie funkcje
Get-SystemHostname
Get-SystemDiskUsage
Get-SystemRam
Get-SystemOperatingSystem



