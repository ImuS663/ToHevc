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

ffmpeg -hwaccel cuda -i $InputFile -c:v hevc_nvenc -preset:v p7 -tune:v uhq -rc:v vbr -cq:v $Quality -b:v 0 $OutputFile