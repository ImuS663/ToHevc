Param (
    [Parameter(Position=0, Mandatory=$true)]
    [System.IO.FileInfo]
    $InputFile,
    [Parameter(Position=1)]
    [int]
    $Quality = 28
)

$OutputDirectory = $InputFile.Directory.FullName + '\output'
$OutputFile = $OutputDirectory + '\' + $InputFile.Name

New-Item -ItemType Directory -Force $OutputDirectory -ErrorAction Stop

ffmpeg -i $InputFile.FullName -c:v libx256 -preset:v slow -crf:v $Quality $OutputFile