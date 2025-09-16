# ---- Proxmox API ----
variable "pm_api_url" {
  description = "Adresse de l'API Proxmox"
  type        = string
}

variable "pm_api_token_id" {
  description = "ID du token API Proxmox"
  type        = string
}

variable "pm_api_token_secret" {
  description = "Secret du token API Proxmox"
  type        = string
  sensitive   = true
}

variable "pm_tls_insecure" {
  description = "Accepter les certificats auto-signés"
  type        = bool
  default     = true
}

variable "target_node" {
  description = "Nom du node Proxmox"
  type        = string
  default     = "Proxmox-Terraform"
}

variable "storage" {
  description = "Nom du stockage Proxmox"
  type        = string
  default     = "DATAS"
}

variable "vm_bridge" {
  description = "Bridge réseau à utiliser"
  type        = string
  default     = "vmbr0"
}

# ---- VM Configurations ----
variable "vm_configs" {
  description = "Configurations des différents templates de VM"
  type = map(object({
    template_name : string
    count         : number
    name_prefix   : string
    memory        : number
    cores         : number
    disk_size     : string
  }))
  default = {
    debian = {
      template_name = "debian12-template"
      count         = 15
      name_prefix   = "debian"
      memory        = 2048
      cores         = 2
      disk_size     = "10G"
    },
    win11 = {
      template_name = "win11-template"
      count         = 15
      name_prefix   = "win11"
      memory        = 4096
      cores         = 2
      disk_size     = "50G"
    }
  }
}
