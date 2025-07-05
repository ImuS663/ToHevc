Param (
    [Parameter(Position = 0, Mandatory = $true)]
    [System.IO.FileInfo]
    $InputFile,
    [Parameter(Position = 1)]
    [int]
    $Quality = 28,
    [Parameter(Position = 2)]
    [int]
    $WidthSize = -1,
    [Parameter(Position = 3)]
    [int]
    $HeightSize = -1,
    [Parameter(Position = 4)]
    [switch]
    $NativeDecode = $false,
    [Parameter(Position = 5)]
    [switch]
    $CopyDate = $false,
    [Parameter(Position = 5)]
    [switch]
    $Lossless = $false
)

$outputDirectory = Join-Path $InputFile.Directory.FullName "output"
$outputFile = Join-Path $outputDirectory "$($InputFile.BaseName).mp4"
$inputFullName = $InputFile.FullName

New-Item -ItemType Directory -Force $outputDirectory -ErrorAction Stop

$scaleType = $NativeDecode ? "scale" : "scale_cuda"

$scale = ($WidthSize -ne -1 -or $HeightSize -ne -1) ? "-vf $scaleType=$WidthSize`:$HeightSize" : ""

$hwaccel = !$NativeDecode ? "-hwaccel cuda" : ""

$qualityStr = $Lossless ? "-tune:v lossless" : "-tune:v uhq -rc:v vbr -cq:v $Quality -b:v 0 -spatial-aq 1 -temporal-aq 1"

$ffmpegCommand = "ffmpeg $hwaccel -hwaccel_output_format cuda -i `"$inputFullName`" -c:v hevc_nvenc $scale -preset:v p7 $qualityStr -c:a aac -movflags +faststart `"$outputFile`""

Invoke-Expression $ffmpegCommand

if ($CopyDate) {
    $outputItem = Get-ChildItem -LiteralPath "$outputFile"
    $outputItem.CreationTime = $InputFile.CreationTime
    $outputItem.LastWriteTime = $InputFile.LastWriteTime
    $outputItem.LastAccessTime = $InputFile.LastAccessTime
}