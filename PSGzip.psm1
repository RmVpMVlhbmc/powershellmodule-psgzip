function Compress-GzipArchive {
  <#
  .SYNOPSIS
  Creates a compressed tar archive (tarball) from specified file.
  .DESCRIPTION
  Compress-GzipArchive creates a compressed archive (tarball) file from one file.
  .PARAMETER Path
  Specifies the path to the archive file.
  .PARAMETER Destination
  Specifies the path which archived file will be saved to.
  #>
  [CmdletBinding()]
  param (
    [Parameter(Position = 1)][string]$Destination,
    [Parameter(Mandatory = $true, Position = 0)][string]$Path
  )

  $ErrorActionPreference = 'Stop'

  #Make sure streams will always get the absolute path
  $Path = [System.IO.Path]::GetFullPath($Path, $PWD.Path)
  if ($Destination.Length -ne 0) {
    $Destination = [System.IO.Path]::GetFullPath($Destination, $PWD.Path)
  } else {
    $Destination = $Path + '.gz'
  }

  $OrigStrm = [System.IO.FileStream]::new($Path, [System.IO.FileMode]::Open, [System.IO.FileAccess]::Read, [System.IO.FileShare]::None)
  $DestStrm = [System.IO.FileStream]::new($Destination, [System.IO.FileMode]::CreateNew, [System.IO.FileAccess]::Write, [System.IO.FileShare]::None)
  $CmprStrm = [System.IO.Compression.GZipStream]::new($DestStrm, [System.IO.Compression.CompressionMode]::Compress)

  $bfr = [System.Byte[]]::new(131072)
  do {
    $len = $OrigStrm.Read($bfr, 0, 131072)
    $CmprStrm.Write($bfr, 0, $len)
  } while ($len -gt 0)

  $OrigStrm.Close()
  #Compress stream need to be close before the stream that writes actual file.
  $CmprStrm.Close()
  $DestStrm.Close()
}

function Expand-GzipArchive {
  <#
  .SYNOPSIS
  Extracts file from a specified tar archive (tarball).
  .DESCRIPTION
  Expand-GzipArchive extracts file from a specified tarball archive file to a specified destination.
  .PARAMETER Path
  Specifies the path to the archive file.
  .PARAMETER Destination
  Specifies the path which archived file will be extracted to.
  #>
  [CmdletBinding()]
  param (
    [Parameter(Position = 1)][string]$Destination,
    [Parameter(Mandatory = $true, Position = 0)][string]$Path
  )

  $ErrorActionPreference = 'Stop'

  #Same as L20
  $Path = [System.IO.Path]::GetFullPath($Path, $PWD.Path)
  if ($Destination.Length -ne 0) {
    $Destination = [System.IO.Path]::GetFullPath($Destination, $PWD.Path)
  } else {
    $Destination = $Path.Replace('.gz', '')
  }

  $OrigStrm = [System.IO.FileStream]::new($Path, [System.IO.FileMode]::Open, [System.IO.FileAccess]::Read, [System.IO.FileShare]::Read)
  $ExpdStrm = [System.IO.Compression.GZipStream]::new($OrigStrm, [System.IO.Compression.CompressionMode]::Decompress)
  $DestStrm = [System.IO.FileStream]::new($Destination, [System.IO.FileMode]::Create, [System.IO.FileAccess]::Write, [System.IO.FileShare]::None)

  $bfr = [System.Byte[]]::new(131072)
  do {
    $len = $ExpdStrm.Read($bfr, 0, 131072)
    $DestStrm.Write($bfr, 0, $len)
  } while ($len -gt 0)

  $OrigStrm.Close()
  $DestStrm.Close()
  $ExpdStrm.Close()
}