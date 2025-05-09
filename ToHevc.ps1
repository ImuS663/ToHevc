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

$outputDirectory = $InputFile.Directory.FullName + "\output"
$outputFile = $outputDirectory + "\" + $InputFile.BaseName + ".mp4"
$inputFullName = $InputFile.FullName

New-Item -ItemType Directory -Force $outputDirectory -ErrorAction Stop

$scale = !(($WidthSize -eq -1) -and ($HeightSize -eq -1)) ? "-vf scale=$($WidthSize):$($HeightSize)" : ""

$ffmpegCommand = "ffmpeg -i `"$inputFullName`" -c:v libx265 $scale -preset:v slow -crf:v $Quality -c:a aac -movflags +faststart `"$outputFile`""

Invoke-Expression $ffmpegCommand

if ($CopyDate) {
    (Get-ChildItem $("$outputFile")).CreationTime = $InputFile.CreationTime
    (Get-ChildItem $("$outputFile")).LastWriteTime = $InputFile.LastWriteTime
    (Get-ChildItem $("$outputFile")).LastAccessTime = $InputFile.LastAccessTime
}