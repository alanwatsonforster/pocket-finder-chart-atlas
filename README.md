# Pocket Finder-Chart Atlas

This is an atlas of finder charts for the Messier, Caldwell, and Astronomical League Urban Observing Program objects. 

The charts have a field of 4 degrees at a scale of 13 mm/deg, show stars to magnitude 9.5, and represent of deep-sky objects following the current convention. Circles show fields with diameters of 1, 2, 3, and 4 degrees.

## Getting a Copy

The atlas is distributed freely, with the intention that you have your own copy printed and bound.

First, you needt to download it. You will need one of these files, depending on whether you want the inverted-image version (N up and E right) or the correct-image version (N up and E left):

- [inverted-image version](https://github.com/alanwatsonforster/pocket-finder-chart-atlas/raw/main/main.pdf)
- correct-image version (not yet)

Next, you need to print it. The atlas is designed to be printed double-sided on half-letter (140 × 216 mm) paper, but A5 (147 × 210 mm) is an excellent substitute. Some print shops don't stock half-letter paper, but it's easy to buy online. The atlas is produced in color, but at night all cats are indeed grey, so if you want to print in greyscale you're probably not losing much in practice.

Finally, you need to bind it. A staple in the corner might work for some, but I think the key to convenience at the telescope is a spiral binding that allows the atlas to fold back on itself, like the *Pocket Sky Atlas*. Clear plastic covers will help protect it.

## Code

The code to create the atlas is in three parts. 

- The input stellar catalog is produced by [stars.ipynb](stars.ipynb). It uses the Tycho-2 catalog as its base.

- The objects catalog [objects.csv](objects.csv) is produced by running [objects.sh](objects.sh), which processes [objects-raw.csv](objects-raw.csv). This contains data from multiple sources.

- The LaTex files for the individual charts are produced by [charts.ipynb](charts.ipynb).

- The atlas is finally produced by running LaTeX on main.tex.
