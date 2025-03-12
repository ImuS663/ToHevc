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

if (($WidthSize -eq -1) -and ($HeightSize -eq -1)) {
    ffmpeg -hwaccel cuda -hwaccel_output_format cuda -i $InputFile.FullName -c:v hevc_nvenc -preset:v p7 -tune:v uhq -rc:v vbr -cq:v $Quality -b:v 0 $OutputFile
} else {
    ffmpeg -hwaccel cuda -hwaccel_output_format cuda -i $InputFile.FullName -c:v hevc_nvenc -vf scale_cuda=$("{0}:{1}" -f $WidthSize, $HeightSize) -preset:v p7 -tune:v uhq -rc:v vbr -cq:v $Quality -b:v 0 $OutputFile
}