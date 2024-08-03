#This copies the src files to your Factorio Mod folder
$host.ui.RawUI.WindowTitle = "Copying Source Files"

$version = (Get-Content .\src\info.json | ConvertFrom-Json).version
$factorioModPath = $env:appdata + "\Factorio\mods\"
$motdPath = $factorioModPath + "datapad_" + $version + "\"
$srcPath = (Invoke-Command -ScriptBlock { & cmd.exe /c cd }) + "\src\"

foreach($item in Get-ChildItem -Path $factorioModPath -Filter "datapad*")
{
    Remove-Item -LiteralPath $item.Fullname -Force -Recurse
}

Write-Host "Copying..."
Write-Host ("Copied " + (Copy-Item -Path $srcPath -Destination $motdPath -Recurse -force -passThru).count + " items")