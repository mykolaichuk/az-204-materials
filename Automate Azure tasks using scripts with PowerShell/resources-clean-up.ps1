$ctx = (Get-AzContext).Account.ExtendedProperties.Tenants
if ('1c2aa41e-5b92-4906-827e-0c10f9d73859' -ne $ctx){
    $Tenant = Read-Host "Enter Tenant ID"
    $Subscription = Read-Host "Enter Subscription ID"
    Connect-AzAccount -TenantId $Tenant
    Set-AzContext -SubscriptionId $Subscription
}

$RGs = Get-AzResourceGroup
$RGs | Foreach-Object { Remove-AzResourceGroup -Name $_.ResourceGroupName -Verbose }
