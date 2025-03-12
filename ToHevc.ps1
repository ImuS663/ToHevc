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

$outputDirectory = $InputFile.Directory.FullName + "\output"
$outputFile = $outputDirectory + "\" + $InputFile.BaseName + ".mp4"
$inputFullName = $InputFile.FullName

New-Item -ItemType Directory -Force $outputDirectory -ErrorAction Stop

$scale = !(($WidthSize -eq -1) -and ($HeightSize -eq -1)) ? "-vf scale=$($WidthSize):$($HeightSize)" : ""

$ffmpegCommand = "ffmpeg -i $inputFullName -c:v libx265 $scale -preset:v slow -crf:v $Quality $outputFile"

Invoke-Expression $ffmpegCommand