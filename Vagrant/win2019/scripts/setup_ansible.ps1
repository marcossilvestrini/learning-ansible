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

# Mapping a Certificate to an Account
$username = "vagrant"
$password = ConvertTo-SecureString -String "vagrant" -AsPlainText -Force
$credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $username, $password

# This is the issuer thumbprint which in the case of a self generated cert
# is the public key thumbprint, additional logic may be required for other
# scenarios
$thumbprint = (Get-ChildItem -Path cert:\LocalMachine\root | Where-Object { $_.Subject -eq "CN=$username" }).Thumbprint

New-Item -Path WSMan:\localhost\ClientCertificate `
    -Subject "$username@localhost" `
    -URI * `
    -Issuer $thumbprint `
    -Credential $credential `
    -Force