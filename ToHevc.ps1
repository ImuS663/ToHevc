Param (
    [Parameter(Position=0, Mandatory=$true)]
    [System.IO.FileInfo]
    $InputFile,
    [Parameter(Position=1)]
    [int]
    $Quality = 28,
    [Parameter(Position=2)]
    [int]
    $WidthSize = -1,
    [Parameter(Position=3)]
    [int]
    $HeightSize = -1
)

$OutputDirectory = $InputFile.Directory.FullName + "\output"
$OutputFile = $OutputDirectory + "\" + $InputFile.BaseName + ".mp4"

New-Item -ItemType Directory -Force $OutputDirectory -ErrorAction Stop

$scale = !(($WidthSize -eq -1) -and ($HeightSize -eq -1)) ? "-vf scale=$($WidthSize):$($HeightSize)" : ""

$ffmpegCommand = "ffmpeg -i $($InputFile.FullName) -c:v libx265 $scale -preset:v slow -crf:v $Quality $OutputFile"

Invoke-Expression $ffmpegCommand