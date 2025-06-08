# Run at host machine

# Take Snapshot
VBoxManage snapshot "ubuntu-base" take clean

# Clone VMs
foreach ($each in '3', '4', '5', '6') {
  VBoxManage clonevm "ubuntu-base" --name "wg${each}" --register --snapshot clean --mode all;
}
