
# Hubbard Brook Forest Analytics

The `HubbardBrookForestAnalytics` package (HBFA) …

> :bulb: **Tip:** you can navigate this README file using the table of
> contents found in the upper right-hand corner.

## Installation instructions

To install the `HubbardBrookForestAnalytics` package from GitHub:

``` r
# install and load devtools
install.packages("devtools")
library(devtools)
```

``` r
# install and load HubbardBrookForestAnalytics
devtools::install_github('kearutherford/HubbardBrookForestAnalytics')
library(HubbardBrookForestAnalytics)
```

## Citation instructions

``` r
citation("HubbardBrookForestAnalytics")
```

    ## To cite package 'HubbardBrookForestAnalytics' in publications use:
    ## 
    ##   Kea Rutherford, John Battles (2024). _HubbardBrookForestAnalytics,
    ##   version 1.0.0_. Battles Lab: Forest Ecology and Ecosystem Dynamics,
    ##   University of California, Berkeley.
    ##   <https://github.com/kearutherford/HubbardBrookForestAnalytics>.
    ## 
    ## A BibTeX entry for LaTeX users is
    ## 
    ##   @Manual{,
    ##     title = {HubbardBrookForestAnalytics, version 1.0.0},
    ##     author = {{Kea Rutherford} and {John Battles}},
    ##     organization = {Battles Lab: Forest Ecology and Ecosystem Dynamics, University of California, Berkeley},
    ##     year = {2024},
    ##     url = {https://github.com/kearutherford/HubbardBrookForestAnalytics},
    ##   }

## Copyright notice

UC Berkeley’s Standard Copyright and Disclaimer Notice:

Copyright ©2024. The Regents of the University of California (Regents).
All Rights Reserved. Permission to use, copy, modify, and distribute
this software and its documentation for educational, research, and
not-for-profit purposes, without fee and without a signed licensing
agreement, is hereby granted, provided that the above copyright notice,
this paragraph and the following two paragraphs appear in all copies,
modifications, and distributions.

IN NO EVENT SHALL REGENTS BE LIABLE TO ANY PARTY FOR DIRECT, INDIRECT,
SPECIAL, INCIDENTAL, OR CONSEQUENTIAL DAMAGES, INCLUDING LOST PROFITS,
ARISING OUT OF THE USE OF THIS SOFTWARE AND ITS DOCUMENTATION, EVEN IF
REGENTS HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

REGENTS SPECIFICALLY DISCLAIMS ANY WARRANTIES, INCLUDING, BUT NOT
LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
PARTICULAR PURPOSE. THE SOFTWARE AND ACCOMPANYING DOCUMENTATION, IF ANY,
PROVIDED HEREUNDER IS PROVIDED “AS IS”. REGENTS HAS NO OBLIGATION TO
PROVIDE MAINTENANCE, SUPPORT, UPDATES, ENHANCEMENTS, OR MODIFICATIONS.

First published: June 1, 2024

# Tree biomass estimates

Description…

## :eight_spoked_asterisk: `HBEFBiomass( )`

### Inputs

1.  `data_type` Specifies whether the data of interest are internal to
    the package (meaning the clean, archived tree data from Hubbard
    Brook Experimental Forest for all watersheds, plots, and years) or
    external to the package (meaning data provided by the user). Must be
    set to “internal” or “external”. The default is set to “internal”.

2.  `external_data` Only required if data_type is set to “external.” A
    dataframe or tibble. Each row must be an observation of an
    individual tree. Must have at least these columns (column names are
    exact):

    - **watershed:** Must be a character variable. Describes the
      watershed in which the data were collected.

    - **year:** Must be a character variable. Describes the year in
      which the data were collected.

    - **plot:** Must be a character variable. Identifies the plot in
      which the individual tree was measured.

    - **forest_type:** This column is OPTIONAL. If included, must be a
      character variable. Identifies the type of forest where the plot
      is located (for Hubbard Brook Experimental Forest, forest type
      would be either northern hardwood or spruce-fir).

    - **elev_m:** Must be a numeric variable. Elevation in meters above
      sea level for the plot.

    - **exp_factor:** Must be a numeric variable. The expansion factor
      specifies the number of trees per hectare that a given plot tree
      represents.

    - **species:** Must be a character variable. Specifies the species
      of the individual tree. Must follow our four-letter species code
      naming conventions (see “Species code tables” in “Background
      information for tree biomass estimations” below).

    - **status:** Must be a character variable. Specifies whether the
      individual tree is alive (“Live”) or dead (“Dead”).

    - **vigor:** Must be a character variable. For standing dead trees,
      the vigor should be 0, 1, 2, or 3 (see “Vigor code table” section
      in “Background information for tree biomass estimations” below).
      For live trees, the vigor should be 4 or 5.

    - **dbh_cm:** Must be a numeric variable. Provides the diameter at
      breast height (DBH) of the individual tree in centimeters.

3.  `results` Specifies whether the results will be summarized by tree,
    by plot, or by plot as well as size class (size class has two
    categories: (1) tree, DBH \>= 10 cm and (2) sapling, DBH \< 10 cm).
    Must be set to either “by_tree”, “by_plot”, or “by_size”. The
    default is set to “by_plot”.

### Outputs

A dataframe. The columns of the output dataframe depend on the results
setting.

- by_tree:
  - All columns described above in external_data.
  - **above_kg:**
  - **leaf_kg:**
  - Any additional (not required) columns in the input dataframe will
    remain in the output dataframe.

### Demonstrations

<br>
