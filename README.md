# BCB546X_Unix_Assignment
* Inspect the files `fang_et_al_genotypes.txt` and `snp_position.txt`

```
cut -f 1-15 fang_et_al_genotypes.txt | column -t | head -n 5

cut -f 1-5 snp_position.txt | column -t | head -n 5
```

* Move maize data to one folder

```
grep ZMM?? fang_et_al_genotypes.txt >> maize_genotypes.txt
```

```
 awk -f transpose.awk teosinte_genotypes.txt > transposed_teosinte_genotypes.txt
```

```
sort -t . -k1 transposed_teosinte_genotypes.txt > resorted_trans_teosinte_genotypes.txt
```

## Data 
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTE5NTg2MDIzNzAsMTYyNjE2MDQxLC03Nj
A4Mjc5NTgsMzIwNDk1MzcyLDY2MzU3MjkyMiwtMTcyNzk3Mjkx
NCw2MTIyNzA1LDkyNjY0MzY0M119
-->