
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

    - **vigor:** Must be a character variable. For live trees, the vigor
      should be 0, 1, 2, or 3 (see “Vigor code table” section in
      “Background information for tree biomass estimations” below). For
      standing dead trees, the vigor should be 4 or 5.

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
  - **above_kg:** Above-ground tree biomass (including all wood, bark,
    branch, and foliage) in kilograms.
  - **leaf_kg:** Tree foliage biomass in kilograms.
  - Any additional (not required) columns in the input dataframe will
    remain in the output dataframe.
- by_plot:
  - **watershed:** As described above in external_data.
  - **year:** As described above in external_data.
  - **plot:** As described above in external_data.
  - **forest_type:** As described above in external_data.
  - **elev_m:** As described above in external_data.
  - **above_L_Mg_ha:** Above-ground live tree biomass (including all
    wood, bark, branch, and foliage) in megagrams per hectare.
  - **above_D_Mg_ha:** Above-ground dead tree biomass (including all
    wood, bark, branch) in megagrams per hectare.
  - **above_Mg_ha:** Above-ground (live + dead) tree biomass (including
    all wood, bark, branch, and foliage) in megagrams per hectare.
  - **leaf_kg:** Tree foliage biomass in megagrams per hectare.
- by_size:
  - All columns described above in by_plot.
  - **sample_class:** Either tree (DBH \>= 10 cm) or sapling (DBH \< 10
    cm).

### Demonstrations

**Results summarized by tree (using internal data):**

``` r
# call the HBEFBiomass() function
internal_demo_1 <- HBEFBiomass(data_type = "internal",
                               results = "by_tree")

head(internal_demo_1)
```

    ##   watershed year plot elev_m exp_factor species status vigor dbh_cm    ht_cm
    ## 1        W6 2002   41  759.6   136.6120    ABBA   Live     0    5.4 378.9236
    ## 2        W1 2016   48  694.5   132.9610    ABBA   Live     1    5.8 411.1843
    ## 3        W6 2002   33  763.2   144.3001    ABBA   Live     0    5.0 346.6629
    ## 4        W6 1965   23  763.8   100.0000    ABBA   Live     0    6.0 427.3147
    ## 5        W6 1965   33  763.2   100.0000    ABBA   Live     0    6.0 427.3147
    ## 6        W6 2007   48  753.5   124.7038    ABBA   Live     2    2.0 104.7075
    ##   above_kg   leaf_kg  bbd canopy elev_band       forest_type plot_area_ha
    ## 1 2.992717 1.4909684 <NA>   <NA>         H        spruce-fir     0.007320
    ## 2 3.679227 1.6530785 <NA>      S         H northern_hardwood     0.007521
    ## 3 2.394054 1.3362013 <NA>   <NA>         H        spruce-fir     0.006930
    ## 4 4.057055 1.7368242 <NA>   <NA>         H        spruce-fir     0.010000
    ## 5 4.057055 1.7368242 <NA>   <NA>         H        spruce-fir     0.010000
    ## 6 0.150719 0.4512415 <NA>   <NA>         H        spruce-fir     0.008019

**Notice in the output dataframe:**

- forest_type included

- extra columns

<br>

**Results summarized by plot (using external data):**

``` r
# investigate input external dataframe
#external_demo_data
```

``` r
# call the HBEFBiomass() function
#internal_demo_2 <- HBEFBiomass(data_type = "external",
#                               external_data = external_demo_data,
#                               results = "by_tree")

#internal_demo_2
```

**Notice in the output dataframe:**

- plots without trees (NONE)

- extra columns

<br>

**Results summarized by plot as well as by size (using internal data):**

