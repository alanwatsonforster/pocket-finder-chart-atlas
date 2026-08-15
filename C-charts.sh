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
  tcsa          = $18;
  if (type == "GAL")
    type = "Gal";

  printf("\\chart{C%d}", cat_C);

  printf("{")
  if (cat_U != "") {
    printf("\\\\U%s", cat_U)
  }
  if (cat_NGC != "") {
    printf("\\\\NGC %s", cat_NGC)
  } else if (cat_IC != "") {
    printf("\\\\IC %s", cat_IC)
  } else if (cat_Mel != "") {
    printf("\\\\Mel %s", cat_Mel)
  } else if (cat_Cr != "") {
    printf("\\\\Cr %s", cat_Cr)
  }
  if (name != "") {
    printf("\\\\%s", name)
  }
  printf("}")
  if (x == y) {
    size = sprintf("\\arcmin{%s}", x)
  } else {
    size = sprintf("\\arcmin{%s} \\times \\arcmin{%s}", x, y)
  }
  if (x == y) {
    size = sprintf("\\arcmin{%s}", x)
  } else {
    size = sprintf("\\arcmin{%s} \\times \\arcmin{%s}", x, y)
  }
  printf("{\\chartdata{%04.1f}{%+03.0f}{%s}{%s}{}{%s}{%s}{}{%s}}", alpha / 15, delta, constellation, psa, tcsa, type, size)
  printf("{}{}{}\n")
}
' >C-charts.tex