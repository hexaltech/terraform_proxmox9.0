# ---------------------------
# INSTALL + BUILD PROVIDER (Windows, PowerShell Admin)
# ---------------------------

# Modifie si nécessaire : chemin de ton projet Terraform
$projectPath = "C:\Users\conta\Mon Drive\Hexaltech\SI\Projet YT_Local\Terraform"

# Vérifie que PowerShell est lancé en administrateur
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()
    ).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
  Write-Error "Lance PowerShell en tant qu'administrateur puis réessaie."
  exit 1
}

# 1) Installer Chocolatey si absent
if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
  Write-Output "Installation de Chocolatey..."
  Set-ExecutionPolicy Bypass -Scope Process -Force
  [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
  iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
} else {
  Write-Output "Chocolatey déjà installé."
}

# 2) Installer terraform, git, golang via choco
Write-Output "Installation/upgrades de terraform, git et golang..."
choco install terraform -y
choco install git -y
choco install golang -y

# Recharge le PATH dans la session courante (utile sans reouvrir la console)
$machinePath = [System.Environment]::GetEnvironmentVariable("Path","Machine")
$userPath    = [System.Environment]::GetEnvironmentVariable("Path","User")
$env:Path = $machinePath + ";" + $userPath

# 3) Vérifications rapides
Write-Output "Versions :"
terraform -version
git --version
go version

# 4) Cloner le provider et checkout tag
$buildDir = Join-Path $env:USERPROFILE "terraform-provider-proxmox-build"
if (Test-Path $buildDir) { Remove-Item $buildDir -Recurse -Force }
Write-Output "Clonage du repo Telmate..."
git clone https://github.com/Telmate/terraform-provider-proxmox.git $buildDir
if ($LASTEXITCODE -ne 0) { Write-Error "git clone a échoué."; exit 2 }

Set-Location $buildDir
git fetch --tags
git checkout v3.0.2-rc04
if ($LASTEXITCODE -ne 0) { Write-Error "git checkout v3.0.2-rc04 a échoué."; exit 3 }

# 5) Build
Write-Output "go mod tidy && go build..."
go mod tidy
go build -o terraform-provider-proxmox.exe
if (-not (Test-Path (Join-Path $buildDir "terraform-provider-proxmox.exe"))) {
  Write-Error "Compilation échouée : terraform-provider-proxmox.exe introuvable."
  exit 4
}

# 6) Copier le binaire dans le dossier plugins Terraform
$pluginDir = Join-Path $env:APPDATA "terraform.d\plugins\registry.terraform.io\telmate\proxmox\3.0.2-rc04\windows_amd64"
New-Item -ItemType Directory -Force -Path $pluginDir | Out-Null
Copy-Item (Join-Path $buildDir "terraform-provider-proxmox.exe") -Destination $pluginDir -Force

Write-Output "Provider copié dans : $pluginDir"

# 7) Initialiser ton projet Terraform (optionnel : change le chemin si besoin)
if (-not (Test-Path $projectPath)) {
  Write-Warning "Chemin projet introuvable : $projectPath`nNe lance pas 'terraform init'. Modifie la variable \$projectPath si nécessaire."
  exit 0
}

Set-Location $projectPath
Write-Output "Initialisation Terraform dans $projectPath (init -upgrade)..."
terraform init -upgrade

Write-Output "Vous pouvez maintenant exécuter : terraform plan  (depuis $projectPath)"
