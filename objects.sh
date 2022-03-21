#!/bin/sh

sed "1d" objects-raw.csv |
sort -t, -k "1,1" -k "2,2n" -k "3,3n"  |
awk -F, '
function printobject() {
  if (y == "~")
    y = x;
  if (pa == "~")
    pa = 0;
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
BEGIN {
  print("# id, alpha, delta, psa, x, y, pa, type, cat_M, cat_C, cat_U, cat_NGC, cat_IC, cat_Mel, cat_Cr, name");
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
$9 != "" {
  x = $9;
}
$10 != "" {
  y = $10;
}
$11 != "" {
  pa = $11;
}
$12 != "" {
  type = $12;
}
$13 != "" {
  cat_M = $13;
}
$14 != "" {
  cat_C = $14;
}
$15 != "" {
  cat_U = $15;
}
$16 != "" {
  cat_NGC = $16;
}
$17 != "" {
  cat_IC = $17;
}
$18 != "" {
  cat_Mel = $18;
}
$19 != "" {
  cat_Cr = $19;
}
$20 != "" {
  name = $20;
}
' >objects.csv
