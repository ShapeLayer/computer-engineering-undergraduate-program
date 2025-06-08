# Run at host machine

$COPY_TO_SHARED = $true;
$SHARED_DIRECTORY = $env:USERPROFILE + "/vm_mnt/dist";

# Validate Directory is exists
# New-Item -ItemType Directory -Path $SHARED_DIRECTORY + "/gen" -Force
Remove-Item -Path "./generated" -Recurse -Force -ErrorAction SilentlyContinue
New-Item -ItemType Directory -Force -Path "./generated"

# Wireguard Host Configuration
cmd /c  "wg genkey > ./generated/wg0-host"
cmd /c  "wg pubkey < ./generated/wg0-host > ./generated/wg0-host.pub"

$host_configuration = Get-Content "./template/wg.host.template.conf" -Raw;
$host_configuration = $host_configuration -replace "##__IDENTIFIER__##", "1";
$host_configuration = $host_configuration -replace "##__PRIVATE_KEY__##", (Get-Content "./generated/wg0-host");
$host_public_key = Get-Content "./generated/wg0-host.pub";

$peer_config_template = Get-Content "./template/wg.peer.template.conf" -Raw;
foreach ($each in '3', '4', '5', '6') {
  # Network
  (Get-Content "./template/00-labnet.template.yaml") -replace "##__IDENTIFIER__##", "$each" |
    Set-Content -Path "./generated/00-labnet.${each}.yaml";

  # WireGuard
  cmd /c  "wg genkey > ./generated/wg0-${each}"
  cmd /c  "wg pubkey < ./generated/wg0-${each} > ./generated/wg0-${each}.pub"

  $each_config = $peer_config_template -replace "##__IDENTIFIER__##", "$each";
  $each_config = $each_config -replace "##__PRIVATE_KEY__##", (Get-Content "./generated/wg0-${each}") ;
  $each_config = $each_config -replace "##__HOST_PUBLIC_KEY__##", $host_public_key;
  $each_config = $each_config -replace "##__SELF_PRIVATE_KEY__##", (Get-Content "./generated/wg0-${each}");
  $each_config | Set-Content -Path "./generated/wg0-${each}.conf";

  $host_configuration += "[Peer]`n"
  $host_configuration += "PublicKey = $(Get-Content "./generated/wg0-${each}.pub")`n"
  $host_configuration += "AllowedIPs = 10.0.0.${each}/32`n"
}

$host_configuration | Set-Content -Path "./generated/wg0-host.conf";

if ($COPY_TO_SHARED) {
  Copy-Item -Path "./4-post-cloned.sh" -Destination "$SHARED_DIRECTORY" -Force;
  Copy-Item -Path "./generated" -Destination $SHARED_DIRECTORY -Recurse -Force;
  Write-Host "Configuration files copied to shared directory: $SHARED_DIRECTORY";
} else {
  Write-Host "Configuration files generated in the local directory: ./generated";
}
