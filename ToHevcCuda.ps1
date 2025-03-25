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
    $HeightSize = -1,
    [Parameter(Position=4)]
    [switch]
    $NativeDecode = $false
)

$outputDirectory = $InputFile.Directory.FullName + "\output"
$outputFile = $outputDirectory + "\" + $InputFile.BaseName + ".mp4"
$inputFullName = $InputFile.FullName

New-Item -ItemType Directory -Force $outputDirectory -ErrorAction Stop

$scaleType = $NativeDecode ? "scale" : "scale_cuda"

$scale = !(($WidthSize -eq -1) -and ($HeightSize -eq -1)) ? "-vf $scaleType=$($WidthSize):$($HeightSize)" : ""

$hwaccel = !$NativeDecode ? "-hwaccel cuda" : ""

$ffmpegCommand = "ffmpeg $hwaccel -hwaccel_output_format cuda -i `"$inputFullName`" -c:v hevc_nvenc $scale -preset:v p7 -tune:v uhq -rc:v vbr -cq:v $Quality -b:v 0 `"$outputFile`""

Invoke-Expression $ffmpegCommand