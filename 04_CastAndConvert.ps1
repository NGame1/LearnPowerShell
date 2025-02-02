Write-Host "Welcome to sum calculator"
Write-Host "Enter numbers to sum or enter = for the result."
$Result = 0

# The following Code can be throw exception if we enter string or character.
# while($true) {
#     $input = Read-Host
#     if($input -ceq "="){
#         Write-Host "Result: $Result"
#         break
#     }
#     $input = [int]$input
#     $Result += $input
# }


# while($true) {
#     $input = Read-Host
#     if($input -ceq "="){
#         Write-Host "Result: $Result"
#         break
#     }
#     try{
#         # If we don't use try catch Result will not be valid in most cases.
#         $intInput = [System.Convert]::ToInt32($input)
#         $Result += $intInput
#     }
#     catch{
#         Write-Host $_.Exception.Message
#     }
# }


while($true) {
    $input = Read-Host
    if($input -ceq "="){
        Write-Host "Result: $Result"
        break
    }
    $intInput = 0
    if([int]::TryParse($input, [Ref]$intInput)){
        $Result += $intInput
    }else{
        Write-Host "Unable to cast $input to intger."
    }
}