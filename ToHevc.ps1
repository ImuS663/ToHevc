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

$OutputDirectory = $InputFile.Directory.FullName + '\output'
$OutputFile = $OutputDirectory + '\' + $InputFile.BaseName + ".mp4"

New-Item -ItemType Directory -Force $OutputDirectory -ErrorAction Stop

if (($WidthSize -eq -1) -and ($HeightSize -eq -1)) {
    ffmpeg -i $InputFile.FullName -c:v libx256 -preset:v slow -crf:v $Quality $OutputFile
} else {
    ffmpeg -i $InputFile.FullName -c:v libx256 -vf scale=$('{0}:{1}' -f $WidthSize, $HeightSize) -preset:v slow -crf:v $Quality $OutputFile
}