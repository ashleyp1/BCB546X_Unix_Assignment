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


header_maize <- maize_genotypes$Sample_ID
trans_maize <- as.data.frame(t(maize_genotypes[,-1]))
colnames(trans_maize) <- header_maize

header_teosinte <- teosinte_genotypes$Sample_ID
trans_teosinte <- as.data.frame(t(teosinte_genotypes[,-1]))
colnames(trans_teosinte) <- header_teosinte


trim_SNP = snps[c("SNP_ID","Chromosome","Position")]



merged_maize <- merge(trim_SNP, trans_maize, by.x = 1, by.y = 0)
merged_teosinte <- merge(trim_SNP, trans_teosinte, by.x = 1, by.y = 0)

unknown_maize <- filter(merged_maize, Chromosome == "unknown" | Position == "unknown")
multiple_maize <- filter(merged_maize, Chromosome == "multiple" | Position == "multiple")
chromo_1_maize <- filter(merged_maize, Chromosome == 1 & Position != "unknown" & Position != "multiple")
chromo_2_maize <- filter(merged_maize, Chromosome == 2 & Position != "unknown" & Position != "multiple")
chromo_3_maize <- filter(merged_maize, Chromosome == 3 & Position != "unknown" & Position != "multiple")
chromo_4_maize <- filter(merged_maize, Chromosome == 4 & Position != "unknown" & Position != "multiple")
chromo_5_maize <- filter(merged_maize, Chromosome == 5 & Position != "unknown" & Position != "multiple")
chromo_6_maize <- filter(merged_maize, Chromosome == 6 & Position != "unknown" & Position != "multiple")
chromo_7_maize <- filter(merged_maize, Chromosome == 7 & Position != "unknown" & Position != "multiple")
chromo_8_maize <- filter(merged_maize, Chromosome == 8 & Position != "unknown" & Position != "multiple")
chromo_9_maize <- filter(merged_maize, Chromosome == 9 & Position != "unknown" & Position != "multiple")
chromo_10_maize <- filter(merged_maize, Chromosome == 10 & Position != "unknown" & Position != "multiple")



unknown_teosinte <- filter(merged_teosinte, Chromosome == "unknown" | Position == "unknown")
multiple_teosinte <- filter(merged_teosinte, Chromosome == "multiple" | Position == "multiple")
chromo_1_teosinte <- filter(merged_teosinte, Chromosome == 1 & Position != "unknown" & Position != "multiple")
chromo_2_teosinte <- filter(merged_teosinte, Chromosome == 2 & Position != "unknown" & Position != "multiple")
chromo_3_teosinte <- filter(merged_teosinte, Chromosome == 3 & Position != "unknown" & Position != "multiple")
chromo_4_teosinte <- filter(merged_teosinte, Chromosome == 4 & Position != "unknown" & Position != "multiple")
chromo_5_teosinte <- filter(merged_teosinte, Chromosome == 5 & Position != "unknown" & Position != "multiple")
chromo_6_teosinte <- filter(merged_teosinte, Chromosome == 6 & Position != "unknown" & Position != "multiple")
chromo_7_teosinte <- filter(merged_teosinte, Chromosome == 7 & Position != "unknown" & Position != "multiple")
chromo_8_teosinte <- filter(merged_teosinte, Chromosome == 8 & Position != "unknown" & Position != "multiple")
chromo_9_teosinte <- filter(merged_teosinte, Chromosome == 9 & Position != "unknown" & Position != "multiple")
chromo_10_teosinte <- filter(merged_teosinte, Chromosome == 10 & Position != "unknown" & Position != "multiple")


write.table(unknown_maize, file = "unknown_maize.txt", append = F, sep = "\t")
write.table(multiple_maize, file = "multiple_maize.txt", append = F, sep = "\t")



