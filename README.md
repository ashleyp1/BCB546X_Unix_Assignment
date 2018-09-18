# BCB546X_Unix_Assignment
* Inspect the files `fang_et_al_genotypes.txt` and `snp_position.txt`

```
cut -f 1-15 fang_et_al_genotypes.txt | column -t | head -n 5

cut -f 1-5 snp_position.txt | column -t | head -n 5
```

* Move maize data to one folder

```
grep ZMM?? fang_et_al_genotypes.txt >> maize_genotypes.txt
## Data 
<!--stackedit_data:
eyJoaXN0b3J5IjpbMTA5OTczMzU0LDY2MzU3MjkyMiwtMTcyNz
k3MjkxNCw2MTIyNzA1LDkyNjY0MzY0M119
-->