Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$Fenster = New-Object System.Windows.Forms.Form
$Fenster.Text = "Shps Computer-Info"
$Fenster.Width = 500
$Fenster.Height = 200
$Fenster.AutoSize = $True
$ShpFont =  "Segoe UI, 10"

function Write-Label ( [string]$OutText, $Y_Pos ) {
    $Label = New-Object System.Windows.Forms.Label
    $Label.Location = New-Object System.Drawing.Point(10, $Y_Pos)
    $Label.Text = $OutText
    $Label.AutoSize = $True
    $Label.Font = $ShpFont
    $Fenster.Controls.Add($Label)
}

Write-Label "Klicken Sie auf den Button unten, um die Daten des PCs zu laden!" 10
$Button = New-Object System.Windows.Forms.Button
$Button.Location = New-Object System.Drawing.Point(10, $Fenster.Height)
$Button.Text = "PC-Daten anzeigen"
$Button.AutoSize = $True
$Button.Font = $ShpFont

$Button.Add_Click({
    $Button.Enabled = $false
    $Computer_Daten = Get-ComputerInfo
    $ModelInf = "Modell: " + $Computer_Daten.CsManufacturer + " " + $Computer_Daten.CsModel
    $OSNam = "Betriebssystem: " + $Computer_Daten.OsName + " " + $Computer_Daten.OsVersion + " "+ $Computer_Daten.WindowsVersion
    $BiosInfo = "Bios: " + $Computer_Daten.BiosCaption + " " + $Computer_Daten.BiosFirmwareType
    
    Write-Label $ModelInf 50
    Write-Label $OsNam 80
    Write-Label $BiosInfo 110

    $Button.Enabled = $true
    $Fenster.Refresh()
    })
    
$Fenster.Controls.Add($Button)
$Fenster.ShowDialog()
