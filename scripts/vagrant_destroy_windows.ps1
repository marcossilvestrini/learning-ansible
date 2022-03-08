#Vagrant Boxes
$win = "F:\Projetos\udemy\ansible\Vagrant\win2019"
$ol8 = "F:\Projetos\udemy\ansible\Vagrant\OracleLinux"
$debian = "F:\Projetos\udemy\ansible\Vagrant\Debian"
$ansible = "F:\Projetos\udemy\ansible\Vagrant\Ansible"

#windows
Set-Location $win
vagrant destroy -f

#ol8
Set-Location $ol8
vagrant destroy -f

#debian
Set-Location $debian
vagrant destroy -f

#ansible
Set-Location $ansible
vagrant destroy -f