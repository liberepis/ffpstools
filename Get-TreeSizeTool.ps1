
#[CmdletBinding()]
param (
    [Parameter()]
    [string] $RootPath = '.'
)

Set-StrictMode -Version 3.0
$ErrorActionPreference = 'Stop'

function Get-TreeSize {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string] $Path
    )

    try {
        #here could occurr an I/O error
        $list = Get-ChildItem -Path $Path
    }
    catch {
        # there is an error: output 0 and quit the function
        return 0
    }

    $dim = 0
    foreach ($item in $list){
        # write-host $item
        if ($item -is [System.IO.DirectoryInfo]){
            $dim = $dim + (Get-TreeSize -Path $item.FullName)
        }
        elseif ($item -is [System.IO.FileInfo]){
            #is not a directory
            $dim = $dim + $item.Length
        }
        else {
            Write-Debug "Unknown $item.FullName"
        }
    }
    return $dim
}

$dim = Get-TreeSize -Path $RootPath

Write-Host $dim
