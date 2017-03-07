#Bash Ubuntu on Windows 10: Install Package 1 (Winstall_1.sh)
#
#Edited in Notepad++ on Windows 10.
#Run dos2unix before attempting to execute script.
#
#Requirements: 
#Windows 10 & Ubuntu linked Desktop/unix directory
#dos2unix for Notepad++ scripts
#
# sudo apt-get install -y dos2unix
#
# Link windows and linux:
#ln -s '/mnt/c/Users/#username#/Desktop' ~/Desktop
#mkdir '/mnt/c/Users/#username#/Desktop/unix'
#ln -s 'mnt/c/Users/#username#/Desktop/unix' ~/unix
#
#bash Winstall_1.sh
#
# Abort in case errors.
set -uef -o pipefail
#Upgrade linux and basic set-up
sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install -y curl unzip build-essential ncurses-dev
sudo apt-get install -y byacc zlib1g-dev python-dev git cmake
sudo apt-get install -y python-pip libhtml-parser-perl libwww-perl
sudo apt-get install -y default-jdk ant
sudo apt-get install -y ack-grep
# Make bin and navigate to curl tools.
mkdir -p ~/unix/bin
cd ~/unix/bin
curl http://data.biostarhandbook.com/install/doctor.py > doctor.py
chmod +x ~/unix/bin/doctor.py
curl http://data.biostarhandbook.com/scripts/wonderdump.sh > wonderdump
chmod +x ~/unix/bin/wonderdump
curl -O https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
# Install miniconda.
bash Miniconda3-latest-Linux-x86_64.sh
