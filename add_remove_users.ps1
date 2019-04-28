param (
 [Parameter(Mandatory = $true)]
 [String]$csvFile
)
 
$ADUsers= Import-CSV $csvFile
 
foreach ($User in $ADUsers)
{
 
#creates variables
 $Firstname = $User.firstname
 $Lastname = $User.lastname
 $Username = $User.username
 $Description = $User.description
 $OUpath = $User.oupath
 $Password = $User.password
 $Action = $User.action
  
#if action column is equal to add, add account 
 if($Action -eq 'add'){

    #before adding sees if user is already there 
    if (Get-ADUser -F {SamAccountName -eq $Username})
    {
    #gives warning if user exists 
    Write-Warning "A user account $Username already exist."
    }else{ 
 
 #command to actually add users using variables created above 
    New-ADUser `

     -SamAccountName $Username `
     -Name "$Firstname $Lastname" `
     -GivenName $Firstname `
     -Surname $Lastname `
     -Enabled $True `
     -Description $Description `
     -ChangePasswordAtLogon $True `
     -DisplayName "$Lastname, $Firstname" `
     -Path $OUpath `
     -AccountPassword (convertto-securestring $Password -AsPlainText -Force)
 }
 }else{
 #if user existed you can remove because the first loop would run if it didnt 
 if (Get-ADUser -F {SamAccountName -eq $Username}){

 Remove-ADUser -Identity $Username

 }

 else{

 Write-Warning "A user account $Username does NOT exist."

 }

 }

}