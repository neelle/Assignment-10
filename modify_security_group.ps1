param (
 [Parameter(Mandatory = $true)]
 [String]$csvFile
)
 
$ADUsers= Import-CSV $csvFile
 
foreach ($User in $ADUsers)
{
 
#creates variables
 $name = $user.name
 $Description = $User.description
 $OUpath = $User.oupath
 $scope = $User.scope
 $category = $user.category

  

 
	New-ADGroup ` 
     
     -Name $name `
     -Description $Description `
     -Path $OUpath `
     -scope $scope `
     -category $category `
 

}