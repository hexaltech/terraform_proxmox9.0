Set-ExecutionPolicy Bypass -Scope Process -Force; `
[System.Net.ServicePointManager]::SecurityProtocol = `
[System.Net.ServicePointManager]::SecurityProtocol -bor 3072; `
iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

choco install terraform -y
choco install git -y
choco install golang -y

terraform -version
git --version
go version


mkdir terraform-provider-proxmox
cd terraform-provider-proxmox

git clone https://github.com/Telmate/terraform-provider-proxmox.git
git checkout v3.0.2-rc04

go mod tidy
go build -o terraform-provider-proxmox.exe

$pluginPath = "$env:APPDATA\terraform.d\plugins\registry.terraform.io\telmate\proxmox\3.0.2-rc04\windows_amd64"
New-Item -ItemType Directory -Path $pluginPath -Force

Copy-Item "terraform-provider-proxmox.exe" $pluginPath

Get-ChildItem $pluginPath


terraform init -upgrade
terraform plan
terraform apply -auto-approve
