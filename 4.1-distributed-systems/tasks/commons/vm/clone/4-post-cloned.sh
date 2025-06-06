# Run at cloned VM

VM_ID="3" # Change this to the ID of the cloned VM

sudo mkdir /media/sf_dist
sudo mount -t vboxsf dist /media/sf_dist

sudo cp "/media/sf_dist/generated/00-labnet.$VM_ID.yaml" /etc/netplan/00-labnet.yaml
sudo netplan apply

sudo cp "/media/sf_dist/generated/wg0-$VM_ID.conf" /etc/wireguard/wg0.conf
sudo chmod 600 /etc/wireguard/wg0.conf

sudo systemctl enable --now wg-quick@wg0
