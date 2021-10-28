#Get Credentials
#$M365Creds = 

Connect-MSOLService -Credential (Get-Credential)
import-module MSOnline
Get-MSOLUser | Where-Object { $_.isLicensed -eq "True"} | Select-Object DisplayName, UserPrincipalName, isLicensed, @{n="Licenses Type";e={$_.Licenses.AccountSKUid}} | Export-Csv .\LicensedUsers.csv