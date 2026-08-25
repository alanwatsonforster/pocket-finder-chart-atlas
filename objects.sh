#!/bin/sh

sed "1d" objects-raw.csv |
sort -t, -k "1,1" -k "2,2n" -k "3,3n"  |
awk -F, '
function printobject() {
  if (y == "~")
    y = x;
  if (pa == "~")
    pa = 0;
  if (x > 2.5) {
    x = sprintf("%.0f", x);
    y = sprintf("%.0f", y);
  } else {
    x = sprintf("%.1f", x);
    y = sprintf("%.1f", y);
  }    
  printf("%s%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,\n", \
    id1, id2, alpha, delta, psa, x, y, pa, type, \
    cat_M, cat_C, cat_U, cat_NGC, cat_IC, cat_Mel, cat_Cr, name, \
    constellation, csa, osa, mag, references, hops, notes);
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
  csa = "";
  osa = "";
  constellation = "";
  mag = "";
  references = "";
  hops = "";
  notes = "";
}
BEGIN {
  print("# id, alpha, delta, psa, x, y, pa, type, cat_M, cat_C, cat_U, cat_NGC, cat_IC, cat_Mel, cat_Cr, name, constellation, csa, osa, mag, references, hops, notes,");
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
$6 != "" {
  alpha = $6;
}
$7 != "" {
  delta = $7;
}
$8 != "" {
  psa = $8;
}
$10 != "" {
  x = $10;
}
$11 != "" {
  y = $11;
}
$12 != "" {
  pa = $12;
}
$13 != "" {
  type = $13;
}
$14 != "" {
  cat_M = $14;
}
$15 != "" {
  cat_C = $15;
}
$16 != "" {
  cat_U = $16;
}
$17 != "" {
  cat_NGC = $17;
}
$18 != "" {
  cat_IC = $18;
}
$19 != "" {
  cat_Mel = $19;
}
$20 != "" {
  cat_Cr = $20;
}
$21 != "" {
  name = $21;
}
$22 != "" {
  constellation = $22;
}
$23 != "" {
  csa = $23;
}
$24 != "" {
  osa = $24;
}
$25 != "" {
  mag = $25;
}
$4 == "OSA" || $4 == "DSC:TMO" || $4 == "DSC:TCO" || $4 == "DSC:HT" || $4 == "DSC:TSD" || $4 == "DSC:SG" {
  references = sprintf("%s %s", references, $4)
}
$26 != "" {
  references = sprintf("%s %s", references, $26)
}
$27 != "" {
  hops = $27;
}
$28 != "" {
  notes = $28;
}
' >objects.csv
