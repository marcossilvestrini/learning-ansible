
#Fix openssh powershell
$Env:VAGRANT_PREFER_SYSTEM_BIN += 0

#Fix download boxes
vagrant box add --insecure debian/buster64
vagrant box add --insecure gusztavvargadr/windows-server-standard-core