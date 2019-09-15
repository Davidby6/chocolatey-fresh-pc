Write-Host (Get-Date).ToString()": Running install script" 

# Import our package list
. ./packages.ps1

function IsAdmin() {
    Write-Host "Making sure this is an elevated shell..."

    $user = [Security.Principal.WindowsIdentity]::GetCurrent();
    if (!(New-Object Security.Principal.WindowsPrincipal $user).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)) {
        throw "Must be running in an elevated shell, please right click -> run as administrator and try again"
    }
}

function IsInstalled() {
    Write-Host "Checking if choco is installed... "

    if (Test-Path -Path "$env:ProgramData\Chocolatey") {
        $testchoco = powershell choco -v
        Write-Output "Found Chocolatey Version $testchoco, proceeding"
    }
    else {
        Write-Output "Seems Chocolatey is not installed, installing now"
        Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))  
    }
}

function Install() {
    IsAdmin

    IsInstalled

    foreach ($package in $packages) {
        Write-Host "Installing package: " $package
        choco install -y $package
    }
}

function Update() {
    IsAdmin

    IsInstalled

    choco upgrade all -y
}