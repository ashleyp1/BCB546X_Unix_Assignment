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

* trim snp data
```
cut -f 1,3,4 snp_position.txt >> trimmed_snp_position.txt
head -1 trimmed_snp_position.txt > snp_header.txt
```

* Sort `trimmed_snp_positions.txt`, `trans_teosinte_geno.txt`, and `trans_maize_geno.txt`. Save as sorted versions.
```
sort -k1,1 file.txt > sorted_file.txt
```
* Join files. Join based on the first column of each file, with the resulting file delimited by tabs. Repeat with teosinte files.
```
join -1 1 -2 1 -t $'\t' sorted_trimmed_snp.txt sorted_trans_maize.txt > joined_maize.txt
```
* make a file with all unknown and multiple position snps removed
```
awk '$3!/unknown/' joined_maize.txt > trimmed_uknown_maize.tzt
awk '$3!/unknown/' trimmed_unknown_maize.txt > trimmed_maize.txt
```

* Sort by chromosome
```
awk '{print >> $2"_chromo_maize.txt"}' trimmed_maize.txt
```
* Sort by position
```
sort -k3,3 -n 1_chromo_maize.txt > 1_chromo_increasing_maize.txt
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
join -1 1 -2 1 -t $'\t' --header snp_header.txt trans_maize_header.txt > joined_maize_header.txt\
awk -F "\t" '{print NF; exit}' joined_maize_header.txt
	output shows 1588
cut -f 1,3-1588 joined_maize_header.txt >> trimmed_maize_header.txt

```

<!--stackedit_data:
eyJoaXN0b3J5IjpbMTA3NzcyODk0OCwxMDIxNjMxMjQ0LDEwMj
A4OTU3NDMsLTg3OTIxMTUwNywxNTY3MTIwNDIsMTg0NzI4Nzk0
OSwtNjg4NjQyMDI5LDc3MzMwMDM1MiwtMjA4NDY0OTg4OCwtOT
EwMTM0MDAxLC0xOTI2NTQzNjg2LC0xOTQ1NjQwNDk3LDEzNDc2
MzI4OTIsMTAyMzYyNDUwOSwtNjYyNTY0NjQsMTIyMTc1OTc1OC
wxNDgxMjY5MTc2LC0xMjI5ODY0MDg4LC0xNzk3NjQzMTczLC04
ODI1MjQ5MDRdfQ==
-->