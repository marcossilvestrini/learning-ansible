#Vagrant Boxes
$debian = "F:\Projetos\udemy\ansible\Vagrant\Debian"
$ol8 = "F:\Projetos\udemy\ansible\Vagrant\OracleLinux"
$win = "F:\Projetos\udemy\ansible\Vagrant\win2019"

#up debian
Set-Location $debian
vagrant halt

#up centos
Set-Location $ol8
vagrant halt

#up windows
Set-Location $win
vagrant halt