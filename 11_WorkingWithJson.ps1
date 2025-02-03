class Student{
    [string] $FirstName
    [string] $LastName
    [int] $Age

    #constructor 
    Student([string] $FirstName,
         [string] $LastName,
         [int] $Age){
         $this.FirstName = $FirstName
         $this.LastName = $LastName
         $this.Age = $Age
    }

    # Method to convert to JSON-friendly format
    [hashtable] ToJsonObject() {
        return @{
            Name = $this.FirstName
            LastName = $this.LastName
            Age = $this.Age
            FullName = [string]::Concat($this.FirstName, ' ', $this.LastName)
        }
    }

    # Static method to create Student from JSON
    static [Student] FromJson([PSCustomObject]$jsonObject) {
        return [Student]::new($jsonObject.FirstName, $jsonObject.LastName, $jsonObject.Age)
    }

}

# 1. Save students to JSON file
function Export-StudentsToJson {
    param(
        [Parameter(ValueFromPipeline=$true)]
        [Student[]]$Students,
        [string]$FilePath
    )
    
    begin {
        $allStudents = @()
    }
    
    process {
        $allStudents += $Students
    }
    
    end {
        $jsonObjects = $allStudents | ForEach-Object { $_.ToJsonObject() }
        $jsonObjects | ConvertTo-Json -Depth 10 | Set-Content -Path $FilePath
        Write-Host "Exported $($allStudents.Count) students to $FilePath"
    }
}

# 2. Load students from JSON file
function Import-StudentsFromJson {
    param(
        [string]$FilePath
    )
    
    $jsonContent = Get-Content -Path $FilePath | ConvertFrom-Json
    $students = $jsonContent | ForEach-Object {
        [Student]::FromJson($_)
    }
    return $students
}

# Create some sample students
$students = @(
    [Student]::new("Ali", "Noshahi", 20)
    [Student]::new("Amin", "Jeff", 19)
    [Student]::new("Saeed", "Sheikhi", 18)
)

# 1. Export students to JSON
$students | Export-StudentsToJson -FilePath "00_students.json"

# 2. Import students from JSON
$loadedStudents = Import-StudentsFromJson -FilePath "00_students.json"

foreach($student in $students){
    Write-Host $student.FirstName
}

Pause