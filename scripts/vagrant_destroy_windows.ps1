#Vagrant Boxes
$debian = "F:\Projetos\udemy\ansible\Vagrant\Debian"
$ansible = "F:\Projetos\udemy\ansible\Vagrant\Ansible"
$ol8 = "F:\Projetos\udemy\ansible\Vagrant\OracleLinux"
$win = "F:\Projetos\udemy\ansible\Vagrant\win2019"

#ansible
Set-Location $ansible
vagrant destroy -f

#debian
Set-Location $debian
vagrant destroy -f

#centos
Set-Location $ol8
vagrant destroy -f

#windows
Set-Location $win
vagrant destroy -f