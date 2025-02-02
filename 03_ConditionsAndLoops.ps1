# -eq : equals
# -gt : greater than
# -lt : less than
# -ge : greater than or equal
# -le : less than or equal
# -ne : not equal

while($true){
    $input = Read-Host "Enter everything to loop or say bye to quit."
    if($input -eq "bye"){
        break
    }
}
for($i = 1; $i -le 100; $i++){
    $Even = $i % 2
    if($Even -ne 0){
        Write-Host "$i is Odd"
    }else{
        Write-Host "$i is Even"
    }
}
