#Bash Ubuntu on Windows 10: Install Package (winstall_v3.sh)
#
#Requirements: 
#Download registered GATK file and move to file named "unix" on desktop.
#
#Notes: 
#Check password requirements when executing the script.
#Bugs:
#Line 62 bash profile not updating 
#Lines 111-119 environment encountering error during script.
# 
# PART 1:
#
# Apphend hostname and link desktop.
echo "The following line is your hostname:";
cat /etc/hostname
echo "Enter your hostname exactly as it appears:"
read a;
echo "127.0.1.1 $a" >> /etc/hosts
echo "/etc/hosts file updated."
echo "Linking desktop. Here are available users:"
ls /mnt/c/Users/
echo "Enter your current user exactly as it appears above:"
read b;
ln -s "/mnt/c/Users/$b/Desktop" ~/desktop
ln -s "/mnt/c/Users/$b/Desktop/unix" ~/unix
#Exit upon error.
set -u -e -f -o pipefail
# Update linux and basic set-up.
cd ~
sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install -y curl unzip build-essential ncurses-dev
sudo apt-get install -y byacc zlib1g-dev python-dev git cmake
sudo apt-get install -y python-pip libhtml-parser-perl libwww-perl
sudo apt-get install -y default-jdk ant
sudo apt-get install -y ack-grep
sudo apt-get install -y dos2unix
# Download a minimal profile. 
curl http://data.biostarhandbook.com/install/bashrc.txt >> ~/.bashrc
echo "set background=dark" >> .vimrc
curl http://data.biostarhandbook.com/install/bash_profile.txt >> ~/.bashprofile
# Make bin and curl tools.
mkdir -p ~/src
mkdir -p ~/unix/ncbi/public/sra
mkdir -p ~/bin
cd ~/bin
curl http://data.biostarhandbook.com/install/doctor.py > doctor.py
chmod +x ~/bin/doctor.py
curl http://data.biostarhandbook.com/scripts/wonderdump.sh > wonderdump
chmod +x ~/bin/wonderdump
sed -i -e 's+~/ncbi+~/unix/ncbi+g' ~/bin/wonderdump
curl http://data.biostarhandbook.com/align/global-align.sh > ~/bin/global-align.sh
curl http://data.biostarhandbook.com/align/local-align.sh > ~/bin/local-align.sh
chmod +x ~/bin/global-align.sh
chmod +x ~/bin/local-align.sh
cd ~/
curl -O https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
# Install miniconda
bash Miniconda3-latest-Linux-x86_64.sh -bp /root/bin/miniconda3
echo "# Winstall bashrc update 1:" >> ~/.bashrc
echo "# Include miniconda3 in path." >> ~/.bashrc
echo "export PATH=~/bin:$PATH" >> ~/.bashrc
echo "export PATH=~/bin/miniconda3/bin:$PATH" >> ~/.bashrc
printf ".bashrc update complete"
#Need source ~/.bashrc to refresh for conda command. Not working.
source ~/.bashrc
printf "winstall part 1 complete\n";
# 
# PART 2:
#
#test conda installation by typing conda list
conda config --add channels r
conda config --add channels conda-forge
conda config --add channels bioconda
#curl http://data.biostarhandbook.com/install/conda_windows.txt | xargs conda install -y
cd ~/bin/miniconda3/bin/
conda install -y perl-lwp-simple
conda install -y perl-html-parser
conda install -y perl-lwp-protocol-https
conda install -y bwa
conda install -y htslib
conda install -y emboss
conda install -y bedtools
conda install -y samtools
conda install -y bamtools
conda install -y sra-tools
conda install -y fastqc
conda install -y trimmomatic
conda install -y seqtk
conda install -y bbmap
conda install -y datamash
conda install -y bcftools
conda install -y freebayes
conda install -y picard
conda install -y vt
conda install -y snpeff
conda install -y subread
conda install -y bioawk
conda install -y r 
conda install -y bioconductor-deseq 
conda install -y bioconductor-deseq2 
conda install -y bioconductor-edger 
conda install -y r-gplots
conda install -y bowtie2
conda install -y gatk 
# Requires gatk registration, download installer and move to ~/unix/ prior to executing script.
gatk_file="GenomeAnalysisTK-3.7.tar.bz2"
cp ~/unix/$gatk_file ~/bin/miniconda3/bin
gatk-register ~/bin/miniconda3/bin/$gatk_file --noversioncheck
# 
# PART 3:
#
# Create env for packages requiring python 2.7
conda create -y -n bioinfo python=2.7
# Activate environment to install packages.
source activate bioinfo
# Install packages.
conda install -y hisat2
conda install -y tophat
conda install -y cutadapt
# Deactivate environment.
source deactivate bioinfo
# Install Entrez-Direct from source.
cd ~/src
curl ftp://ftp.ncbi.nlm.nih.gov/entrez/entrezdirect/edirect.zip > ~/src/edirect.zip
unzip -o ~/src/edirect.zip -d ~/src
echo 'export PATH=~/src/edirect:$PATH' >> ~/.bashrc
source ~/.bashrc
printf "Full Installation Complete.\n";
