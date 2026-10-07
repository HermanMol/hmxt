<#
.SYNOPSIS
Adds a Table of Contents block and bookmark anchors to a Markdown file.

.DESCRIPTION
This script processes a Markdown (.md) text file and performs three actions:

1. Detects all paragraph headers:
   - ATX headers (#, ##, ###, ...)
   - Setext headers (H1 using "====", H2 using "----")

2. Generates a "Table of Contents" block at the top of the output file.
   Each entry links to the corresponding header using a generated anchor.

3. Inserts a bookmark anchor (<a name="..."></a>) immediately before each header.

The final processed Markdown is written to a new, unique file in the system
TEMP directory. The script outputs the full path of the generated file.

Created on 2026-10-07 13:00:50 CET by Herman Mol using CoPilot.

.PARAMETER InputFile
The path to the Markdown file to process.

.EXAMPLE
PS> .\Add-MDToC.ps1 .\MyDocument.md

Processes MyDocument.md, adds a Table of Contents block, inserts anchors, and
writes the result to a new file in the TEMP folder. The script prints the full 
path of the generated file.

.EXAMPLE
PS> .\Add-MDToC.ps1 "C:\Docs\Notes.md"

Same as above, using an absolute path.

.NOTES
- The output file name is generated using a GUID to ensure uniqueness.
- The script does not modify the original file.
- Works with UTF-8 encoded Markdown files.

#>
param(
    [Parameter(Mandatory = $true)]
    [string]$InputFile
)

# --- Parameter Validation -----------------------------------------------------

# Ensure the file exists
if (-not (Test-Path -LiteralPath $InputFile)) {
    Write-Error "The specified file does not exist: $InputFile"
    exit 1
}

# Ensure the file is not a directory
if ((Get-Item -LiteralPath $InputFile).PSIsContainer) {
    Write-Error "The specified path is a directory, not a file: $InputFile"
    exit 1
}

# Ensure the file has content
if ((Get-Content -LiteralPath $InputFile -ErrorAction Stop).Count -eq 0) {
    Write-Error "The specified file is empty: $InputFile"
    exit 1
}

# Ensure the file is text-like (basic heuristic)
$extension = [IO.Path]::GetExtension($InputFile).ToLower()
if ($extension -notin @(".md", ".markdown", ".txt")) {
    Write-Warning "The file does not have a typical Markdown extension. Processing anyway..."
}

if (-not (Test-Path $InputFile)) {
    Write-Error "Input file not found: $InputFile"
    exit 1
}

# Read file
$raw = Get-Content -Path $InputFile -Raw -Encoding UTF8
$lines = $raw -split "`r?`n"

$headers = @()

$filename = [System.IO.Path]::GetFileNameWithoutExtension($InputFile)
$filename = (Get-Culture).TextInfo.ToTitleCase($filename.ToLower())

# Pass 1: detect ATX + Setext headers
for ($i = 0; $i -lt $lines.Count; $i++) {

    $line = $lines[$i]

    # ATX header: #, ##, ### ...
    if ($line -match '^(#+)\s+(.*)$') {
        $level = $matches[1].Length
        $title = $matches[2].Trim()
    }
    # Setext header: H1 (====) or H2 (----)
    elseif ($i -lt $lines.Count - 1 -and $lines[$i+1] -match '^(\=+|\-+)$') {
        $underline = $lines[$i+1]
        $title = $line.Trim()

        if ($underline -match '^\=+$') {
            $level = 1
        } elseif ($underline -match '^\-+$') {
            $level = 2
        } else {
            continue
        }
    }
    else {
        continue
    }

    # Create anchor
    $anchor = ($title.ToLower() -replace '[^a-z0-9]+','-').Trim('-')

    $headers += [PSCustomObject]@{
        Index  = $i
        Level  = $level
        Title  = $title
        Anchor = $anchor
        IsSetext = ($underline -ne $null)
    }
}

# Build Table of Contents block
$contents = @()
$contents += "# $filename"
$contents += "(Last modified: " + (Get-Item $InputFile).LastWriteTime.ToString("yyyy-MM-dd HH:mm:ss") + ")"
$contents += "## Table of Contents"
$contents += ""
foreach ($h in $headers) {
    $indent = " " * (($h.Level - 1) * 2)
    $contents += "$indent- [$($h.Title)](#$($h.Anchor))"
}
$contents += ""

# Pass 2: insert anchors before headers
$processed = @()
for ($i = 0; $i -lt $lines.Count; $i++) {

    $header = $headers | Where-Object { $_.Index -eq $i }

    if ($header) {
        $processed += "<a name=""$($header.Anchor)""></a>"
        $processed += $lines[$i]

        # Skip underline line for Setext headers
        if ($header.IsSetext) {
            $i++
            $processed += $lines[$i]
        }
    }
    else {
        $processed += $lines[$i]
    }
}

# Final output
$outFile = Join-Path $env:TEMP ("MD_" + [guid]::NewGuid().ToString() + ".md")
($contents + $processed) -join "`r`n" | Set-Content -Path $outFile -Encoding UTF8

Write-Output "Created file: $outFile"
