# ---- Proxmox API ----
pm_api_url          = "https://192.168.1.21:8006/api2/json"
pm_api_token_id     = "terraform@pam!terraform-token"
pm_api_token_secret = "9b172d61-1725-490b-a3c7-e5820e9e6a0c"
target_node         = "Proxmox-Terraform"
pm_tls_insecure     = true
storage             = "DATAS"
vm_bridge           = "vmbr0"

# ---- VM Configurations (optionnel si tu veux override) ----
vm_configs = {
  debian = {
    template_name = "debian12-template"
    count         = 5
    name_prefix   = "debian"
    memory        = 2048
    cores         = 2
    disk_size     = "10G"
  },
  win11 = {
    template_name = "win11-template"
    count         = 2
    name_prefix   = "win11"
    memory        = 4096
    cores         = 2
    disk_size     = "50G"
  }
}
