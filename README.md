# PSGzip

> Simple gzip module for PowerShell.

## Usage

### Compress-GzipArchive

```
NAME
    Compress-GzipArchive

SYNOPSIS
    Creates a compressed tar archive (tarball) from specified file.


SYNTAX
    Compress-GzipArchive [[-Destination] <String>] [-Path] <String> [<CommonParameters>]


DESCRIPTION
    Compress-GzipArchive creates a compressed archive (tarball) file from one file.


PARAMETERS
    -Destination <String>
        Specifies the path which archived file will be saved to.

        Required?                    false
        Position?                    2
        Default value
        Accept pipeline input?       false
        Accept wildcard characters?  false

    -Path <String>
        Specifies the path to the archive file.

        Required?                    true
        Position?                    1
        Default value
        Accept pipeline input?       false
        Accept wildcard characters?  false
```

### Expand-GzipArchive

```
NAME
    Expand-GzipArchive

SYNOPSIS
    Extracts file from a specified tar archive (tarball).


SYNTAX
    Expand-GzipArchive [[-Destination] <String>] [-Path] <String> [<CommonParameters>]


DESCRIPTION
    Expand-GzipArchive extracts file from a specified tarball archive file to a specified destination.


PARAMETERS
    -Destination <String>
        Specifies the path which archived file will be extracted to.

        Required?                    false
        Position?                    2
        Default value
        Accept pipeline input?       false
        Accept wildcard characters?  false

    -Path <String>
        Specifies the path to the archive file.

        Required?                    true
        Position?                    1
        Default value
        Accept pipeline input?       false
        Accept wildcard characters?  false
```

## License

This project is licensed under GNU Affero General Public License Version 3.