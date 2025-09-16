pveum user add terraform@pve
pveum role add TerraformRole -privs "Datastore.Allocate VM.Allocate VM.Audit VM.Config.Disk VM.Config.CDROM VM.Config.CPU VM.Config.Memory VM.Config.Network VM.Config.Options VM.Console VM.Migrate VM.PowerMgmt Sys.Audit Sys.Modify"
pveum aclmod / -user terraform@pve -role TerraformRole
pveum user token add terraform@pve terraform-token --privsep=0
