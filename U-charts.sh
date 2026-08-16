#!/bin/sh

sort -t, -k "11,11n" objects.csv |
awk -F, '
NR > 1 && $11 != "" {
  alpha         = $2;
  delta         = $3;
  psa           = $4;
  x             = $5;
  y             = $6;
  pa            = $7;
  type          = $8;
  cat_M         = $9;
  cat_C         = $10;
  cat_U         = $11;
  cat_NGC       = $12;
  cat_IC        = $13;
  cat_Mel       = $14;
  cat_Cr        = $15;
  name          = $16;
  constellation = $17;
  csa           = $18;
  osa           = $19;
  mag           = $20;
  references    = $21;
  hops          = $22;
  notes         = $23;
  if (type == "GAL")
    type = "Gal";

  printf("\\chart{U%d}", cat_U);

  printf("{")
  join = ""
  if (cat_M != "") {
    printf("%sM%s", join, cat_M)
    join = " = ";
  }
  if (cat_C != "") {
    printf("%sC%s", join, cat_C)
    join = " = ";
  }
  if (cat_NGC != "") {
    printf("%sNGC %s", join, cat_NGC)
    join = " = ";
  } else if (cat_IC != "") {
    printf("%sIC %s", join, cat_IC)
    join = " = ";
  } else if (cat_Mel != "") {
    printf("%sMel %s", join, cat_Mel)
    join = " = ";
  } else if (cat_Cr != "") {
    printf("%sCr %s", join, cat_Cr)
    join = " = ";
  }
  if (name != "") {
    printf("%s%s", join, name)
  }
  printf("}")
  if (x == y || y == 0) {
    size = sprintf("\\arcmin{%s}", x)
  } else {
    size = sprintf("\\arcmin{%s} \\times \\arcmin{%s}", x, y)
  }
  if (x == y) {
    size = sprintf("\\arcmin{%s}", x)
  } else {
    size = sprintf("\\arcmin{%s} \\times \\arcmin{%s}", x, y)
  }
  printf("{\\chartdata{%04.1f}{%+03.0f}{%s}{%s}{%s}{%s}{%s}{%s}{%s}}", alpha / 15, delta, constellation, psa, osa, csa, type, mag, size)
  printf("{%s}{%s}{%s}\n", references, hops, notes)
}
' >U-charts.tex