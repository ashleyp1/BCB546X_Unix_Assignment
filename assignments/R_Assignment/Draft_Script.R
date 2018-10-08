library(tidyverse)

genotypes <- read.delim("fang_et_al_genotypes.txt", header = T)
snps <- read.delim("snp_position.txt", header = T)



#maize ZMMIL ZMMLR ZMMMR
maize_genotypes <- genotypes[which (genotypes$Group == "ZMMIL" | genotypes$Group == "ZMMLR" |
                               genotypes$Group == "ZMMMR"),]

#Teosinte ZMPBA, ZMPIL, ZMPJA
teosinte_genotypes <- genotypes[which (genotypes$Group == "ZMPBA" |
                                         genotypes$Group == "ZMPIL" |
                                         genotypes$Group == "ZMPJA"),]

trans_maize <- t(maize_genotypes)
trans_teosinte <- t(teosinte_genotypes)

trim_SNP = snps[c("SNP_ID","Chromosome","Position")]

merged_maize <- merge(trim_SNP, trans_maize, by.x = 1, by.y = 0)
merged_teosinte <- merge(trim_SNP, trans_teosinte, by.x = 1, by.y = 0)

unknown_maize <- filter(merged_maize, Chromosome == "unknown" | Position == "unknown")

multiple_maize <- filter(merged_maize, Chromosome == "multiple" | Position == "multiple")






