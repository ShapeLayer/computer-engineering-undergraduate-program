sudo apt-get update
sudo apt-get install openssh-server -y

mkdir -p /home/hduser/.ssh
ssh-keygen -t rsa -P '' -f /home/hduser/.ssh/id_rsa
cat /home/hduser/.ssh/id_rsa.pub >> /home/hduser/.ssh/authorized_keys
chmod 700 /home/hduser/.ssh
chmod 600 /home/hduser/.ssh/authorized_keys
cp -r /home/hduser/.ssh/id_rsa.pub /media/sf_shared/
