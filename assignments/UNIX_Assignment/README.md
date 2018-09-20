# BCB546X_Unix_Assignment
* Inspect the files `fang_et_al_genotypes.txt` and `snp_position.txt`

```
cut -f 1-6 file.txt | column -t | (head -n 5; tail -n 5)

```

* Move maize data to one folder ( repeat with teosinte replacing maize terms)

```
touch maize_search.txt 
#Write ZMMIL	ZMMLR	ZMMMR tab delimited
grep -f maize_search.txt fang_et_al_genotypes.txt >> maize_genotypes.txt
```
* Add the header back, required for sorting later on. Repeat for teosinte.
```
head -1 fang_et_al_genotypes.txt > header.txt
cat header.txt >> proper_maize_genotype.txt
cat maize_genotypes.txt >> proper_genotype.txt
```
* Transpose, again do it for both maize and teosinte
```
 awk -f transpose.awk proper_maize_genotypes.txt > trans_maize_geno.txt
```

* Sort `snp_positions.txt`, `trans_teosinte_geno.txt`, and `trans_maize_geno.txt`. Save as sorted versions.
```
sort -k1,1 file.txt > sorted_file.txt
```
* Join files. Join based on the first column of each file, with the resulting file delimited by tabs. Repeat with teosinte files.
```
join -1 1 -2 1 -t $'\t' sorted_snp.txt sorted_trans_maize.txt > joined_maize.txt
```

* trim out second column (mdv id)
```
awk -f "\t" '{print NF; exit}' joined_maize.txt
	output shows 1588
cut -f 1,3-1588 joined_maize.txt >> trimmed_joined_maize.txt
```


* Sort by chromosome
```
awk '{print >> $2"_chromo_maize.txt}' trimmed_joined_maize.txt
```
* Sort by position
```
sort -k3,3n 1_chromo_maize.txt > 1_chromo_increasing_maize.txt
sort -k3,3 -n -r 1_chromo_maize.txt > 1_chromo_decreasing_maize.txt
```
* Replace ? with - for decreasing files
```
sed -i 's/?/-/g' 1_chromo_decreasing_maize.txt
```

add header
* make chromosome_header.txt
* append to new files

## Data 
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTE4NTE1MzI4MjUsLTE5MjY1NDM2ODYsLT
E5NDU2NDA0OTcsMTM0NzYzMjg5MiwxMDIzNjI0NTA5LC02NjI1
NjQ2NCwxMjIxNzU5NzU4LDE0ODEyNjkxNzYsLTEyMjk4NjQwOD
gsLTE3OTc2NDMxNzMsLTg4MjUyNDkwNCwtMTgyMTA2NzgyNyw4
NTA1MDY5NzUsLTMwODUzMDI2MCwxMTQzNjYyNTYxLC0xOTU4Nj
AyMzcwLDE2MjYxNjA0MSwtNzYwODI3OTU4LDMyMDQ5NTM3Miw2
NjM1NzI5MjJdfQ==
-->