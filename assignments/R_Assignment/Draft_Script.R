library(knitr)
library(tidyverse)
library(reshape2)
library(ggplot2)

genotypes <- read.table("fang_et_al_genotypes.txt", header = T,
                        sep = "\t", stringsAsFactors = F)
snps <- read.table("snp_position.txt", header = T,
                   sep = "\t", stringsAsFactors = F)



#maize ZMMIL ZMMLR ZMMMR
maize_genotypes <- genotypes[which (genotypes$Group == "ZMMIL" | genotypes$Group == "ZMMLR" |
                               genotypes$Group == "ZMMMR"),]

#Teosinte ZMPBA, ZMPIL, ZMPJA
teosinte_genotypes <- genotypes[which (genotypes$Group == "ZMPBA" |
                                         genotypes$Group == "ZMPIL" |
                                         genotypes$Group == "ZMPJA"),]

##make headers
header_maize <- maize_genotypes$Sample_ID
trans_maize <- as.data.frame(t(maize_genotypes[,-1]))
colnames(trans_maize) <- header_maize

header_teosinte <- teosinte_genotypes$Sample_ID
trans_teosinte <- as.data.frame(t(teosinte_genotypes[,-1]))
colnames(trans_teosinte) <- header_teosinte

##trim SNPs to 3 columns
trim_SNP = snps[c("SNP_ID","Chromosome","Position")]


##merge SNP and geno
merged_maize <- merge(trim_SNP, trans_maize, by.x = 1, by.y = 0)
merged_teosinte <- merge(trim_SNP, trans_teosinte, by.x = 1, by.y = 0)


#split by chromosome, sort into ascending and descending, write to files
maize_chromo_function <- function(data, chromo){
  data <- filter(data, Chromosome == chromo & Position != "unknown" &
                   Position != "multiple" & Chromosome != "multiple")
  data_ascen <- arrange(data, Position)
  data_descen <- arrange(data, desc(Position))
  title_ascen <- paste(chromo, "ascen_maize.txt", sep = "_")
  title_descen <- paste(chromo,"descen_maize.txt", sep = "_")
  data_descen[] <- lapply(data_descen, gsub, pattern = "?", replacement = "-", fixed = TRUE)
  ##write.table(data_descen, file = title_descen, append = F, sep = "\t")
  ##write.table(data_ascen, file = title_ascen, append = F, sep = "\t")
}

teosinte_chromo_function <- function(data, chromo){
  data <- filter(data, Chromosome == chromo & Position != "unknown" &
                   Position != "multiple" & Chromosome != "multiple")
  data_ascen <- arrange(data, Position)
  data_descen <- arrange(data, desc(Position))
  title_ascen <- paste(chromo, "ascen_teosinte.txt", sep = "_")
  title_descen <- paste(chromo,"descen_teosinte.txt", sep = "_")
  data_descen[] <- lapply(data_descen, gsub, pattern = "?", replacement = "-", fixed = TRUE)
  write.table(data_descen, file = title_descen, append = F, sep = "\t")
  write.table(data_ascen, file = title_ascen, append = F, sep = "\t")
}


## loop through all chromosomes
for (i in 1:10) {
  maize_chromo_function(merged_maize, i)
  teosinte_chromo_function(merged_teosinte, i)
}


##Graph Snps per chromosome
##Reshape
header_genotypes <- genotypes$Sample_ID
trans_genotypes <- as.data.frame(t(genotypes[,-1]))
colnames(trans_genotypes) <- header_genotypes
trim_SNP = snps[c("SNP_ID","Chromosome","Position")]

##merge SNP and geno
merged_data <- merge(trim_SNP, trans_genotypes, by.x = 1, by.y = 0)

##melt_data <- melt(merged_data, "Chromosome", "SNP_ID")
merged_data$Chromosome <- as.factor(merged_data$Chromosome)
levels(merged_data$Chromosome) <- c(1:10, "unknown", "multiple")
ggplot(merged_data) +geom_bar(aes(x=Chromosome, fill=Chromosome)) + 
  ggtitle("SNPs per Chromosome") + 
  labs(x="Chromosome",y="SNP Count")

ggplot(genotypes, aes(Group)) +
  geom_bar(aes(fill = Group))

##heterozygocity

melted_geno <- melt(genotypes, id = c("Sample_ID", "Group", "JG_OTU"))
melted_SNP <- melt(trim_SNP, id = c("SNP_ID", "Chromosome"))
colnames(melted_geno)[4:5] <- c("SNP_ID","SNP_Seq")
melted_data <- merge(melted_SNP, melted_geno, by.x = 1, by.y = 4)
melted_data$SNP_Type <- melted_data$SNP_Seq

melted_data[] <- lapply(melted_data, gsub, pattern = "?/?", replacement = "NA", fixed = TRUE)

melted_data$SNP_Type[melted_data$SNP_Type == "A/A" | melted_data$SNP_Type == "T/T" |
                       melted_data$SNP_Type == "G/G"| melted_data$SNP_Type == "C/C"] <- "Ho"
melted_data$SNP_Type[melted_data$SNP_Type != "Ho" & melted_data$SNP_Type != "NA"] <- "Ht"

sorted_het_data <- arrange(melted_data, Group, JG_OTU)

ggplot(sorted_het_data) + geom_bar(aes(x = Group, fill = SNP_Type), position = "fill") +
  ggtitle("Heterozygocity per Group") + labs(x = "Group", y = "Proportion of Types")


melted_data$Species <- as.character(melted_data$JG_OTU)


for (i in 0:9 ) {
  melted_data[10] <- lapply(melted_data[10], gsub, pattern = i , replacement = "", fixed = TRUE)
}


ggplot(melted_data) + geom_bar(aes(x = Species, fill = SNP_Type), position = "fill") +
  ggtitle("Heterozygocity per Species") + labs(x = "Species", y = "Proportion of Types")

## percent heterozygosity by SNP ID
##2782
SNP_Hetero <- melted_data %>% group_by(SNP_ID,SNP_Type) %>% summarize(n=n())
SNP_Hetero$Percent <- SNP_Hetero$n /2782

ggplot(melted_data) + geom_bar(aes(x = SNP_ID, fill = SNP_Type), position = "fill") +
  ggtitle("Heterozygocity per Species") + labs(x = "Species", y = "Proportion of Types")
