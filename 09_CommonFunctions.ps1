function Do-Something {
    param(
        # Mandatory parameter
        [Parameter(Mandatory=$true)]
        [string]$RequiredParam,

        # Optional parameter with default
        [string]$OptionalParam = "default",

        # Switch parameter
        [switch]$EnableFeature,

        # Array parameter
        [string[]]$Items,

        # Validated parameter
        [ValidateSet("Option1", "Option2", "Option3")]
        [string]$Choice,

	[ValidatePattern("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")]
        [string]$Email
    )
    Write-Host "$RequiredParam $OptionalParam $EnableFeature $Items $Choice"
    # Function body
}

function Get-Statistics {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline=$true)]
        [int]$Number
    )
    
    begin {
        $sum = 0
        $count = 0
    }
    
    process {
        $sum += $Number
        $count++
    }
    
    end {
        $average = $sum / $count
        Write-Output "Total: $sum, Count: $count, Average: $average"
    }
}

1..5 | Get-Statistics

# Call examples:
Do-Something -RequiredParam "value"
Do-Something -RequiredParam "value" -OptionalParam "custom"
Do-Something -RequiredParam "value" -EnableFeature
Do-Something -RequiredParam "value" -Items "item1","item2","item3"
Do-Something -RequiredParam "value" -Choice "Option1"

$input = @{
	RequiredParam = "value"
	Choice = "Option1"
}

Do-Something $input

Pause