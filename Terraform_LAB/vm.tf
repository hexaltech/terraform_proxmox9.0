# =====================================
# Ressources pour les VM Proxmox
# =====================================

# ---- Debian ----
resource "proxmox_vm_qemu" "debian" {
  count       = var.vm_configs["debian"].count
  name        = "${var.vm_configs["debian"].name_prefix}-${count.index + 1}"
  target_node = var.target_node
  clone       = var.vm_configs["debian"].template_name
  vmid        = 400 + count.index

  cpu {
    cores = var.vm_configs["debian"].cores
  }

  memory = var.vm_configs["debian"].memory

  disk {
    slot    = "scsi0"
    type    = "disk"
    size    = var.vm_configs["debian"].disk_size
    storage = var.storage
  }

  network {
    id     = 0
    model  = "virtio"
    bridge = var.vm_bridge
  }
}

# ---- Windows 11 ----
resource "proxmox_vm_qemu" "win11" {
  count       = var.vm_configs["win11"].count
  name        = "${var.vm_configs["win11"].name_prefix}-${count.index + 1}"
  target_node = var.target_node
  clone       = var.vm_configs["win11"].template_name
  vmid        = 300 + count.index

  cpu {
    cores = var.vm_configs["win11"].cores
  }

  memory = var.vm_configs["win11"].memory

  disk {
    slot    = "scsi0"
    type    = "disk"
    size    = var.vm_configs["win11"].disk_size
    storage = var.storage
  }

  network {
    id     = 0
    model  = "virtio"
    bridge = var.vm_bridge
  }
}

# ---- Ajouter d'autres templates ----
# Pour chaque nouveau template, copier le bloc ci-dessus et remplacer :
# - le nom de la ressource (ex : ubuntu)
# - les références dans var.vm_configs["nouveau_template"]
# - le vmid pour éviter les collisions (ex : 500 + index)
