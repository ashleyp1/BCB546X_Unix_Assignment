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
Add the header back
```
head -1 fang_et_al_genotypes.txt > header.txt
cat header.txt >> proper_maize_genotype.txt
cat maize_genotypes.txt >> proper_genotype.txt
```

```
 awk -f transpose.awk teosinte_genotypes.txt > transposed_teosinte_genotypes.txt
```

```
sort -t . -k1 transposed_teosinte_genotypes.txt > resorted_trans_teosinte_genotypes.txt
```

## Data 
<!--stackedit_data:
eyJoaXN0b3J5IjpbMTE1MDYxNjU5LC0xOTU4NjAyMzcwLDE2Mj
YxNjA0MSwtNzYwODI3OTU4LDMyMDQ5NTM3Miw2NjM1NzI5MjIs
LTE3Mjc5NzI5MTQsNjEyMjcwNSw5MjY2NDM2NDNdfQ==
-->