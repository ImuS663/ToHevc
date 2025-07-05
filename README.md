# ToHevc

## Overview

This project contains PowerShell scripts to convert video files to HEVC format using `ffmpeg`. There are two scripts provided:

1. `ToHevc.ps1`: Converts video files to HEVC format using CPU encoding.
2. `ToHevcCuda.ps1`: Converts video files to HEVC format using NVIDIA GPU encoding.

## Prerequisites

- [ffmpeg](https://ffmpeg.org/download.html) must be installed and added to your system's PATH.
- For `ToHevcCuda.ps1`, an NVIDIA GPU with CUDA support is required.

## Usage

### ToHevc.ps1

This script converts video files to HEVC format using CPU encoding.

```powershell
.\ToHevc.ps1 -InputFile <path_to_input_file> [-Quality <quality_value>] [-WidthSize <width_value>] [-HeightSize <height_value>] [-Lossless] [-CopyDate]
```

- `InputFile`: Path to the input video file (mandatory).
- `Quality`: CRF (Constant Rate Factor) value for encoding quality (optional, default is 28).
- `WidthSize`: Width of the output video (optional, default is -1 for original width).
- `HeightSize`: Height of the output video (optional, default is -1 for original height).
- `Lossless`: Enables lossless HEVC encoding (optional, default is false).
- `CopyDate`: Copies the original file's creation and modification dates to the output file (optional, default is false).

### ToHevcCuda.ps1

This script converts video files to HEVC format using NVIDIA GPU encoding.

```powershell
.\ToHevcCuda.ps1 -InputFile <path_to_input_file> [-Quality <quality_value>] [-WidthSize <width_value>] [-HeightSize <height_value>] [-NativeDecode] [-Lossless] [-CopyDate]
```

- `InputFile`: Path to the input video file (mandatory).
- `Quality`: CQ (Constant Quality) value for encoding quality (optional, default is 28).
- `WidthSize`: Width of the output video (optional, default is -1 for original width).
- `HeightSize`: Height of the output video (optional, default is -1 for original height).
- `NativeDecode`: Use native decoding for input video (optional, default is false).
- `Lossless`: Enables lossless HEVC encoding (optional, default is false).
- `CopyDate`: Copies the original file's creation and modification dates to the output file (optional, default is false).

## Output

Both scripts will create an `output` directory in the video directory and save the converted video file there.

## Examples

### Using ToHevc.ps1

```powershell
.\ToHevc.ps1 -InputFile "sample.mp4" -Quality 20 -WidthSize 1920 -HeightSize 1080
```

### Using ToHevcCuda.ps1

```powershell
.\ToHevcCuda.ps1 -InputFile "sample.mp4" -Quality 20 -WidthSize 1920 -HeightSize 1080
```

## License

This project is licensed under the MIT License.