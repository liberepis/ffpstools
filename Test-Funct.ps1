param (
    [Parameter()]
    [string]
    $str = "a"
)

function FunctionName {
    [CmdletBinding()]
    param (
        [Parameter()]
        [string]
        $Name = "alfa"
    )

    return $Name    
}

$r = FunctionName -Name $str

$r

