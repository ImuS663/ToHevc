Param (
    [Parameter(Position=0, Mandatory=$true)]
    [string]
    $InputFile,
    [Parameter(Position=1)]
    [int]
    $Quality = 28
)

$OutputDirectory = 'output'
$OutputFile = $OutputDirectory + '\' + $InputFile

New-Item -ItemType Directory -Force $OutputDirectory -ErrorAction Stop

ffmpeg -i $InputFile -c:v libx256 -preset:v slow -crf:v $Quality $OutputFile