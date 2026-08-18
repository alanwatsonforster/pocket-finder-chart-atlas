#!/bin/sh

sort -t, -k "10,10n" objects.csv |
awk -F, '
NR > 1 && $10 != "" {
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

  printf("\\chart{C%d}", cat_C);

  printf("{")
  join = "";
  if (cat_U != "") {
    printf("%sU%s", join, cat_U)
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
  if (x >= 180) {
    if (x == y || y == 0) {
      size = sprintf("\\degrees{%.1f}", x / 60)
    } else {
      size = sprintf("\\degrees{%.1f} \\times \\degrees{%.1f}", x / 60, y / 60)
    }
  } else {
    if (x == y || y == 0) {
      size = sprintf("\\arcmin{%s}", x)
    } else {
      size = sprintf("\\arcmin{%s} \\times \\arcmin{%s}", x, y)
    }
  }
  printf("{\\chartdata{%04.1f}{%+03.0f}{%s}{%s}{%s}{%s}{%s}{%s}{%s}}", alpha / 15, delta, constellation, psa, osa, csa, type, mag, size)
  printf("{%s}{%s}{%s}\n", references, hops, notes)
}
' >C-charts.tex