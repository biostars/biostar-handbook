#Bash Ubuntu on Windows 10: Install Package 1 (winstall_v1.sh)
#
#Requirements: 
#(Needed to append /etc/hosts file with /etc/hostname entry
#
#Windows 10 & Ubuntu linked Desktop/unix directory
#dos2unix for Notepad++ scripts
#
# Link windows and linux:
#ln -s '/mnt/c/Users/#username#/Desktop' ~/Desktop
#mkdir '/mnt/c/Users/#username#/Desktop/unix'
#ln -s 'mnt/c/Users/#username#/Desktop/unix' ~/unix
#
# bash Winstall_1.sh
#
# Abort in case errors.
set -uef -o pipefail
# Upgrade linux and basic set-up
sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install -y curl unzip build-essential ncurses-dev
sudo apt-get install -y byacc zlib1g-dev python-dev git cmake
sudo apt-get install -y python-pip libhtml-parser-perl libwww-perl
sudo apt-get install -y default-jdk ant
sudo apt-get install -y ack-grep
sudo apt-get install -y dos2unix
# Download a minimal profile
curl http://data.biostarhandbook.com/install/bashrc.txt >> ~/.bashrc
curl http://data.biostarhandbook.com/install/bash_profile.txt >> ~/.bashprofile
# Make bin and curl tools.
mkdir -p ~/unix/bin
cd ~/unix/bin
curl http://data.biostarhandbook.com/install/doctor.py > doctor.py
chmod +x ~/unix/bin/doctor.py
curl http://data.biostarhandbook.com/scripts/wonderdump.sh > wonderdump
chmod +x ~/unix/bin/wonderdump
curl -O https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
# Install miniconda to /root/unix/bin/miniconda3
bash Miniconda3-latest-Linux-x86_64.sh -bp /root/unix/bin/miniconda3
sed -i '$ a # Include miniconda3 in path' ~/.bashrc
sed -i "$ a export PATH=~/unix/bin/miniconda3/bin:$PATH" ~/.bashrc
source ~/.bashrc
#test conda installation by typing conda list
conda config --add channels r
conda config --add channels conda-forge
conda config --add channels bioconda
# conda install individual packages since command didn't work on windows:
#curl http://data.biostarhandbook.com/install/conda_windows.txt | xargs conda install -y
cd ~/unix/bin/miniconda3/bin/
conda install bwa -y
conda install htslib -y
conda install emboss -y
conda install bedtools -y
conda install samtools -y
conda install sra-tools -y
conda install fastqc -y
conda install trimmomatic -y
conda install seqtk -y
conda install bbmap -y
conda install datamash -y
conda install bcftools -y
conda install freebayes -y
conda install picard -y
conda install vt -y
conda install snpeff -y
conda install subread -y
conda install bioawk -y
conda install bamtools -y
#Bowtie installs to parent directory
conda install bowtie2 -y
conda install gatk -y
# Requires gatk registration. Download installer and move to ~/unix/bin/miniconda3/bin/
# gatk-register ~/unix/bin/miniconda3/bin/GenomeAnalysisTK-3.7.tar.bz2 
# If version check does not pass, use following:
# gatk-register ~/unix/bin/miniconda3/bin/GenomeAnalysisTK-3.7.tar.bz2 --noversioncheck
#
# Cutadapt conflict python 3.6, need 3.5
# conda install cutadapt -y
#
# perl-lwp-protocol-https fails to extract
# conda install perl-lwp-protocol-https -y 
#
# Entrez-direct fails due to perl dependency
# conda install entrez-direct -y
#
# Install hisat2 fail. hisat2 and python 3.6 in conflict.
# conda install hisat2 -y
#
# Install tophat fail. Require python 3.5
# conda install tophat -y