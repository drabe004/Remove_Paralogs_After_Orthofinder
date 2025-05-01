#!/bin/bash -l
#SBATCH --time=96:00:00
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 1
#SBATCH --mem=1g
#SBATCH --mail-type=ALL
#SBATCH --mail-user=your.email@institution.edu
#SBATCH --job-name=BlastAll2RefDB
#SBATCH -o blastp_%j_%a.out
#SBATCH -e blastp_%j_%a.err
#SBATCH --partition=your_partition
#SBATCH --account=your_account

# Navigate to working directory
cd /path/to/your/project

# Submit BLAST jobs in array batches
sbatch --array=2001-3000 --wait BLAST1_array.sh
sbatch --array=3001-4000 --wait BLAST1_array.sh
sbatch --array=4001-5000 --wait BLAST1_array.sh
sbatch --array=5001-6000 --wait BLAST1_array.sh
sbatch --array=6001-7000 --wait BLAST1_array.sh
sbatch --array=7001-8000 --wait BLAST1_array.sh
sbatch --array=8001-9000 --wait BLAST1_array.sh
sbatch --array=9001-10000 --wait BLAST1_array.sh
sbatch --array=10001-11000 --wait BLAST1_array.sh
sbatch --array=11001-12000 --wait BLAST1_array.sh
sbatch --array=12001-13000 --wait BLAST1_array.sh
sbatch --array=13001-14000 --wait BLAST1_array.sh
sbatch --array=14001-15000 --wait BLAST1_array.sh
sbatch --array=15001-16000 --wait BLAST1_array.sh
sbatch --array=16001-17000 --wait BLAST1_array.sh
sbatch --array=17001-18000 --wait BLAST1_array.sh
sbatch --array=18001-19000 --wait BLAST1_array.sh
sbatch --array=19001-20000 --wait BLAST1_array.sh
sbatch --array=20001-21000 --wait BLAST1_array.sh
sbatch --array=21001-22000 --wait BLAST1_array.sh
sbatch --array=22001-23000 --wait BLAST1_array.sh
sbatch --array=23001-24000 --wait BLAST1_array.sh
sbatch --array=24001-25000 --wait BLAST1_array.sh
sbatch --array=25001-26000 --wait BLAST1_array.sh
sbatch --array=26001-27000 --wait BLAST1_array.sh
sbatch --array=27001-28000 --wait BLAST1_array.sh
sbatch --array=28001-29000 --wait BLAST1_array.sh
sbatch --array=29001-30000 --wait BLAST1_array.sh
sbatch --array=30001-31000 --wait BLAST1_array.sh
sbatch --array=31001-32000 --wait BLAST1_array.sh
sbatch --array=32001-33000 --wait BLAST1_array.sh
sbatch --array=33001-34000 --wait BLAST1_array.sh
sbatch --array=34001-35000 --wait BLAST1_array.sh
sbatch --array=35001-36000 --wait BLAST1_array.sh
sbatch --array=36001-37000 --wait BLAST1_array.sh
sbatch --array=37001-38000 --wait BLAST1_array.sh
sbatch --array=38001-39000 --wait BLAST1_array.sh
sbatch --array=39001-40000 --wait BLAST1_array.sh
sbatch --array=40001-41000 --wait BLAST1_array.sh
sbatch --array=41001-42000 --wait BLAST1_array.sh
sbatch --array=42001-43000 --wait BLAST1_array.sh
sbatch --array=43001-44000 --wait BLAST1_array.sh
sbatch --array=44001-45000 --wait BLAST1_array.sh
sbatch --array=45001-46000 --wait BLAST1_array.sh
sbatch --array=46001-47000 --wait BLAST1_array.sh
sbatch --array=47001-48000 --wait BLAST1_array.sh
sbatch --array=48001-49000 --wait BLAST1_array.sh
sbatch --array=49001-50000 --wait BLAST1_array.sh
sbatch --array=50001-51000 --wait BLAST1_array.sh
sbatch --array=51001-52000 --wait BLAST1_array.sh
sbatch --array=52001-53000 --wait BLAST1_array.sh
sbatch --array=53001-54000 --wait BLAST1_array.sh
sbatch --array=54001-55000 --wait BLAST1_array.sh
sbatch --array=55001-56000 --wait BLAST1_array.sh
sbatch --array=56001-57000 --wait BLAST1_array.sh
sbatch --array=57001-58000 --wait BLAST1_array.sh
sbatch --array=58001-59000 --wait BLAST1_array.sh
sbatch --array=59001-60000 --wait BLAST1_array.sh
sbatch --array=60001-61000 --wait BLAST1_array.sh
sbatch --array=61001-62000 --wait BLAST1_array.sh
sbatch --array=62001-63000 --wait BLAST1_array.sh
sbatch --array=63001-64000 --wait BLAST1_array.sh
sbatch --array=64001-65000 --wait BLAST1_array.sh
sbatch --array=65001-66000 --wait BLAST1_array.sh
sbatch --array=66001-67000 --wait BLAST1_array.sh
sbatch --array=67001-68000 --wait BLAST1_array.sh
sbatch --array=68001-68267 --wait BLAST1_array.sh
