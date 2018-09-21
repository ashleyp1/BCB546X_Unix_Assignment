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
cut -f 1,3,4 snp_position.txt > trimmed_snp_position.txt
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
sed -i 's/?/-/g' 1_chromo_decreasing_maize.txt
```

* add header, do for every final file
```
head -1 snp_position.txt > snp_header.txt
head -1 trans_maize_geno.txt > trans_maize_header.txt
join -1 1 -2 1 -t $'\t' --header snp_header.txt trans_maize_header.txt > joined_maize_header.txt
cat joined_maize_header.txt | cat - 1_chromo_incre_maize.txt > temp && mv temp 1_chromo_incre_maize.txt
```
* The final files were all placed in the folder `Final`, and all the intermediate files created along the way are under `Intermediate`

<!--stackedit_data:
eyJoaXN0b3J5IjpbLTEwNDM1OTg2MzYsLTUyNjIyNjE2MCw2ND
U5NzkzMDEsLTE3MzkwOTQ0OTcsNTU4NTYwOTQzLDEwNzc3Mjg5
NDgsMTAyMTYzMTI0NCwxMDIwODk1NzQzLC04NzkyMTE1MDcsMT
U2NzEyMDQyLDE4NDcyODc5NDksLTY4ODY0MjAyOSw3NzMzMDAz
NTIsLTIwODQ2NDk4ODgsLTkxMDEzNDAwMSwtMTkyNjU0MzY4Ni
wtMTk0NTY0MDQ5NywxMzQ3NjMyODkyLDEwMjM2MjQ1MDksLTY2
MjU2NDY0XX0=
-->