#Vagrant Boxes
$debian = "F:\Projetos\udemy\ansible\Vagrant\Debian"
$ol8 = "F:\Projetos\udemy\ansible\Vagrant\OracleLinux"
$win = "F:\Projetos\udemy\ansible\Vagrant\win2019"

#up debian
Set-Location $debian
vagrant up

#up centos
Set-Location $ol8
vagrant up

#up windows
Set-Location $win
vagrant up

#Fix powershell error
$Env:VAGRANT_PREFER_SYSTEM_BIN += 0

#open ssh tabs for conect
wt -p "Windows Powershell" -d "F:\Projetos\udemy\ansible\Vagrant\Debian" --title "Vagrant Debian"
wt -w 0 nt -d "F:\Projetos\udemy\ansible\Vagrant\OracleLinux" --title "Vagrant OracleLinux"
wt -w 0 nt -d "F:\Projetos\udemy\ansible\Vagrant\win2019" --title "Vagrant Win2019"