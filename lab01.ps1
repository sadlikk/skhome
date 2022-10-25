id = '24798'
Write-Host "Moja grupa w tym cwiczeniu : AZ300-RGlod260$id" ;
Get-AzResourceGroup -Name "AZ300-RGlod260$id" ;

$VMLocalAdminUser = 'AZ300-VMAdmin' ;
$VMLocalAdminSecurePassword = ConvertTo-SecureString 'AZ300-VMPassw0rd!' -AsPlainText -Force ;
$Credential = New-Object System.Management.Automation.PSCredential ($VMLocalAdminUser, $VMLocalAdminSecurePassword);

New-AzureRmVM -ResourceGroupName "AZ300-RGlod260$id" -Name "WinVM" -Location "East US" -VirtualNetworkName "VNet1-260$id" -SubnetName "Subnet1-260$id" -Size "Standard_D3_v2" -SecurityGroupName "SG1-260$id" -PublicIpAddressName "PIP1-260$id" -OpenPorts 80,3389 -Credential $Credential -PublicIpSku 'Basic'

Invoke-AzVMRunCommand -ResourceGroupName "AZ300-RGlod260$id" -Name "WinVM" -CommandId 'RunPowerShellScript' -ScriptString 'Install-WindowsFeature -Name Web-Server -IncludeManagementTools'

Get-AzureRmPublicIpAddress -Name "PIP1-260$id" -ResourceGroupName "AZ300-RGlod260$id"

# mstsc /v:20.124.0.213 /admin

