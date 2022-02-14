#Vagrant Boxes
$debian = "F:\Projetos\udemy\ansible\Vagrant\Debian"
$ol8 = "F:\Projetos\udemy\ansible\Vagrant\OracleLinux"
$win = "F:\Projetos\udemy\ansible\Vagrant\win2019"
$ansible = "F:\Projetos\udemy\ansible\Vagrant\Ansible"

#up windows
Set-Location $win
vagrant up
While (Get-Process -name vagrant -ErrorAction SilentlyContinue) { continue }

#up debian
Set-Location $debian
vagrant up
While (Get-Process -name vagrant -ErrorAction SilentlyContinue) { continue }

#up centos
Set-Location $ol8
vagrant up
While (Get-Process -name vagrant -ErrorAction SilentlyContinue) { continue }

#up ansible
Set-Location $ansible
vagrant up
While (Get-Process -name vagrant -ErrorAction SilentlyContinue) { continue }

#Fix powershell error
$Env:VAGRANT_PREFER_SYSTEM_BIN += 0

#open ssh tabs for conect
wt -p "Windows Powershell" -d "F:\Projetos\udemy\ansible\Vagrant\Ansible" --title "Ansible"
wt -w 0 nt -d "F:\Projetos\udemy\ansible\Vagrant\Debian" --title "Debian"
wt -w 0 nt -d "F:\Projetos\udemy\ansible\Vagrant\OracleLinux" --title "OracleLinux"
wt -w 0 nt -d "F:\Projetos\udemy\ansible\Vagrant\win2019" --title "Win2019"