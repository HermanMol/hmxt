<#
.SYNOPSIS
    Create an ASCII-art banner from text using ascii_XX.txt character definition files.

.DESCRIPTION
    For each character in the input string:
      - Get its ASCII code (hex 20..7E)
      - Open file ascii_XX.txt (XX = 2-digit uppercase hex value)
      - Read all lines including lines containing only spaces
      - Concatenate corresponding lines into an output array

    Finally writes the banner to:
      ascii_banner_YYYYMMDD_HHMMSS.txt
      
    Created by H. Mol on 2026-11-17 using Copilot.

.EXAMPLE
    .\ascii_banner.ps1 "HELLO WORLD"

    Uses:
      ascii_48.txt
      ascii_45.txt
      ascii_4C.txt
      ascii_4F.txt
      ascii_20.txt
      ascii_57.txt
      ascii_52.txt
      ascii_44.txt
#>
<#
-- #desc: Create an ASCII-art banner from text using ascii_XX.txt character definition files.
#>
param(
    [Parameter(Mandatory = $true, Position = 0)]
    [string]$InputText
)

$MaxLines = 15
$HMXcmd = $env:HMXT_LOCAL

# Initialize banner line array
$LineArray = for ($i = 0; $i -lt $MaxLines; $i++) { "" }

foreach ($char in $InputText.ToCharArray())
{
    $asciiCode = [int][char]$char

    if ($asciiCode -lt 0x20 -or $asciiCode -gt 0x7E)
    {
        Write-Warning "Skipping unsupported character '$char' (ASCII $asciiCode)"
        $inputFile = "ascii_unknown.txt"
        # continue
    }
    else
    {
        $hexCode = "{0:X2}" -f $asciiCode
        $inputFile = "${HMXcmd}\data\banners\ascii_${hexCode}.txt"

        if (-not (Test-Path -LiteralPath $inputFile))
        {
            # throw "Character definition file not found: $inputFile"
            # No ascii_XX.txt file for this character, so display the unknown.
            Write-Warning "No $inputFile file for character '$char' (ASCII $asciiCode)"
            $inputFile = "ascii_unknown.txt"
        }
    }

    #
    # Read file preserving spaces and skip comment lines.
    # A comment line starts with '#' in column 1.
    #
    $charLines = Get-Content -LiteralPath $inputFile |
        Where-Object { $_ -notmatch '^#' }

    if ($charLines.Count -gt $MaxLines)
    {
        Write-Warning "$inputFile contains more than $MaxLines non-comment lines."
        continue
    }

    #
    # Pad missing lines with empty strings so every character
    # contributes exactly MaxLines entries.
    #
    while ($charLines.Count -lt $MaxLines)
    {
        $charLines += ""
    }

    #
    # Concatenate corresponding lines.
    #
    for ($lineNr = 0; $lineNr -lt $MaxLines; $lineNr++)
    {
        $LineArray[$lineNr] += $charLines[$lineNr]
    }
}

$timeStamp = Get-Date -Format "yyyyMMdd_HHmmssff"
$outputFile = "ascii_banner_${timeStamp}.txt"

#
# Write output exactly as stored, preserving spaces.
#
# Set-Content -LiteralPath $outputFile -Value $LineArray -Encoding ascii
# Write-Host "Banner written to: $outputFile"
#
# write to the console:
$LineArray | ForEach-Object {
    Write-Host $_
}