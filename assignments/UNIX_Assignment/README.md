# BCB546X_Unix_Assignment
## Inspecting the Data
* Inspect the top of the files `fang_et_al_genotypes.txt` and `snp_position.txt`

```
cut -f 1-6 file.txt | column -t | (head -n 5; tail -n 5)

```
* Word count gives files sizes and some general numbers
```

```

## Processing the Data
* Move maize data to one folder ( repeat with teosinte replacing maize terms)

```
touch maize_search.txt 
vi maize_search.txt
#Write and save ZMMIL, ZMMLR, ZMMMR
grep -f maize_search.txt fang_et_al_genotypes.txt >> maize_genotypes.txt
```
* Add the header back, required for sorting later on.
```
head -1 fang_et_al_genotypes.txt > header.txt
cat header.txt >> proper_maize_genotype.txt
cat maize_genotypes.txt >> proper_maize_genotype.txt
```
* Transpose
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
eyJoaXN0b3J5IjpbLTUyMTUzMjY0OSw4NzkxMDQ5NCwxMzEzMT
c1MjUxLDE3MTM5NTQ3NDQsLTE1Nzk3OTY0NjYsMjI3NTQzNDE4
LC0xMjAyOTQ0NzE4LC0xOTA2NTkwODc2LC0xMDQzNTk4NjM2LC
01MjYyMjYxNjAsNjQ1OTc5MzAxLC0xNzM5MDk0NDk3LDU1ODU2
MDk0MywxMDc3NzI4OTQ4LDEwMjE2MzEyNDQsMTAyMDg5NTc0My
wtODc5MjExNTA3LDE1NjcxMjA0MiwxODQ3Mjg3OTQ5LC02ODg2
NDIwMjldfQ==
-->