# Terraform Proxmox 9.0

Ce projet permet de déployer et gérer des machines virtuelles sur **Proxmox** à l'aide de **Terraform**.

## 📂 Structure du projet

```
terraform_proxmox9.0-main/
├── install_terraform.ps1      # Script PowerShell pour installer Terraform (Windows)
├── terraform_commande.ps1      # Script PowerShell contenant les commandes Terraform de base
├── terraform_user.sh           # Script Shell pour configurer l’utilisateur Terraform (Linux)
└── Terraform_LAB/              # Répertoire de configuration Terraform
    ├── main.tf                 # Fichier principal Terraform
    ├── terraform.tfvars        # Variables personnalisées (non versionnées en prod)
    ├── variables.tf            # Définition des variables Terraform
    └── vm.tf                   # Définition des VMs à déployer
```

## ⚙️ Prérequis

- Un **Proxmox** fonctionnel (version 9.x compatible avec Terraform provider).
- **Terraform** installé sur votre poste (Windows ou Linux).
- Accès SSH/API à votre Proxmox.
- Un utilisateur Proxmox dédié à Terraform (géré via `terraform_user.sh`).

## 🚀 Installation

### Sous Windows
Exécuter en tant qu'Admin, le script PowerShell suivant pour installer Terraform :

```powershell
./install_terraform.ps1
```

### Sous Linux
Exécuter le script pour créer/configurer l’utilisateur Terraform :

```bash
chmod +x terraform_user.sh
./terraform_user.sh
```

## ▶️ Utilisation

1. Aller dans le dossier **Terraform_LAB** :
   ```bash
   cd Terraform_LAB
   ```

2. Initialiser Terraform :
   ```bash
   terraform init
   ```

3. Vérifier le plan d’exécution :
   ```bash
   terraform plan
   ```

4. Appliquer la configuration :
   ```bash
   terraform apply -auto-approve
   ```

## 📌 Notes

- Le fichier `terraform.tfvars` contient vos variables personnalisées (IP, identifiants, noms de VM, etc.).
- Vous pouvez utiliser le script **terraform_commande.ps1** pour exécuter rapidement les commandes Terraform courantes.

## 📖 Documentation

- [Terraform](https://developer.hashicorp.com/terraform/docs)
- [Proxmox Provider](https://registry.terraform.io/providers/Telmate/proxmox/latest)

---
✍️ Auteur : **Hexaltech**
