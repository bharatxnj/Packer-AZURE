$command = '[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12'
Invoke-Expression $command

Invoke-WebRequest -Uri 'https://aka.ms/installazurecliwindows' -OutFile C:\AzureCLI.msi
$installerPath = "C:\AzureCLI.msi " 
Start-Process -FilePath $installerPath -ArgumentList "/quiet" -Wait 
$env:Path = [System.Environment]::GetEnvironmentVariable('Path','Machine')
Write-Output "Azure CLI installed successfully"
Write-Output "Azure Login Started"

# Chocolatey package
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

choco install notepadplusplus -y
choco install git.install -y

#install nice-dcv-server
Invoke-WebRequest -Uri 'https://d1uj6qtbmh3dt5.cloudfront.net/2023.0/Servers/nice-dcv-server-x64-Release-2023.0-15487.msi' -OutFile C:\nice-dev.msi
$installerPath = "C:\nice-dev.msi " 
Start-Process -FilePath $installerPath -ArgumentList "/quiet" -Wait 
$env:Path = [System.Environment]::GetEnvironmentVariable('Path','Machine')
Write-Output "nice-dcv installed successfully"

#install python
Invoke-WebRequest -Uri 'https://www.python.org/ftp/python/3.11.4/python-3.11.4-amd64.exe' -OutFile C:\python.exe
$installerPath = "C:\python.exe " 
Start-Process -FilePath $installerPath -ArgumentList "/quiet" -Wait 
$env:Path = [System.Environment]::GetEnvironmentVariable('Path','Machine')
Write-Output "python 3.11.4 installed"

#download azcopy
mkdir -p "c:\pocsoftware"
$itemType = "Directory"
$azCopyFolderName = "AzCopy"
$azCopyFolder = "C:\"  + $azCopyFolderName 
$azCopyUrl = "https://aka.ms/downloadazcopy-v10-windows"
$azCopyZip = "C:\" + "azcopy.zip"

Invoke-WebRequest https://aka.ms/downloadazcopy-v10-windows -OutFile $azCopyZip
Expand-Archive -LiteralPath $azCopyZip -DestinationPath "C:\" -Force
Remove-Item $azCopyZip

$azCopyOriginalFolderName = Get-ChildItem -Path "C:\" -Name azcopy*
$azCopyFolderToRename = "C:\" + $azCopyOriginalFolderName
$azCopyFolderToRenameTo ="C:\" + $azCopyFolderName

Rename-Item $azCopyFolderToRename $azCopyFolderToRenameTo
[Environment]::SetEnvironmentVariable("Path", $env:Path + ";$azCopyFolderToRenameTo", "Machine")
$env:Path = [System.Environment]::GetEnvironmentVariable('Path','Machine')

azcopy copy "https://softwarebucket.blob.core.windows.net/?sv=2022-11-02&ss=bfqt&srt=sco&sp=rwdlacupiytfx&se=2023-08-08T21:17:27Z&st=2023-08-08T13:17:27Z&spr=https&sig=DB%2Fk6Qw9WtZMHK0JCH0Vzxt3GPlyNHL3Boww2L%2FV35o%3D" "C:\pocsoftware" --recursive=true
#az storage azcopy blob download -c softwares --account-name softwarebucket -s * -d "C:\\Users" --recursive

[System.Environment]::SetEnvironmentVariable("SNPSLMD_LICENSE_FILE", "27031@53.55.12.247")

Start-Process -Wait -FilePath C:\pocsoftware\softwares\SilverSetup_U-2023.03.exe -ArgumentList '/VERYSILENT /FORCECLOSEAPPLICATIONS /SUPPRESSMSGBOXES /SP /DONOTINSTALLCMSERVICE'

[Environment]::SetEnvironmentVariable
            ("Path", $env:Path, [System.EnvironmentVariableTarget]::Machine)


