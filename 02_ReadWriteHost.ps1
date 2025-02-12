function ReadWriteHost(){
    $name = Read-Host "Hello, what's your name?"
    Write-Host "Hello, $name"
    # "Hello, $name" | Out-Host
    
    $count = 0

    while($count -lt 20){
        $input = Read-Host ""$name, Enter your age.$([environment]::NewLine)Or enter bye to exit.""
        
        $age = 0
    
        if([int]::TryParse($input, [Ref]$age)){
            if($age -gt 18){
                Write-Host "You can use this software, as your age is greater than 18."
            } elseif ($age -eq 18){
                Write-Host "You can use this software, as your age is equals to 18."
            }else{
                Write-Host "Sorry, You are not old enough to use this software."
            }
        }
        elseif($input -eq "bye"){
            break
        }
        $count++
    }
}

ReadWriteHost
pause
