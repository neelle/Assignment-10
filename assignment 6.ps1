param (
 [Parameter(Mandatory = $true)]
 [String]$csvFile
)
 
$ADUsers= Import-CSV $csvFile
 
foreach ($User in $ADUsers)
{
 
#creates variables
 $groupname = $user.groupname
 $Username = $User.username
 $Action = $User.action
  
 
 if($Action -eq 'add'){

    if (Get-ADUser -F {SamAccountName -eq $Username})
    {
    Write-Warning "A group $Username already exist."
    }else{ 
 
 new-adgroup

     -groupname $groupname `
     -username $username ` 
     -action $Action `
 }
 }else{
 #if user existed you can remove because the first loop would run if it didnt 
 if (Get-ADUser -F {SamAccountName -eq $Username}){

 Remove-ADUser -groupname $groupname -Identity $Username

 }

 else{

 Write-Warning "A user account $Username does NOT exist."

 }

 }

}