#Vagrant Boxes
$debian = "F:\Projetos\udemy\ansible\Vagrant\Debian"
$ol8 = "F:\Projetos\udemy\ansible\Vagrant\OracleLinux"
$win = "F:\Projetos\udemy\ansible\Vagrant\win2019"
$ansible = "F:\Projetos\udemy\ansible\Vagrant\Ansible"

#down debian
Set-Location $debian
vagrant halt

#down centos
Set-Location $ol8
vagrant halt

#down windows
Set-Location $win
vagrant halt

#down ansible
Set-Location $ansible
vagrant halt