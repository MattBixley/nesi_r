#!/bin/bash -e

#SBATCH --job-name    MySerialRJob
#SBATCH --time        01:00:00
#SBATCH --mem         512MB
#SBATCH --output      MySerialRJob.%j.out # Include the job ID in the names of
#SBATCH --error       MySerialRJob.%j.err # the output and error files

module purge
module load module load R-bundle-Bioconductor/3.15-gimkl-2022a-R-4.2.1

echo "Executing R ..."
srun Rscript test.r
echo "R finished."
