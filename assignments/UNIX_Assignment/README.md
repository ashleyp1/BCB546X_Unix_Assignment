# BCB546X_Unix_Assignment
* Inspect the files `fang_et_al_genotypes.txt` and `snp_position.txt`

```
cut -f 1-6 file.txt | column -t | (head -n 5; tail -n 5)

```

* Move maize data to one folder ( repeat with teosinte replacing maize terms"

```
touch maize_search.txt "Contains ZMMIL, ZMMLR, ZMMMR"
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
 awk -f transpose.awk proper_teosinte_genotypes.txt > trans_teosinte_geno.txt
```
* Sort `snp_positions.txt`, `trans_teosinte_geno.txt`, and `trans_maize_geno.txt`. Save as sorted versions.
```
sort -k1,1 file.txt > sorted_file.txt
```
* Join files. Join based on the first column of each file, with the resulting file delimited by tabs. Repeat with teosinte files.
```
join -1 1 -2 1 -t $'\t' sorted_snp.txt sorted_trans_maize.txt > joined_maize.txt
```

Sort by chromosome
```
awk '{print >> $3"_maize.txt}' joined

## Data 
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTE0NjAxMTI1MDMsMTE0MzY2MjU2MSwtMT
k1ODYwMjM3MCwxNjI2MTYwNDEsLTc2MDgyNzk1OCwzMjA0OTUz
NzIsNjYzNTcyOTIyLC0xNzI3OTcyOTE0LDYxMjI3MDUsOTI2Nj
QzNjQzXX0=
-->