# Add-MDContents.ps1

A PowerShell script that enhances Markdown files by generating a **Contents block** and inserting **bookmark anchors** before each header. Supports both **ATX headers** (`#`, `##`, `###`, …) and **Setext headers** (`====`, `----`).

---

## Features

- Detects all Markdown headers:
  - ATX (`#`, `##`, `###`, …)
  - Setext (`====` for H1, `----` for H2)
- Generates a clean **Contents** section with clickable links
- Inserts `<a name="..."></a>` anchors before each header
- Writes the processed output to a **unique file** in the system TEMP folder
- Preserves original formatting
- Does **not** modify the input file

---

## Usage

### Basic execution

```powershell
PS> .\Add-MDContents.ps1 .\MyDocument.md
