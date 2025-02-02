# $fixedArray = @(1, 2, 3)
# 
# # $fixedArray.Add(4)
# $fixedArray.Clear()
# $fixedArray[0] = 2
# $fixedArray.SetValue(5,1)
# $fixedArray.Set(2,10)
# foreach($iten in $fixedArray){
#     Write-Host $iten
# }
[System.Array]$arr = [System.Array]::Empty()
[System.Collections.ArrayList]$list = @() # [System.Collections.ArrayList]::new()
while($true){
    Write-Host "Capacity: $($list.Capacity) IsFixedSize: $($list.IsFixedSize) Count: $($list.Count)" 
    $input = Read-Host "Enter something to add in the list or exit to quit"
    if($input -eq "exit"){
        break
    }
    $list.Add($input)
}
$list.Sort()
$list.Reverse()
foreach($item in $list){
    Write-Host "$item"
}