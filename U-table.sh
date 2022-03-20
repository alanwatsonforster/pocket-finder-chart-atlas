#!/bin/sh

sort -t, -k "11,11n" objects.csv |
awk -F, '
NR > 1 && $11 != "" && $11 != "9/10" {
  alpha = $2;
  delta = $3;
  psa = $4;
  x = $5;
  y = $6;
  pa = $7;
  type = $8;
  cat_M   = $9;
  cat_C   = $10;
  cat_U   = $11;
  cat_NGC = $12;
  cat_IC  = $13;
  cat_Mel = $14;
  cat_Cr  = $15;
  name    = $16;
  if (type == "GAL")
    type = "Gal";
  printf("U%-2d ", cat_U);
  printf("&$%04.1f$ $%+03.0f$", alpha / 15, delta)
  printf("&%s", psa);
  printf("&%-3s", type);
  printf("&");
  join = "";
  if (cat_M != "") {
    printf("M%s", cat_M)
    join = " = ";
  }
  if (cat_C != "") {
    printf("C%s", cat_C)
    join = " = ";
  }
  if (cat_NGC != "") {
    printf("%sNGC %s", join, cat_NGC)
    join = " = ";
  }
  if (cat_IC != "") {
    printf("%sIC %s", join, cat_IC)
    join = " = ";
  }
  if (cat_Mel != "") {
    printf("%sMel %s", join, cat_Mel)
    join = " = ";
  }
  if (cat_Cr != "" && cat_Mel == "") {
    printf("%sCr %s", join, cat_Cr)
    join = " = ";
  }
  if (name != "") {
    printf("%s%s", join, name)
    join = " = ";
  }
  printf("\\\\\n");
}
' >U-table.tex