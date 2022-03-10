#!/bin/sh

sed "1d" objects-raw.csv |
sort -t, -k "1,1" -k "2,2n" -k "3,3n"  |
awk -F, '
function printobject() {
  printf("%s%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s\n", \
    id1, id2, alpha, delta, psa, x, y, pa, type, \
    cat_M, cat_C, cat_U, cat_NGC, cat_IC, cat_Mel, cat_Cr, name);
  if (alpha == "~") 
    print("# alpha missing");
  if (delta == "~")
    print("# delta missing");
  if (type == "")
    print("# type missing");
  if (x == "~" && type != "FC")
    print("# x missing");
  if (y == "~" && type == "GAL")
    print("# y missing");
  if (pa == "~" && type == "GAL")
    print("# pa missing");
  alpha = "~";
  delta = "~";
  x = "~";
  y = "~";
  pa = "~";
  type = "";
  cat_M = "";
  cat_C = "";
  cat_U = "";
  cat_NGC = "";
  cat_IC = "";
  cat_Mel = "";
  cat_Cr = "";
  name = "";
}
NR > 1 {
  if (id1 != $1 || id2 != $2) {
    printobject()
  }    
}
END {
  printobject();
}
{
  id1 = $1;
  id2 = $2; 
}
$5 != "" {
  alpha = $5;
}
$6 != "" {
  delta = $6;
}
$7 != "" {
  psa = $7;
}
$8 != "" {
  x = $8;
}
$9 != "" {
  y = $9;
}
$10 != "" {
  pa = $10;
}
$11 != "" {
  type = $11;
}
$12 != "" {
  cat_M = $12;
}
$13 != "" {
  cat_C = $13;
}
$14 != "" {
  cat_U = $14;
}
$15 != "" {
  cat_NGC = $15;
}
$16 != "" {
  cat_IC = $16;
}
$17 != "" {
  cat_Mel = $17;
}
$18 != "" {
  cat_Cr = $18;
}
$19 != "" {
  name = $19;
}
' >objects.csv
