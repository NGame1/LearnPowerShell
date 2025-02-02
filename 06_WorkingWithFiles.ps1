function Read-FilePS([string]$FilePath){
    $content = Get-Content $FilePath #-Raw #-Encoding UTF8
    Write-Host $content
}

function Read-FileCS([string]$FilePath){
    $content = [System.IO.File]::ReadAllText($FilePath)
    Write-Host $content
}

function Add-FileContent([string]$FilePath, [string]$Content){
    # Set-Content -Path $FilePath -Value $Content -Encoding UTF8
    # $Content | Out-File $FilePath -Encoding utf8 -Append
    Add-Content -Path $FilePath -Value $Content -Encoding UTF8
}

function File-Exists(){
    $FileName = "00_SampleFile01.txt"
    if( -not (Test-Path $FileName) ){
        Write-Host "Path not exists."
        $FileContent = "به سوال زیر پاسخ دهید.`nAnswer the following question.`n"
        New-Item -Name "00_SampleFile01.txt" -ItemType File -Value $FileContent
    }
}

# Code starts from here
File-Exists
$filePath = Read-Host "Enter a file name to read and write or enter to use 00_SampleFile01.txt"
if($filePath.Length -eq 0){
    $filePath = "00_SampleFile01.txt"
}

$filePath = "$($PWD)\$($filePath)"
Read-FilePS -FilePath $filePath
Read-FileCS -FilePath $filePath
Add-FileContent -FilePath $filePath -Content "This line added by PowerShell script."
Add-FileContent -FilePath $filePath -Content "این متن از طریق فرامین پاورشل اضافه شده است."
pause