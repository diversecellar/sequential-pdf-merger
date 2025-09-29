# ===================================================================================
# SEQUENTIAL PDF MERGER BUILD AUTOMATION SCRIPT
# ===================================================================================
# compile build\*.ps1 files into .\*.exe

# ===================================================================================
# SCRIPT LOCATION DETECTION AND DIRECTORY SETUP
# ===================================================================================
# Full path to the currently running script
$scriptFullPath = $MyInvocation.MyCommand.Definition

# Directory portion only
$scriptDirectory = Split-Path $scriptFullPath -Parent
cd $scriptDirectory
cd ..

# -------------------------------------------------------------------------
# BUILD DIRECTORY STRUCTURE CREATION
# -------------------------------------------------------------------------
$basepath = Join-Path -Path $PWD.Path -ChildPath "ps-base"
if (-not (Test-Path -Path $basepath -PathType Container)) {
    New-Item -Path $basepath -ItemType Directory
}

$uninstallpath = Join-Path -Path $PWD.Path -ChildPath "uninstall"
if (-not (Test-Path -Path $uninstallpath -PathType Container)) {
    New-Item -Path $uninstallpath -ItemType Directory
}

# ===================================================================================
# EXECUTABLE COMPILATION PROCESS
# ===================================================================================

# -------------------------------------------------------------------------
# UNINSTALLER EXECUTABLE CREATION
# -------------------------------------------------------------------------
$uninstallpspath = Join-Path -Path $basepath -ChildPath "uninstall.ps1"
$uninstallexepath = Join-Path -Path $uninstallpath -ChildPath "uninstall.exe"
ps2exe $uninstallpspath $uninstallexepath -Title "UN-Installer for sequential PDF merger" -Company "diversecellar" -Copyright "Copyright (c) 2025 diversecellar"

# -------------------------------------------------------------------------
# INSTALLER EXECUTABLE CREATION
# -------------------------------------------------------------------------
$installpspath = Join-Path -Path $basepath -ChildPath "installer.ps1"
$installexepath = Join-Path -Path $PWD.Path -ChildPath "installer.exe"
ps2exe $installpspath $installexepath -Title "Installer for sequential PDF merger" -Company "diversecellar" -Copyright "Copyright (c) 2025 diversecellar"

