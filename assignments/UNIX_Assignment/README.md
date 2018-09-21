# BCB546X_Unix_Assignment
## Inspecting the Data

* Inspect the file size
```
du -h snp_position.txt
84K snp_position.txt

du -h fang_et_al_genotypes.txt
11M fang_et_al_genotypes.txt
```
* Word count gives files sizes and some general numbers
```
wc snp_position.txt
 984 13198 82763 snp_position.txt
 
wc fang_et_al_genotypes.txt
 2783 2744038 11051939 fang_et_al_genotypes.txt
```
* Inspect the number of columns in files (useful for checking your work as you go)
```
awk -F "\t" '{print NF; exit}' snp_position.txt
15

awk -F "\t" '{print NF; exit}' fang_et_al_genotypes.txt
986
```
* Inspect the top and bottom of the files `fang_et_al_genotypes.txt` and `snp_position.txt`
```
cut -f 1-5 snp_position.txt | column -t | (head -n 3; tail -n 3)
SNP_ID          cdv_marker_id  Chromosome  Position   alt_pos
abph1.20        5976           2           27403404
abph1.22        5978           2           27403892
zen1.4          3521           unknown     unknown
zfl2.6          6463           2           12543294
zmm3.4          3527           9           16966348

cut -f 1-5 fang_et_al_genotypes.txt | column -t | (head -n 3; tail -n 3)
Sample_ID    JG_OTU                    Group  abph1.20  abph1.22
SL-15        T-aust-1                  TRIPS  ?/?       ?/?
SL-16        T-aust-2                  TRIPS  ?/?       ?/?
CU0201       Zmm-IL-WD_f               ZMMIL  C/C       A/A
S0215        Zmm-IL-Wf9                ZMMIL  G/G       A/A
CU0202       Zmm-IL-Yu796_NS_f         ZMMIL  C/C       A/A
```

## Processing the Data
* Move maize data to one folder
```
touch maize_search.txt 
vi maize_search.txt
#Write and save ZMMIL, ZMMLR, ZMMMR
grep -f maize_search.txt fang_et_al_genotypes.txt >> maize_genotypes.txt

touch teosinte_search.txt 
vi teosinte_search.txt
#Write and save ZMPBA, ZMPIL, ZMPJA
grep -f teosinte_search.txt fang_et_al_genotypes.txt >> teosinte_genotypes.txt
```
* Add the header back, required for sorting later on. Do for both maize and teosinte
```
head -1 fang_et_al_genotypes.txt > header.txt
cat header.txt >> proper_maize_genotype.txt
cat maize_genotypes.txt >> proper_maize_genotype.txt
```
* Transpose (both m
```
 awk -f transpose.awk proper_maize_genotypes.txt > trans_maize_geno.txt
```

* trim snp data
```
cut -f 1,3,4 snp_position.txt > trimmed_snp_position.txt
head -1 trimmed_snp_position.txt > snp_header.txt
```

* Sort `trimmed_snp_positions.txt` and `trans_maize_geno.txt`. Save as sorted versions.
```
sort -k1,1 file.txt > sorted_file.txt
```
* Join files. Join based on the first column of each file, with the resulting file delimited by tabs.
```
join -1 1 -2 1 -t $'\t' sorted_trimmed_snp.txt sorted_trans_maize.txt > joined_maize.txt
```
* make a file with all unknown and multiple position snps removed
```
grep -vE "unknown|multiple" joined_maize.txt > trimmed_maize.txt
```
* Make files of all with unknown position and all multiple position snps.
```
grep "unknown" joined_maize.txt > unknown_position_maize.txt
grep "multiple" joined_maize.txt > multiple_position_maize.txt
```

* Sort by chromosome
```
awk '{print >> $2"_chromo_maize.txt"}' trimmed_maize.txt
```
* Sort by position
```
sort -k3,3 -n 1_chromo_maize.txt > 1_chromo_incre_maize.txt
sort -k3,3 -n -r 1_chromo_maize.txt > 1_chromo_decre_maize.txt
```
* Replace ? with - for decreasing files
```
sed -i 's/?/-/g' 1_chromo_decre_maize.txt
```

* Add header, do for every final file
```
head -1 snp_position.txt > snp_header.txt
head -1 trans_maize_geno.txt > trans_maize_header.txt
join -1 1 -2 1 -t $'\t' --header snp_header.txt trans_maize_header.txt > joined_maize_header.txt
cat joined_maize_header.txt | cat - 1_chromo_incre_maize.txt > temp && mv temp 1_chromo_incre_maize.txt
```
* The final files were all placed in the folder `Final`, and all the intermediate files created along the way are under `Intermediate`

<!--stackedit_data:
eyJoaXN0b3J5IjpbLTEyMDExNjk3MzIsMTEyNzk0OTMwOCwxND
UxMjAwOTU3LC01MjE1MzI2NDksODc5MTA0OTQsMTMxMzE3NTI1
MSwxNzEzOTU0NzQ0LC0xNTc5Nzk2NDY2LDIyNzU0MzQxOCwtMT
IwMjk0NDcxOCwtMTkwNjU5MDg3NiwtMTA0MzU5ODYzNiwtNTI2
MjI2MTYwLDY0NTk3OTMwMSwtMTczOTA5NDQ5Nyw1NTg1NjA5ND
MsMTA3NzcyODk0OCwxMDIxNjMxMjQ0LDEwMjA4OTU3NDMsLTg3
OTIxMTUwN119
-->