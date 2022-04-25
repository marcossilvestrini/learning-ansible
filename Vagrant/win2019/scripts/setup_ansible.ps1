# Install python
choco feature disable -n=showDownloadProgress
choco install python -y

# Disabled Firewall
Set-NetFirewallProfile -Profile Domain, Public, Private -Enabled False
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# Setup winrm
$url = "https://raw.githubusercontent.com/ansible/ansible/devel/examples/scripts/ConfigureRemotingForAnsible.ps1"
$file = "$env:temp\ConfigureRemotingForAnsible.ps1"
(New-Object -TypeName System.Net.WebClient).DownloadFile($url, $file)
powershell.exe -ExecutionPolicy ByPass -File $file

# Enable Certificate authentication (targets windows)
Set-Item -Path WSMan:\localhost\Service\Auth\Certificate -Value $true

# Set reg ClientAuthTrustMode
Set-ItemProperty -Path registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL -Name ClientAuthTrustMode -Type DWord -Value 2

#Copy cert key file
Copy-Item C:\security\cert.pem C:\Users\vagrant\.ssh\ -Force

# Import certificate
$cert = New-Object -TypeName System.Security.Cryptography.X509Certificates.X509Certificate2
$cert.Import("C:\Users\vagrant\.ssh\cert.pem")
$store_name = [System.Security.Cryptography.X509Certificates.StoreName]::Root
$store_location = [System.Security.Cryptography.X509Certificates.StoreLocation]::LocalMachine
$store = New-Object -TypeName System.Security.Cryptography.X509Certificates.X509Store -ArgumentList $store_name, $store_location
$store.Open("MaxAllowed")
$store.Add($cert)
$store.Close()

# Import client certificate public key
$cert = New-Object -TypeName System.Security.Cryptography.X509Certificates.X509Certificate2
$cert.Import("C:\Users\vagrant\.ssh\cert.pem")
$store_name = [System.Security.Cryptography.X509Certificates.StoreName]::TrustedPeople
$store_location = [System.Security.Cryptography.X509Certificates.StoreLocation]::LocalMachine
$store = New-Object -TypeName System.Security.Cryptography.X509Certificates.X509Store -ArgumentList $store_name, $store_location
$store.Open("MaxAllowed")
$store.Add($cert)
$store.Close()