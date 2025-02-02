# Simple function
# If you try to overload functions it may conflict.
function Say-HelloNoParams {
    "Hello, Welcome to functions course in PowerShell." | Out-Host
}

# Function with parameters
function Say-Hello {
    param([string]$name, [int]$age = 18)

        Write-Host "$($name): $age"
}

# Function with return value
function IsOddNumber([int]$number){
    return $number%2 -eq 1
}

# Say-Hello
Say-HelloNoParams
Say-Hello "John" 25                  # Positional
Say-Hello "John"                     # Positional with Age Default Value
Say-Hello -name "John" -age 25       # Named parameters
Say-Hello -age 25 -name "John"       # Named parameters in any order


# Important, First we have to store $result
$result = IsOddNumber -number 10
if($result -eq $false) {
    Write-Host "10 is Even"
}
# This will not work, Because powershell interprets it as:
# (IsOddNumber -number (10 -eq $false))
if(IsOddNumber -number 10 -eq $false) {
    Write-Host "10 is Even Not Working"
}
if((IsOddNumber -number 10) -eq $false) {
    Write-Host "10 is Even Fixed!"
}
if(-not (IsOddNumber -number 10)) {
    Write-Host "10 is Even Fix 2!"
}
$result = IsOddNumber -number 11
if($result -eq $true) {
    Write-Host "11 is Odd"
}

Pause