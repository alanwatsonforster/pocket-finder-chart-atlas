#!/bin/sh

sort -t, -k "9,9n" objects.csv |
awk -F, '
$9 != "" {
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
  printf("M%-3d ", cat_M);
  hh = int(alpha / 15);
  mm = int((alpha / 15 - hh) * 60)
  if (mm == 60) {
    hh += 1;
    mm = 0;
  }
  if (hh == 24) {
    hh = 0;
  }
  printf("&$%02.0f$ $%02.0f$ $%+05.1f$", hh, mm, delta)
  printf("&%s", psa);
  printf("&%-3s", type);
  printf("&");
  join = "";
  if (cat_U != "") {
    printf("U%s", cat_U)
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
  if (cat_Cr != "") {
    printf("%sCr %s", join, cat_Cr)
    join = " = ";
  }
  if (name != "") {
    printf("%s%s", join, name)
    join = " = ";
  }
  printf("\\\\\n");
}
' >M-table.tex