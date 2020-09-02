$ctx = (Get-AzContext).Account.ExtendedProperties.Tenants
if ('1c2aa41e-5b92-4906-827e-0c10f9d73859' -ne $ctx){
    $Tenant = Read-Host "Enter Tenant ID"
    $Subscription = Read-Host "Enter Subscription ID"
    Connect-AzAccount -TenantId $Tenant
    Set-AzContext -SubscriptionId $Subscription
}

$RG = "az-204-$(Get-Random -Minimum 100 -Maximum 999)"
$Location = "westeurope"
$VMName = "itstep-az-204-$(Get-Random -Minimum 100 -Maximum 999)"
$VMSize = "Standard_B1ms"

New-AzResourceGroup -Name $RG -Location $Location

New-AzVm `
    -Name  $VMName `
    -ResourceGroupName $RG `
    -Credential (Get-Credential) `
    -Location $Location `
    -Image UbuntuLTS `
    -OpenPorts 22 `
    -Size $VMSize `
    -Verbose

$VM = Get-AzVm -ResourceGroupName $RG
$VMAdminUser = $VM.OSProfile.AdminUsername
$VMPublicIp = (Get-AzPublicIpAddress -ResourceGroupName $RG).IpAddress
Write-Host -ForegroundColor Green "Now connect to the VM via SSH:"
Write-Host "ssh $VMAdminUser@$VMPublicIp"