# BCB546X_Unix_Assignment
## Inspecting the Data
* Inspect the files `fang_et_al_genotypes.txt` and `snp_position.txt`

```
cut -f 1-6 file.txt | column -t | (head -n 5; tail -n 5)

```
## Processing the Data
* Move maize data to one folder ( repeat with teosinte replacing maize terms)

```
touch maize_search.txt 
vi maize_search.txt
#Write and save ZMMIL, ZMMLR, ZMMMR
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
awk -F "\t" '{print NF; exit}' joined_maize.txt
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
```
head -1 snp_position.txt > snp_header.txt
head -1 trans_maize_geno.txt > trans_maize_header.txt
join -1 1 -2 1
```

<!--stackedit_data:
eyJoaXN0b3J5IjpbLTIyMDQzNDczMyw3NzMzMDAzNTIsLTIwOD
Q2NDk4ODgsLTkxMDEzNDAwMSwtMTkyNjU0MzY4NiwtMTk0NTY0
MDQ5NywxMzQ3NjMyODkyLDEwMjM2MjQ1MDksLTY2MjU2NDY0LD
EyMjE3NTk3NTgsMTQ4MTI2OTE3NiwtMTIyOTg2NDA4OCwtMTc5
NzY0MzE3MywtODgyNTI0OTA0LC0xODIxMDY3ODI3LDg1MDUwNj
k3NSwtMzA4NTMwMjYwLDExNDM2NjI1NjEsLTE5NTg2MDIzNzAs
MTYyNjE2MDQxXX0=
-->