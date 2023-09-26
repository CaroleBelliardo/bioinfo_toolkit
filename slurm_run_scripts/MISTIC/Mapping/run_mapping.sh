sbatch mappingSRLR2_sb.sh /kwak/hub/25_cbelliardo/MISTIC/Salade_I/mapping_SR_LR_assembly  "hifi_assembly" "cleaned_run2_R1.fastq.gz" "cleaned_run2_R2.fastq.gz" "cleaned_run2__vs__hifiassembly" 
sbatch mappingSRLR2_sb.sh /kwak/hub/25_cbelliardo/MISTIC/Salade_I/mapping_SR_LR_assembly  "hifi_assembly" "cleaned_pool_R1.fastq.gz" "cleaned_pool_R2.fastq.gz" "cleaned_pool__vs__hifiassembly" 
sbatch mappingSRLR2_sb.sh /kwak/hub/25_cbelliardo/MISTIC/Salade_I/mapping_SR_LR_reads  "hifi_reads" "cleaned_pool_R1.fastq.gz" "cleaned_pool_R2.fastq.gz" "cleaned_pool__vs__hifireads" 
sbatch mappingSRLR2_sb.sh /kwak/hub/25_cbelliardo/MISTIC/Salade_I/mapping_SR_LR_reads  "hifi_reads" "cleaned_run2_R1.fastq.gz" "cleaned_run2_R2.fastq.gz" "cleaned_run2__vs__hifireads" 
