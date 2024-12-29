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
.\ToHevc.ps1 -InputFile <path_to_input_file> [-Quality <quality_value>]
```

- `InputFile`: Path to the input video file (mandatory).
- `Quality`: CRF (Constant Rate Factor) value for encoding quality (optional, default is 23).

### ToHevcCuda.ps1

This script converts video files to HEVC format using NVIDIA GPU encoding.

```powershell
.\ToHevcCuda.ps1 -InputFile <path_to_input_file> [-Quality <quality_value>]
```

- `InputFile`: Path to the input video file (mandatory).
- `Quality`: CQ (Constant Quality) value for encoding quality (optional, default is 23).

## Output

Both scripts will create an `output` directory in the current working directory and save the converted video file there.

## Examples

### Using ToHevc.ps1

```powershell
.\ToHevc.ps1 -InputFile "sample.mp4" -Quality 20
```

### Using ToHevcCuda.ps1

```powershell
.\ToHevcCuda.ps1 -InputFile "sample.mp4" -Quality 20
```

## License

This project is licensed under the MIT License.