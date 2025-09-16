terraform init
 & terraform "plan" "-target=proxmox_vm_qemu.win11"
  & terraform "apply" "-target=proxmox_vm_qemu.win11" -parallelism=1


   & terraform "plan" "-target=proxmox_vm_qemu.debian"
  & terraform "apply" "-target=proxmox_vm_qemu.debian" -parallelism=1

