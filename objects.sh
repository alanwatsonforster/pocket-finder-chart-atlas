#!/bin/sh

sort -t, -k "1,1" -k "2,2n" -k "3,3n" objects-raw.csv |
awk -F, '
NR == 1 {
  next;
}
NR > 2 {
  if (id1 != $1 || id2 != $2)
    printf("%s%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s\n", \
      id1, id2, alpha, delta, x, y, pa, type, \
      cat_M, cat_C, cat_U, cat_NGC, cat_IC, cat_Mel, cat_Cr, name);
}
{
  id1 = $1;
  id2 = $2; 
}
$5 != "" {
  alpha = $6;
}
$6 != "" {
  delta = $6;
}
$7 != "" {
  x = $7;
}
$8 != "" {
  y = $8;
}
$9 != "" {
  pa = $9;
}
$10 != "" {
  type = $10;
}
$11 != "" {
  cat_M = $11;
}
$12 != "" {
  cat_C = $12;
}
$13 != "" {
  cat_U = $13;
}
$14 != "" {
  cat_NGC = $14;
}
$15 != "" {
  cat_IC = $15;
}
$16 != "" {
  cat_Mel = $16;
}
$17 != "" {
  cat_Cr = $17;
}
$18 != "" {
  name = $18;
}
' >objects.csv
