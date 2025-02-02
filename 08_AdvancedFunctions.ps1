# Function with parameter validation
function Set-UserAge {
    param(
        # if you want to violate all clean code principles plz make sure you are using Position for your Parameters. Thank you!
        [Parameter(Mandatory=$true, Position=1)]
        [ValidateNotNullOrEmpty()]
        [string]$Name,
        
        [Parameter(Mandatory=$true, Position=0)]
        [ValidateRange(0,120)]
        [int]$Age
    )
    
    Write-Host "$Name is $Age years old"
}

# Function with pipeline support, Somehow like extension methods
function Convert-ToUpperCase {
    param(
        [Parameter(ValueFromPipeline=$true)]
        [string]$Text
    )
    
    process {
        return $Text.ToUpper()
    }
}

# Function With Parameter Sets
function Get-PersonInfo {
    [CmdletBinding(DefaultParameterSetName='Name')]
    param(
        [Parameter(ParameterSetName='Name')]
        [string]$Name,
        
        [Parameter(ParameterSetName='ID')]
        [int]$ID
    )
    
    if ($PSCmdlet.ParameterSetName -eq 'Name') {
        Write-Host "Looking up person by Name: $Name"
    }
    else {
        Write-Host "Looking up person by ID: $ID"
    }
}

# Function that accepts multiple parameter types
function Process-Data {
    param(
        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [string]$InputData,

        [Parameter()]
        [ValidateSet('Upper', 'Lower', 'Title')]
        [string]$Case = 'Upper',

        [switch]$AddTimestamp
    )

    $result = switch ($Case) {
        'Upper' { $InputData.ToUpper() }
        'Lower' { $InputData.ToLower() }
        'Title' { (Get-Culture).TextInfo.ToTitleCase($InputData.ToLower()) }
    }

    if ($AddTimestamp) {
        $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
        $result = "[$timestamp] $result"
    }

    return $result
}


Set-UserAge                 # This will work but, PowerShell will ask user to enter the function parameter values
Set-UserAge "Nima" 18       # This will throw exception because of position property of parameters
Set-UserAge 30 "Nima"       # This will work

"make this upper case please!" | Convert-ToUpperCase         # Call using pipeline
Convert-ToUpperCase -Text "make this upper case please!"     # Call like notmal function
"hello","world" | Convert-ToUpperCase                        # Passing multiple values


Get-PersonInfo -Name "Nima"
Get-PersonInfo -ID 1

Process-Data -InputData "This Is A Test String." -Case Lower -AddTimestamp
Process-Data -InputData "This Is A Test String." -Case Upper -AddTimestamp
Process-Data -InputData "this is a test string." -Case Title -AddTimestamp
$params = @{
    InputData = "hello, world"
    Case = "Title"
    AddTimestamp = $true
}
Process-Data @params
Pause

