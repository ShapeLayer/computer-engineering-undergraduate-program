sudo apt-get update
sudo apt-get update --fix-missing
sudo apt-get upgrade -y

sudo apt-get install openssh-server -y

# Mount shared folders
sudo mkdir /media/sf_dist
sudo mount -t vboxsf dist /media/sf_dist

# Netplan
sudo cp netplan.yaml /etc/netplan/*.yaml
sudo netplan apply

# WireGuard
sudo apt-get install -y wireguard wireguard-tools
cd /etc/wireguard
# wg genkey | tee privatekey-wg0 | wg pubkey > publickey-wg0
# vi /etc/wireguard/wg0.conf
sudo cp /media/sf_dist/wg0.conf /etc/wireguard/wg0.conf
sudo chmod 600 /etc/wireguard/wg0.conf
echo "" >> /etc/sysctl.conf
echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf


mkdir -p /home/hduser/.ssh
ssh-keygen -t rsa -P '' -f /home/hduser/.ssh/id_rsa
cat /home/hduser/.ssh/id_rsa.pub >> /home/hduser/.ssh/authorized_keys
chmod 700 /home/hduser/.ssh
chmod 600 /home/hduser/.ssh/authorized_keys
