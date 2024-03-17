#!/usr/bin/sh
# Description: Script to install and setup packages on my VM's on proxmox 

# Install packages from package list 
apt-get install $(cat ../package_lists/debian_packages)
wait 

# create the media directory 
if [ ! -d /mnt/media ]; then
	mkdir /mnt/media
  echo -en "/mnt/media directory created"
else;
        echo -en "\nERROR: /mnt/media already exists";
fi
wait 

# add credentials file 
username="jellyfin";
password="youronyourown";

if [ -f /home/$USER/.smbcredentials ]; then
	echo -en "username=${username}\npassword=${password}" > /home/$USER/.smbcredentials
  echo -en "\n/home/$USER/.smbcredentials was created successfully\n"
else;
        echo -en "\nERROR: /home/$USER/.smbcredentials already exists or was not able to be created\n"
fi
wait 

# add FSTAB entry
ENTRY="//192.168.4.152/pool1 /mnt/media cifs uid=0,credentials=/home/$USER/.smbcredentials,iocharset=utf8,file_mode=0777,dir_mode=0777 0 0"

echo ${ENTRY} >> /etc/fstab

echo -en "\n Added entry to fstab\n"
wait

# Install protonvpn cli and input creds in prompted login 
git clone https://github.com/ProtonVPN/linux-cli-community ~/linux-cli
wait
cd ~/linux-cli
wait
pip3 install -e . --break-system-packages




