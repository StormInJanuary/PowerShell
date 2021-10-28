$CurrentLicensesCSV = Import-Csv '.\CSV\CurrentLicenses.csv'
$CurrentStaffCSV = Import-Csv '.\CSV\CurrentStaff.csv'
$missing = @()

# Loop through records in csv1 and see if they are in csv2
foreach ($user in $CurrentLicensesCSV)
{
    if ($CurrentStaffCSV.UPN -match $user.UPN)
    {
        Write-Verbose "$user.UPN is in both files"
    }
    else
    {
        Write-Verbose "$user.UPN is missing from CurrentStaffCSV"
        $missing += $user
    }
}
Clear-Variable -Name user

# Loop through records in CurrentStaffCSV and see if they are in CurrentLicensesCSV
foreach ($user in $CurrentStaffCSV)
{
    if ($CurrentLicensesCSV.UPN -match $user.UPN)
    {
        Write-Verbose "$user.UPN is in both files"
    }
    else
    {
        Write-Verbose "$user.UPN is missing from CurrentLicensesCSV"
        $missing += $user
    }
}

# Write differences to new file
$missing | Export-Csv -path ".\CSV\RemoveUserLicenses.csv" -NoTypeIn