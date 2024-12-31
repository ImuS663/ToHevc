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

ffmpeg -hwaccel cuda -hwaccel_output_format cuda -i $InputFile.FullName -c:v hevc_nvenc -preset:v p7 -tune:v uhq -rc:v vbr -cq:v $Quality -b:v 0 $OutputFile