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
* Transpose
```
 awk -f transpose.awk proper_teosinte_genotypes.txt > trans_teosinte_geno.txt
```

```
sort -t . -k1 transposed_teosinte_genotypes.txt > resorted_trans_teosinte_genotypes.txt
```

## Data 
<!--stackedit_data:
eyJoaXN0b3J5IjpbMTMyMzQzNzE0NSwtMTk1ODYwMjM3MCwxNj
I2MTYwNDEsLTc2MDgyNzk1OCwzMjA0OTUzNzIsNjYzNTcyOTIy
LC0xNzI3OTcyOTE0LDYxMjI3MDUsOTI2NjQzNjQzXX0=
-->