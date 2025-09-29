# ===================================================================================
# SEQUENTIAL PDF MERGER INSTALLER
# ===================================================================================
# installer.ps1

# ===================================================================================
# INITIAL SETUP AND DIRECTORY CONFIGURATION
# ===================================================================================
$homedir = $PWD.Path
$installtodir = "requirements"

# -------------------------------------------------------------------------
# PYTHON INSTALLATION DETECTION
# -------------------------------------------------------------------------
# -------------------------------------------------------------------------
# PYTHON INSTALLATION DETECTION
# -------------------------------------------------------------------------
$existingpyexe = (Get-Command -All python |
    Select-Object -ExpandProperty Definition)[0]
$existingpydir = Split-Path $existingpyexe
$existingpypath = Join-Path -Path $existingpydir -ChildPath "python.exe"

# -------------------------------------------------------------------------
# REQUIREMENTS DIRECTORY VALIDATION
# -------------------------------------------------------------------------
if (-not (Test-Path -Path $installtodir -PathType Container) -or -not (Test-Path -Path $existingpypath)) {
	Write-Host "PYEXE: installing requirements"
	New-Item -Path $installtodir -ItemType Directory
}
else {
	Write-Host "PYEXE: requirements already fulfilled"
}

# ===================================================================================
# PYTHON DOWNLOAD AND INSTALLATION CONFIGURATION
# ===================================================================================
cd $installtodir
$installtodir = $PWD.Path
$ver = "3.12.4"
$installTO = 60
$targetpyinstallexe = "python-" + "$ver" + "-amd64.exe"
$outpath = Join-Path -Path $installtodir -ChildPath $targetpyinstallexe 
$pydownload = "https://www.python.org/ftp/python/" + "$ver" + "/" + "$targetpyinstallexe"
Write-Host $outpath
$targetpydir = "python312"
$pypath = Join-Path -Path $installtodir -ChildPath $targetpydir 
# ===================================================================================
# PYTHON INSTALLATION BRANCH 1: NO EXISTING PYTHON FOUND
# ===================================================================================
if (-not (Test-Path -Path $existingpypath)) {
	
	# -------------------------------------------------------------------------
	# PYTHON DOWNLOAD AND INSTALLATION PROCESS
	# -------------------------------------------------------------------------
	if (-not (Test-Path -Path $pypath -PathType Container)) {
		Write-Host "PYEXE: python to be installed in $outpath"	
		While (-not (Test-Path $outpath)) {
			Write-Host "PYEXE: downloading fresh python"
				Invoke-WebRequest  -UseBasicParsing -Uri $pydownload -OutFile $outpath
		}
		#Start-Process -FilePath $outpath -ArgumentList "/quiet", "InstallAllUsers=0", "TargetDir=$pypath", "PrependPath=1", "Include_test=0" -Wait
		.\python-3.12.4-amd64.exe /quiet InstallAllUsers=0 TargetDir=$pypath PrependPath=1 Include_test=0
		Write-Host "PYEXE: installing python in $pypath standard timeout $installTO s"
		Start-Sleep -Seconds $installTO
	} 
	else {
		Write-Host "PYEXE: python already exists in $outpath"
	}
	
	# -------------------------------------------------------------------------
	# VIRTUAL ENVIRONMENT SETUP - NEW PYTHON INSTALLATION
	# -------------------------------------------------------------------------
	Write-Host "-----------------------------------------------------"
	Write-Host "PYENV: checking for Py3 envs $pyenv"
	cd ..
	$currentdir = $PWD.Path
	$targetpyenv = "py3"
	$pyenv = Join-Path -Path $currentdir -ChildPath $targetpyenv 
	if (-not (Test-Path -Path $pyenv -PathType Container)) {
		New-Item -Path $pyenv -ItemType Directory
		Write-Host "PYENV: py3 environment directory created $pyenv"
	} 
	else {
		Write-Host "PYENV: py3 environment directory already exists $pyenv"
	}
	$targetpyexe = "python.exe"
	$pythonexe = Join-Path -Path $pypath -ChildPath $targetpyexe
	While (-not (Test-Path $pythonexe)) {
		Write-Host "Waiting for file to appear..."
			Start-Sleep -Seconds 1
	}
	Write-Host "PYEXE: python.exe fully installed"
	Write-Host "-----------------------------------------------------"
	# need to create a python virtual environment to install all dependencies of the program
	& $pythonexe -m venv $pyenv
	cd $pyenv
	.\Scripts\Activate.ps1
}
else {
	# ===================================================================================
	# PYTHON INSTALLATION BRANCH 2: EXISTING PYTHON FOUND
	# ===================================================================================
	Write-Host "PYEXE: Windows python already exists"
	Write-Host "-----------------------------------------------------"
	
	# -------------------------------------------------------------------------
	# VIRTUAL ENVIRONMENT SETUP - EXISTING PYTHON INSTALLATION
	# -------------------------------------------------------------------------
	Write-Host "PYENV: checking for Py3 envs $pyenv"
	cd ..
	$currentdir = $PWD.Path
	$targetpyenv = "py3"
	$pyenv = Join-Path -Path $currentdir -ChildPath $targetpyenv 
	if (-not (Test-Path -Path $pyenv -PathType Container)) {
		New-Item -Path $pyenv -ItemType Directory
		Write-Host "PYENV: py3 environment directory created $pyenv"
	} 
	else {
		Write-Host "PYENV: py3 environment directory already exists $pyenv"
	}
	$pythonexe = $existingpyexe
	While (-not (Test-Path $pythonexe)) {
		Write-Host "Waiting for file to appear..."
			Start-Sleep -Seconds 1
	}
	Write-Host "PYEXE: python.exe fully installed"
	Write-Host "-----------------------------------------------------"
	# need to create a python virtual environment to install all dependencies of the program
	& $pythonexe -m venv $pyenv
	cd $pyenv
	.\Scripts\Activate.ps1
}

