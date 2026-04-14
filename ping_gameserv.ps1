<#
=========================================================
 ISEKAI XR - Server Monitor Tool
=========================================================

Created by : Isekai XR
Contact    : contact.isekaixr@gmail.com

Purpose    :
 Lightweight server monitoring & diagnostics tool.
 Displays real-time ping + TCP port status.

License    :
 Intended for educational and diagnostic use only.
 Misuse for abusive traffic or malicious activity is not endorsed.

=========================================================
#>

# =========================
# PARAMETERS (FROM BAT / CLI)
# =========================

param(
    [string]$ip = "127.0.0.1",
    [int]$port = 135
)

$ProgressPreference = "SilentlyContinue"

# =========================
# MAIN LOOP
# =========================

# Stop with CTRL + C

while ($true) {

    $time = Get-Date -Format "HH:mm:ss"

    # -------------------------
    # PING TEST
    # -------------------------
    $ping = Test-Connection -ComputerName $ip -Count 1 -ErrorAction SilentlyContinue

    # -------------------------
    # TCP PORT TEST
    # -------------------------
    $tcp = Test-NetConnection -ComputerName $ip -Port $port -InformationLevel Quiet -WarningAction SilentlyContinue

    # =========================
    # OUTPUT HEADER
    # =========================
    Write-Host "[$time] " -NoNewline

    # -------------------------
    # PING DISPLAY
    # -------------------------
    if ($ping) {

        $latency = $ping.ResponseTime | Select-Object -First 1

        if ($latency -lt 50) {
            Write-Host "PING ${latency}ms" -ForegroundColor Green -NoNewline
        }
        elseif ($latency -lt 100) {
            Write-Host "PING ${latency}ms" -ForegroundColor Yellow -NoNewline
        }
        else {
            Write-Host "PING ${latency}ms" -ForegroundColor Red -NoNewline
        }

    }
    else {
        Write-Host "PING FAIL" -ForegroundColor Red -NoNewline
    }

    # -------------------------
    # TCP STATUS DISPLAY
    # -------------------------
    if ($tcp) {
        Write-Host " | PORT $port OPEN" -ForegroundColor Green
    }
    else {
        Write-Host " | PORT $port CLOSED" -ForegroundColor Red
    }

    # 🧠 Future improvement idea:
    # You could add intermediate states like:
    # - TIMEOUT (no response)
    # - FILTERED (firewall blocking port)

    Start-Sleep -Seconds 2
}