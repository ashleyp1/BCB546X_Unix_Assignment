# BCB546X_Unix_Assignment
* Inspect the files `fang_et_al_genotypes.txt` and `snp_position.txt`

```
cut -f 1-6 file.txt | column -t | (head -n 5; tail -n 5)

```

* Move maize data to one folder

```
touch maize_search.txt "Conta
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
eyJoaXN0b3J5IjpbLTIwNjU2MDU0MTYsLTE5NTg2MDIzNzAsMT
YyNjE2MDQxLC03NjA4Mjc5NTgsMzIwNDk1MzcyLDY2MzU3Mjky
MiwtMTcyNzk3MjkxNCw2MTIyNzA1LDkyNjY0MzY0M119
-->