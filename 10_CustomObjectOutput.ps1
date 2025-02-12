# Define a class
class Student {
    [string]$Name
    [int]$Age
    [hashtable]$Scores

    # Constructor
    Student([string]$name, [int]$age) {
        $this.Name = $name
        $this.Age = $age
        $this.Scores = @{}
    }

    # Method to add score
    [void] AddScore([string]$subject, [int]$score) {
        $this.Scores[$subject] = $score
    }

    # Method to get average
    [double] GetAverage() {
        $total = 0
        $this.Scores.Values | ForEach-Object { $total += $_ }
        return $total / $this.Scores.Count
    }
}

# Function that accepts a Student object
function Show-StudentReport {
    param(
        [Parameter(Mandatory=$true, ValueFromPipeline=$true)]
        [Student]$Student
    )
    
    process {
        Write-Host "`nStudent Report for $($Student.Name)"
        Write-Host "Age: $($Student.Age)"
        Write-Host "Scores:"
        $Student.Scores.GetEnumerator() | ForEach-Object {
            Write-Host "  $($_.Key): $($_.Value)"
        }
        Write-Host "Average: $($Student.GetAverage())"
    }
}

# Create and use students
$john = [Student]::new("John", 20)
$john.AddScore("Math", 85)
$john.AddScore("English", 90)
$john.AddScore("Science", 88)

$mary = [Student]::new("Mary", 19)
$mary.AddScore("Math", 95)
$mary.AddScore("English", 92)
$mary.AddScore("Science", 94)

$nima = [Student]::new("Nima Noshahi", 30)
$nima.AddScore("Math", 93)
$nima.AddScore("English", 94)
$nima.AddScore("Science", 96)

$Students = @($john, $mary, $nima)

# Show individual reports
# $john, $mary | Show-StudentReport
$Students | Show-StudentReport

$Students | Format-Table
# Method 1: Simple table with Format-Table
$Students | Format-Table Name, Age, @{
    Label = "Average"
    Expression = { $_.GetAverage() }
}

# Method 2: More formatted table with custom properties
$Students | Select-Object Name, Age, @{
    Label = "Average"
    Expression = { [math]::Round($_.GetAverage(), 2) }
}, @{
    Label = "Subjects"
    Expression = { $_.Scores.Keys -join ", " }
} | Format-Table -AutoSize

# Method 3: Detailed table with all scores
$Students | ForEach-Object {
    [PSCustomObject]@{
        Name = $_.Name
        Age = $_.Age
        Average = [math]::Round($_.GetAverage(), 2)
        Math = $_.Scores["Math"]
        English = $_.Scores["English"]
        Science = $_.Scores["Science"]
    }
} | Format-Table -AutoSize