# ===================================================================================
# PYTHON PACKAGE MANAGEMENT - PIP UPGRADE AND DEPENDENCIES
# ===================================================================================
$targetpipexe = "Scripts/pip.exe"
$targetpyexe2 = "Scripts/python.exe"
$pythonexe2 = Join-Path -Path $pyenv -ChildPath $targetpyexe2
$pipexe = Join-Path -Path $pyenv -ChildPath $targetpipexe

# -------------------------------------------------------------------------
# PIP UPGRADE PROCESS WITH FALLBACK METHODS
# -------------------------------------------------------------------------
try {
	Write-Host "PYENV: python3-pip upgrading pip"
	& $pipexe "install" "--upgrade" "pip"
}
catch {
	Write-Host "PYENV: python3 -m upgrading pip"
	& $pythonexe2 -m pip install --upgrade pip
}
finally {
	Write-Host "PYENV: python3 -m upgrading pip"
	& $pythonexe2 -m pip install --upgrade pip
}

# -------------------------------------------------------------------------
# DEPENDENCY INSTALLATION FOR PDF PROCESSING
# -------------------------------------------------------------------------
Write-Host "PYENV: python3-pip installing requirements"
& $pipexe install setuptools pypdf pymupdf pyinstaller --no-warn-script-location
Write-Host "-----------------------------------------------------"

# ===================================================================================
# APPLICATION STRUCTURE SETUP
# ===================================================================================
cd ..
$currentdir = $PWD.Path
$programsrc = "src"
$programsrcpath = Join-Path -Path $currentdir -ChildPath $programsrc 

# -------------------------------------------------------------------------
# SOURCE DIRECTORY CREATION
# -------------------------------------------------------------------------
if (-not (Test-Path -Path $programsrcpath -PathType Container)) {
    New-Item -Path $programsrcpath -ItemType Directory
    Write-Host "PYENV: src-code directory created $programsrcpath"
} 
else {
    Write-Host "PYENV: src-code directory already exists $programsrcpath"
}

# ===================================================================================
# EXECUTABLE CREATION AND COMPILATION SETUP  
# ===================================================================================
$mainsrcfile = "main.py"
$maindestfile = "merger-app.py"
$mainsrcpath = Join-Path -Path $programsrcpath -ChildPath $mainsrcfile
$maindestpath = Join-Path -Path $currentdir -ChildPath $maindestfile
Write-Host "relocating main.py to the main app directory as $maindestfile"
#Copy-Item -Path $mainsrcpath -Destination $maindestpath

# -------------------------------------------------------------------------
# PYINSTALLER CONFIGURATION
# -------------------------------------------------------------------------
Write-Host "making $maindestfile an exe"
$targetpyinstallerexe = "Scripts/pyinstaller.exe"
$pyinstallerexe = Join-Path -Path $pyenv -ChildPath $targetpyinstallerexe
$mainexefile = "merger-app.ps1"
$mainexefile2 = "merger-app.exe"
$distmainexefile = "dist/merger-app.exe"
$distmainexepath = Join-Path -Path $currentdir -ChildPath $distmainexefile
$mainexepath = Join-Path -Path $currentdir -ChildPath $mainexefile
$mainexepath2 = Join-Path -Path $currentdir -ChildPath $mainexefile2
#While (-not (Test-Path $distmainexepath)) {
#	& $pyinstallerexe --onefile $maindestpath --hidden-import grp --hidden-import importlib --hidden-import os
#}
#Copy-Item -Path $distmainexepath -Destination $mainexepath

# -------------------------------------------------------------------------
# EXECUTABLE CLEANUP AND PREPARATION
# -------------------------------------------------------------------------
if (Test-Path -Path $mainexepath2) {
    Remove-Item -Path $mainexepath2 -Force
    Write-Host "PYEXE: $mainexepath2 removed successfully."
} else {
    Write-Host "PYEXE: $mainexepath2 does not exist."
}

# ===================================================================================
# POWERSHELL LAUNCHER SCRIPT CONTENT GENERATION
# ===================================================================================
New-Item -Path $mainexepath -ItemType File -Force
$contenttoadd = @'
$currentdir = $PWD.Path
$programsrc = "src"
$targetpyenv = "py3"
$pyenv = Join-Path -Path $currentdir -ChildPath $targetpyenv
$programsrcpath = Join-Path -Path $currentdir -ChildPath $programsrc
$mainsrcfile = "main.py"
$mainsrcpath = Join-Path -Path $programsrcpath -ChildPath $mainsrcfile 
$targetpyexe2 = "Scripts/python.exe"
$pythonexe2 = Join-Path -Path $pyenv -ChildPath $targetpyexe2
.\py3\Scripts\Activate.ps1
& $pythonexe2 $mainsrcpath
'@

# -------------------------------------------------------------------------
# SCRIPT CONTENT INJECTION AND EXECUTABLE COMPILATION
# -------------------------------------------------------------------------
Add-Content -Path $mainexepath -Value $contenttoadd
ps2exe $mainexepath $mainexepath2 -Title "sequential PDF merger" -Company "diversecellar" -Copyright "Copyright (c) 2025 diversecellar"
Add-MpPreference -ExclusionProcess $mainexepath2
Start-Sleep -Seconds 5

# -------------------------------------------------------------------------
# TEMPORARY FILE CLEANUP
# -------------------------------------------------------------------------
if (Test-Path -Path $mainexepath) {
    Remove-Item -Path $mainexepath -Force
    Write-Host "PYEXE: $mainexepath removed successfully."
} else {
    Write-Host "PYEXE: $mainexepath does not exist."
}