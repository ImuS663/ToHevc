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
    $CopyDate = $false
)

$outputDirectory = Join-Path $InputFile.Directory.FullName "output"
$outputFile = Join-Path $outputDirectory "$($InputFile.BaseName).mp4"
$inputFullName = $InputFile.FullName

New-Item -ItemType Directory -Force $outputDirectory -ErrorAction Stop

$scale = ($WidthSize -ne -1 -or $HeightSize -ne -1) ? "-vf scale=$WidthSize`:$HeightSize" : ""

$ffmpegCommand = "ffmpeg -i `"$inputFullName`" -c:v libx265 $scale -preset:v slow -crf:v $Quality -c:a aac -movflags +faststart `"$outputFile`""

Invoke-Expression $ffmpegCommand

if ($CopyDate) {
    $outputItem = Get-ChildItem -LiteralPath $outputFile
    $outputItem.CreationTime = $InputFile.CreationTime
    $outputItem.LastWriteTime = $InputFile.LastWriteTime
    $outputItem.LastAccessTime = $InputFile.LastAccessTime
}