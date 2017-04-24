#!/bin/bash
#
# Installation script for automatically setting up reference genome files.
#
# This script has two arguments. The first one is genomebuild and the second one is the full path of a folder to which user want to save the downloade files. 
#

set -e

# trap ctrl-c and SIGHUP. Call ctrl_c() to handle
trap ctrl_c INT SIGHUP

function ctrl_c() {
        echo "Trapped CTRL-C or SIGHUP"
}

function checkfile {
	if [ ! -f "${1}" ] 
	then 
		echo "Error: ${1} could not be found."
		exit 5 
	fi
	
	if [ ! -s "${1}" ] 
	then 
		echo "Error: the size of ${1} is zero. The file was not successfully downloaded."
		exit 5 
	fi
	
}

function checkmulfiles {
	if ! ls "${1}"/${2} >/dev/null;
	then 
		echo "Error: ${1}/${2} could not be found."
		exit 5 
	fi
}

function downloadIGenomes {
(echo Step 4 iGenome; date) | sed 'N;s/\n/ /'
}

(echo Step 1 Start; date) | sed 'N;s/\n/ /'
echo $1
echo $2
echo $PWD

mountavfs

cd $2

#Create a folder
mkdir -p ./BRB_SeqTools_autosetup_reference_genome_files
mkdir -p ./BRB_SeqTools_autosetup_reference_genome_files/dbSNP_VCF
case $1 in
	"Ensembl_GRCh37") 
		cd ./BRB_SeqTools_autosetup_reference_genome_files
		cd ./dbSNP_VCF
		mkdir -p ./Ensembl_GRCh37
		cd ./Ensembl_GRCh37
		(echo Step 2 dbSNP_tbi; date) | sed 'N;s/\n/ /'
		(wget -c -O common_all_20160601.vcf.gz.tbi ftp://ftp.ncbi.nih.gov/snp/organisms/human_9606_b147_GRCh37p13/VCF/common_all_20160601.vcf.gz.tbi)
		(echo Step 3 dbSNP_vcf; date) | sed 'N;s/\n/ /'
		(wget -c -O common_all_20160601.vcf.gz ftp://ftp.ncbi.nih.gov/snp/organisms/human_9606_b147_GRCh37p13/VCF/common_all_20160601.vcf.gz)
		(checkfile common_all_20160601.vcf.gz) 
		(checkfile common_all_20160601.vcf.gz.tbi) 
		cd ../..
		(downloadIGenomes Ensembl GRCh37)
		rm ${2}/BRB_SeqTools_autosetup_reference_genome_files/Homo_sapiens_Ensembl_GRCh37.tar.gz
		;;
	"NCBI_GRCh38")
		cd ./BRB_SeqTools_autosetup_reference_genome_files
		cd ./dbSNP_VCF
		mkdir -p ./NCBI_GRCh38
		cd ./NCBI_GRCh38
		(echo Step 2 dbSNP_tbi; date) | sed 'N;s/\n/ /'
		(wget -c -O common_all_20160527.vcf.gz.tbi ftp://ftp.ncbi.nih.gov/snp/organisms/human_9606_b147_GRCh38p2/VCF/GATK/common_all_20160527.vcf.gz.tbi)
		(echo Step 3 dbSNP_vcf; date) | sed 'N;s/\n/ /'
		(wget -c -O common_all_20160527.vcf.gz ftp://ftp.ncbi.nih.gov/snp/organisms/human_9606_b147_GRCh38p2/VCF/GATK/common_all_20160527.vcf.gz)
		(checkfile common_all_20160527.vcf.gz) 
		(checkfile common_all_20160527.vcf.gz.tbi) 
		cd ../..
		(downloadIGenomes NCBI GRCh38)
		#rm ${2}/BRB_SeqTools_autosetup_reference_genome_files/Homo_sapiens_NCBI_GRCh38.tar.gz
		;;
	"UCSC_hg38")
		cd ./BRB_SeqTools_autosetup_reference_genome_files
		cd ./dbSNP_VCF
		mkdir -p ./UCSC_hg38
		cd ./UCSC_hg38
		(echo Step 2 dbSNP_tbi; date) | sed 'N;s/\n/ /'
		(wget -c -O common_all_20160527.vcf.gz.tbi ftp://ftp.ncbi.nih.gov/snp/organisms/human_9606_b147_GRCh38p2/VCF/GATK/common_all_20160527.vcf.gz.tbi)
		(echo Step 3 dbSNP_vcf; date) | sed 'N;s/\n/ /'
		(wget -c -O common_all_20160527.vcf.gz ftp://ftp.ncbi.nih.gov/snp/organisms/human_9606_b147_GRCh38p2/VCF/GATK/common_all_20160527.vcf.gz)
		(checkfile common_all_20160527.vcf.gz) 
		(checkfile common_all_20160527.vcf.gz.tbi)
		cd ../..
		(downloadIGenomes UCSC hg38)
		rm ${2}/BRB_SeqTools_autosetup_reference_genome_files/Homo_sapiens_UCSC_hg38.tar.gz
		;;
	"UCSC_hg19") 
		cd ./BRB_SeqTools_autosetup_reference_genome_files		
		cd ./dbSNP_VCF
		mkdir -p ./UCSC_hg19
		cd ./UCSC_hg19
		(echo Step 2 dbSNP_tbi; date) | sed 'N;s/\n/ /'
		(wget -c -O common_all_20160601.vcf.gz.tbi ftp://ftp.ncbi.nih.gov/snp/organisms/human_9606_b147_GRCh37p13/VCF/GATK/common_all_20160601.vcf.gz.tbi)
		(echo Step 3 dbSNP_vcf; date) | sed 'N;s/\n/ /'
		(wget -c -O common_all_20160601.vcf.gz ftp://ftp.ncbi.nih.gov/snp/organisms/human_9606_b147_GRCh37p13/VCF/GATK/common_all_20160601.vcf.gz)
		(checkfile common_all_20160601.vcf.gz) 
		(checkfile common_all_20160601.vcf.gz.tbi) 
		cd ../..
		(downloadIGenomes UCSC hg19)
		rm ${2}/BRB_SeqTools_autosetup_reference_genome_files/Homo_sapiens_UCSC_hg19.tar.gz
		;;
esac
(echo Step 5 Finish; date) | sed 'N;s/\n/ /'
