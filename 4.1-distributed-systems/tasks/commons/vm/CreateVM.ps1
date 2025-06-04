<#  .\CreateVM.ps1 `
>>     -vm_name "test03" `
>>     -iso_path "D:\ubuntu-24.04.2-live-server-amd64.iso" `
>>     -vhd_path "C:\Users\ShapeLayer\VirtualBox VMs\test03\test03.vdi" `
>>     -shared_folder_hostpath "C:\Users\ShapeLayer\vm_mnt\test03" `
>>     -startup_script_path ".\post-install.sh"

 #>

param(
    [Parameter(Mandatory=$true)]
    [string]$vm_name,

    [Parameter(Mandatory=$true)]
    [string]$iso_path,

    [Parameter(Mandatory=$true)]
    [string]$vhd_path,

    [Parameter(Mandatory=$true)]
    [string]$shared_folder_hostpath,

    [Parameter(Mandatory=$true)]
    [string]$startup_script_path
)

# Configurable parameters
$memory = 2048   # MB
$cpus = 2
$os_type = 'Ubuntu_64'
$sata_ctl = "SATA Controller"
$ide_ctl = "IDE Controller"
$disk_size_mb = 20000
$shared_folder_name = "sf_shared"
$startup_script_name = [System.IO.Path]::GetFileName($startup_script_path)
$guest_shared_path = "/media/sf_shared/$startup_script_name"

$guest_user = "hduser"
$guest_password = "hduser"
$guest_full_name = "hduser"
$hostname = "$vm_name.localdomain"  # FQDN required!

# ========== CHECKS ==========

# Check if VM already exists
$existingVMs = VBoxManage list vms
if ($existingVMs -match "`"$vm_name`"") {
    Write-Error "A VirtualBox VM named '$vm_name' already exists. Aborting."
    exit 1
}

# Check if VHD already exists
if (Test-Path $vhd_path) {
    Write-Error "VHD file '$vhd_path' already exists. Aborting."
    exit 1
}

# Check if ISO exists
if (-not (Test-Path $iso_path)) {
    Write-Error "ISO file '$iso_path' does not exist. Aborting."
    exit 1
}

# Create shared folder host path if not exists
if (-not (Test-Path $shared_folder_hostpath)) {
    try {
        New-Item -Path $shared_folder_hostpath -ItemType Directory -Force | Out-Null
    } catch {
        Write-Error "Could not create directory '$shared_folder_hostpath'. Check permissions. Aborting."
        exit 1
    }
}

# Check if shared folder host path is a directory
if (-not (Test-Path $shared_folder_hostpath -PathType Container)) {
    Write-Error "'$shared_folder_hostpath' is not a directory. Aborting."
    exit 1
}

# Copy startup script to shared folder
try {
    Copy-Item -Path $startup_script_path -Destination $shared_folder_hostpath -Force
} catch {
    Write-Error "Could not copy '$startup_script_path' to '$shared_folder_hostpath'. Aborting."
    exit 1
}

# ========== CREATE VM ==========

VBoxManage createvm --name $vm_name --register

VBoxManage modifyvm $vm_name --memory $memory --cpus $cpus --ostype $os_type

VBoxManage createhd --filename "$vhd_path" --size $disk_size_mb

VBoxManage storagectl $vm_name --name $sata_ctl --add sata --controller IntelAhci
VBoxManage storagectl $vm_name --name $ide_ctl --add ide

VBoxManage storageattach $vm_name --storagectl $sata_ctl --port 0 --device 0 --type hdd --medium "$vhd_path"

VBoxManage storageattach $vm_name --storagectl $ide_ctl --port 0 --device 0 --type dvddrive --medium "$iso_path"

VBoxManage modifyvm $vm_name --boot1 dvd --boot2 disk --boot3 none --boot4 none

VBoxManage sharedfolder add $vm_name --name $shared_folder_name --hostpath $shared_folder_hostpath --automount

# Read the script as a single string
$scriptContent = Get-Content $startup_script_path -Raw

# Escape single quotes for bash -c
$scriptContentEscaped = $scriptContent -replace "'", "'\\''"

# Convert to one line with semicolons (and remove line breaks)
$scriptOneLine = $scriptContentEscaped -replace "(`r`n|`n|`r)", "; "

# Compose the full command, wrapping the script in **single quotes**
$post_install_command = "bash -c '$scriptOneLine'"

VBoxManage unattended install $vm_name `
    --iso="$iso_path" `
    --user="$guest_user" `
    --password="$guest_password" `
    --full-user-name="$guest_full_name" `
    --country="US" `
    --time-zone="UTC" `
    --hostname="$hostname" `
    --start-vm="gui" `
    --post-install-command="$post_install_command"

Write-Host "VirtualBox VM '$vm_name' is being installed automatically. The script $startup_script_name will run once after installation."
