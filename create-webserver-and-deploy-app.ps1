# add web server with all features
Add-WindowsFeature -Name Web-Server -IncludeAllSubFeature

# clean www root folder
Remove-Item C:\inetpub\wwwroot\* -Recurse -Force

# download website zip
$ZipBlobUrl = 'https://github.com/kaushikrahul08/Terraform_Dot_Net_Website/blob/master/Website.zip'
$ZipBlobDownloadLocation = 'E:\Website.zip'
(New-Object System.Net.WebClient).DownloadFile($ZipBlobUrl, $ZipBlobDownloadLocation)

# extract downloaded zip
$UnzipLocation = 'C:\inetpub\wwwroot\'
Add-Type -assembly "system.io.compression.filesystem"
[io.compression.zipfile]::ExtractToDirectory($ZipBlobDownloadLocation, $UnzipLocation)

# read write permission
$Path = "C:\inetpub\wwwroot\temp"
$User = "IIS AppPool\DefaultAppPool"
$Acl = Get-Acl $Path
$Ar = New-Object  system.security.accesscontrol.filesystemaccessrule($User, "FullControl", "ContainerInherit,ObjectInherit", "None", "Allow")
$Acl.SetAccessRule($Ar)
Set-Acl $Path $Acl
