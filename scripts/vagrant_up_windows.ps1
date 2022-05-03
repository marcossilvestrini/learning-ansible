#Vagrant Boxes
$debian = "F:\Projetos\udemy\ansible\Vagrant\Debian"
$ol8 = "F:\Projetos\udemy\ansible\Vagrant\OracleLinux"
$ansible = "F:\Projetos\udemy\ansible\Vagrant\Ansible"
$win = "F:\Projetos\udemy\ansible\Vagrant\win2019"

#up debian
Set-Location $debian
vagrant up
Copy-Item .\.vagrant\machines\debian_ansible\virtualbox\private_key F:\Projetos\vagrant-pk\vagrant-ansible-debian

# #up ol8
# Set-Location $ol8
# vagrant up
# Copy-Item .\.vagrant\machines\ol8_ansible\virtualbox\private_key F:\Projetos\vagrant-pk\vagrant-ansible-ol8

#up ansible
Set-Location $ansible
vagrant up
Copy-Item .\.vagrant\machines\debian_ansible_master\virtualbox\private_key F:\Projetos\vagrant-pk\vagrant-ansible-master-debian

# # #up windows
# Set-Location $win
# vagrant up

#Fix powershell error
$Env:VAGRANT_PREFER_SYSTEM_BIN += 0

#https://docs.microsoft.com/en-us/windows/terminal/command-line-arguments?tabs=windows
#open ssh tabs for conect
wt -p "Windows Powershell" -d "F:\Projetos\udemy\ansible\Vagrant\Ansible" --title "Ansible" --tabColor '#a99300'
wt -w 0 nt -d "F:\Projetos\udemy\ansible\Vagrant\Debian" --title "Debian" --tabColor '#abcdef'
#wt -w 0 nt -d "F:\Projetos\udemy\ansible\Vagrant\OracleLinux" --title "OracleLinux" --tabColor '#dc9300'
#wt -w 0 nt -d "F:\Projetos\udemy\ansible\Vagrant\win2019" --title "Win2019" --tabColor '#379300'