``` r
# call the HBEFBiomass() function
internal_demo_3 <- HBEFBiomass(data_type = "internal",
                               results = "by_size")

head(internal_demo_3)
```

    ##   watershed year plot       forest_type elev_m sample_class above_L_Mg_ha
    ## 1        W6 2002   41        spruce-fir  759.6      sapling      10.42235
    ## 2        W6 2002   41        spruce-fir  759.6         tree     190.25159
    ## 3        W1 2016   48 northern_hardwood  694.5      sapling       9.73483
    ## 4        W1 2016   48 northern_hardwood  694.5         tree     130.16238
    ## 5        W6 2002   33        spruce-fir  763.2      sapling      25.27601
    ## 6        W6 2002   33        spruce-fir  763.2         tree      74.95180
    ##   above_D_Mg_ha above_Mg_ha leaf_Mg_ha
    ## 1       0.00000    10.42235    2.28644
    ## 2      37.22049   227.47208    8.36360
    ## 3       1.95676    11.69159    1.34804
    ## 4      24.81371   154.97609    6.08375
    ## 5       1.63404    26.91005    5.47035
    ## 6      28.33072   103.28252    3.29142

<br>

# General background information for tree biomass estimations

## Biomass workflow

1.  Predict tree heights

2.  Calculate above-ground live tree biomass

3.  Discount above-ground tree biomass for dead trees

## Species code tables

All hardwood and softwood species currently included/recognized in the
`HBEFBiomass()` function are listed in the tables below.

**Hardwoods**

| common name            | scientific name           | 4-letter code |
|:-----------------------|:--------------------------|:--------------|
| American beech         | Fagus grandifolia         | FAGR          |
| Bigtooth aspen         | Populus grandidentata     | POGR          |
| Black cherry           | Prunus serotina           | PRSE          |
| Black ash              | Fraxinus nigra            | FRNI          |
| Grey birch             | Betula populifolia        | BEPO          |
| Juneberry/serviceberry | Amelanchier spp.          | AMSP          |
| American mountain-ash  | Sorbus americana          | SOAM          |
| Mountain birch         | Betula cordifolia         | BECO          |
| Mountain maple         | Acer spicatum             | ACSP          |
| Paper birch            | Betula papyrifera         | BEPA          |
| Pin cherry             | Prunus pensylvanica       | PRPE          |
| Quaking aspen          | Populus tremuloides       | POTR          |
| Red maple              | Acer rubrum               | ACRU          |
| Sugar maple            | Acer saccharum            | ACSA          |
| Striped maple          | Acer pensylvanicum        | ACPE          |
| White ash              | Fraxinus americana        | FRAM          |
| Yellow birch           | Betula alleghaniensis     | BEAL          |
| Red elderberry         | Sambucus racemosa         | SAPU          |
| Chokecherry            | Prunus virginiana         | PRVI          |
| Alternateleaf dogwood  | Cornus alternalternifolia | COAL          |
| Basswood               | Tilia americana           | TIAM          |
| Red oak                | Quercus rubra             | QURU          |
| Eastern hophornbeam    | Ostrya virginiana         | OSVI          |
| Willow species         | Salix spp.                | SASP          |
| Cherry species         | Prunus spp.               | PRSP          |
| Unknown                | NA                        | UNKN          |

<br>

**Softwoods**

| common name     | scientific name  | 4-letter code |
|:----------------|:-----------------|:--------------|
| Balsam fir      | Abies balsamea   | ABBA          |
| Eastern hemlock | Tsuga canadensis | TSCA          |
| Red spruce      | Picea rubens     | PIRU          |
| White pine      | Pinus strobus    | PIST          |

*Note: Four-letter species codes are generally the first two letters of
the genus followed by the first two letters of the species.*

## Vigor code table

| vigor class | description                                                |
|:------------|:-----------------------------------------------------------|
| 0           | alive (Siccama code for live)                              |
| 1           | alive, healthy                                             |
| 2           | alive, sick                                                |
| 3           | alive, dying                                               |
| 4           | standing dead tree                                         |
| 5           | standing dead tree with at least 1/3 of top missing (stub) |
| 6           | dead and down (not recognized in R package)                |

*Note: There is some historical variance in vigor codes. These are
Cleavitt-Battles era codes.*
