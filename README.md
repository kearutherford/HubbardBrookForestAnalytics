
# Hubbard Brook Forest Analytics

`HubbardBrookForestAnalytics` (HBFA) package overview coming soon …

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
    ##   version 2.0.0_. Battles Lab: Forest Ecology and Ecosystem Dynamics,
    ##   University of California, Berkeley.
    ##   <https://github.com/kearutherford/HubbardBrookForestAnalytics>.
    ## 
    ## A BibTeX entry for LaTeX users is
    ## 
    ##   @Manual{,
    ##     title = {HubbardBrookForestAnalytics, version 2.0.0},
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

First published: July 1, 2024

# Tree biomass estimates

The `HBEFBiomass` function uses localized equations to estimate
aboveground tree biomass. See “Background information for tree biomass
estimations” below for further details.

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

    - **hli:** Must be a numeric variable. Heat Load Index for the plot.
      Must be a value between -2.7 and 0.6.

    - **steep_deg:** Must be a numeric variable. Steepness (or slope) in
      degrees for the plot. Must be a value between 0 and 90.

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

*Note: For plots without trees, species should be set to NONE.
Watershed, year, plot, elev_m, and exp_factor columns should be filled
in as appropriate. And all tree-level variables (status, vigor, dbh_cm)
should be NA.*

### Outputs

A dataframe. The columns of the output dataframe depend on the results
setting.

- by_tree:
  - All columns described above in external_data.
  - **ht_cm:** Predicted height of the individual tree in centimeters.
  - **above_kg:** Aboveground tree biomass (including all wood, bark,
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
  - **above_L_Mg_ha:** Aboveground live tree biomass (including all
    wood, bark, branch, and foliage) in megagrams per hectare.
  - **above_D_Mg_ha:** Aboveground dead tree biomass (including all
    wood, bark, branch) in megagrams per hectare.
  - **above_Mg_ha:** Aboveground (live + dead) tree biomass (including
    all wood, bark, branch, and foliage) in megagrams per hectare.
  - **leaf_Mg_ha:** Tree foliage biomass in megagrams per hectare.
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

    ##       watershed year plot elev_m        hli steep_deg exp_factor species status
    ## 4341         W1 1996    1  738.2 -0.4165022  5.710593    16.0000    ABBA   Live
    ## 7622         W1 1996    1  738.2 -0.4165022  5.710593    16.0000    ABBA   Live
    ## 14040        W1 1996    1  738.2 -0.4165022  5.710593   133.3333    ACPE   Live
    ## 16074        W1 1996    1  738.2 -0.4165022  5.710593   133.3333    ACRU   Dead
    ## 16119        W1 1996    1  738.2 -0.4165022  5.710593   133.3333    ACRU   Live
    ## 36828        W1 1996    1  738.2 -0.4165022  5.710593    16.0000    ACSA   Live
    ##       vigor dbh_cm     ht_cm    above_kg    leaf_kg  bbd canopy elev_band
    ## 4341      0   15.1 1045.6302  51.5228324 8.50316916 <NA>   <NA>         H
    ## 7622      0   15.2 1050.6358  52.4011600 8.62257122 <NA>   <NA>         H
    ## 14040     0    2.1  375.9601   0.7164254 0.06835573 <NA>   <NA>         H
    ## 16074     4    2.9  504.9463   1.3932184 0.00000000 <NA>   <NA>         H
    ## 16119     3    2.7  481.7714   1.6182775 0.19173872 <NA>   <NA>         H
    ## 36828     0   15.8 1534.4349 115.6670692 2.91970226 <NA>   <NA>         H
    ##       forest_type plot_area_ha
    ## 4341   spruce-fir       0.0625
    ## 7622   spruce-fir       0.0625
    ## 14040  spruce-fir       0.0075
    ## 16074  spruce-fir       0.0075
    ## 16119  spruce-fir       0.0075
    ## 36828  spruce-fir       0.0625

*Notice in the output dataframe: The `bbd`, `canopy`, `elev_band`,
`forest_type`, and `plot_area_ha` columns, which are additional (not
required) columns in the internal dataframe, remain in the output
dataframe. Any additional columns in the internal or external dataframe
will remain in the output dataframe.*

<br>

**Results summarized by plot (using external data):**

``` r
# investigate input external dataframe
external_demo_data
```

    ##    watershed year plot elev_m  hli steep_deg exp_factor species status vigor
    ## 1         W5 1998    1    500 -0.5        15         50    BEPA   Live     1
    ## 2         W5 1998    1    500 -0.5        15         50    PIST   Live     2
    ## 3         W5 1998    1    500 -0.5        15         50    FAGR   Live     1
    ## 4         W5 1998    2    650 -0.7        20         50    ACPE   Dead     4
    ## 5         W5 1998    2    650 -0.7        20         50    SASP   Live     3
    ## 6         W5 1998    2    650 -0.7        20         50    BEAL   Dead     5
    ## 7         W5 2002    1    500 -0.5        15         50    BEPA   Live     1
    ## 8         W5 2002    1    500 -0.5        15         50    PIST   Dead     4
    ## 9         W5 2002    1    500 -0.5        15         50    FAGR   Live     1
    ## 10        W5 2002    2    650 -0.7        20         50    ACPE   Dead     5
    ## 11        W5 2002    2    650 -0.7        20         50    SASP   Dead     4
    ## 12        W5 2002    2    650 -0.7        20         50    BEAL   Dead     5
    ## 13        W6 1997    1    750 -1.0        30         50    FAGR   Dead     4
    ## 14        W6 1997    1    750 -1.0        30         50    FAGR   Dead     4
    ## 15        W6 1997    2    550 -0.2        10         50    NONE   <NA>  <NA>
    ##    dbh_cm cbh_m
    ## 1     3.4   0.3
    ## 2    14.5   1.4
    ## 3    10.8   1.8
    ## 4    20.2   2.2
    ## 5     5.5   1.5
    ## 6    13.6   1.6
    ## 7     3.4   1.4
    ## 8    14.5   0.5
    ## 9    10.8   0.8
    ## 10   20.2   0.2
    ## 11    5.5   0.5
    ## 12   13.6   3.6
    ## 13   12.5   1.5
    ## 14   11.9   1.9
    ## 15     NA    NA

*Notice in the input dataframe: The plot without trees (W6, 1997, plot
2) is represented by species = “NONE”. Watershed, year, plot, elev_m,
and exp_factor are filled in as appropriate. All tree-level variables
(i.e., status, vigor, dbh_cm) are NA.*

<br>

``` r
# call the HBEFBiomass() function
internal_demo_2 <- HBEFBiomass(data_type = "external",
                               external_data = external_demo_data,
                               results = "by_plot")

internal_demo_2
```

    ##   watershed year plot elev_m above_L_Mg_ha above_D_Mg_ha above_Mg_ha leaf_Mg_ha
    ## 1        W5 1998    1    500       5.40888       0.00000     5.40888    0.11372
    ## 2        W5 1998    2    650       0.25206       8.15022     8.40228    0.01574
    ## 3        W5 2002    1    500       2.46437       2.14448     4.60885    0.07316
    ## 4        W5 2002    2    650       0.00000       7.01139     7.01139    0.00000
    ## 5        W6 1997    1    750       0.00000       4.47166     4.47166    0.00000
    ## 6        W6 1997    2    550       0.00000       0.00000     0.00000    0.00000

*Notice in the output dataframe: The plot without trees (W6, 1997, plot
2) has 0 Mg/ha in all biomass columns.*

<br>

**Results summarized by plot as well as by size (using internal data):**

``` r
# call the HBEFBiomass() function
internal_demo_3 <- HBEFBiomass(data_type = "internal",
                               results = "by_size")

head(internal_demo_3)
```

    ##   watershed year plot       forest_type elev_m sample_class above_L_Mg_ha
    ## 1        W1 1996    1        spruce-fir  738.2      sapling       0.38201
    ## 2        W1 1996    1        spruce-fir  738.2         tree     110.26162
    ## 3        W1 1996   10 northern_hardwood  738.9      sapling      11.03994
    ## 4        W1 1996   10 northern_hardwood  738.9         tree     154.74468
    ## 5        W1 1996  100 northern_hardwood  622.7      sapling       5.72583
    ## 6        W1 1996  100 northern_hardwood  622.7         tree     145.68833
    ##   above_D_Mg_ha above_Mg_ha leaf_Mg_ha
    ## 1       0.18576     0.56777    0.03616
    ## 2      47.10919   157.37081    3.07775
    ## 3       0.20946    11.24940    0.51896
    ## 4       4.23677   158.98145    3.66743
    ## 5       0.00000     5.72583    0.24460
    ## 6      22.02775   167.71608    2.35344

*Notice in the output dataframe: Since forest_type is included in the
internal data, it is carried through into the summarized output data.
The same idea applies to external data - if forest_type is included in
the input dataframe, it will be carried through into the summarized
output data.*

<br>

# Background information for tree biomass estimations

## Biomass workflow

**Step 1: Predict tree heights**

We fit new equations to predict height based on species, DBH, elevation,
Heat Load Index, and steepness. These equations were fit using
valley-wide height samples.

<br>

**Step 2. Calculate aboveground live tree biomass**

We fit new equations to predict total aboveground tree biomass
(including all wood, bark, branch, and foliage). We fit separate
equations to predict tree foliage biomass on its own.

<br>

**Step 3. Discount aboveground tree biomass for dead trees**

Standing dead trees lose mass in two ways: (1) they degrade with pieces
falling and transferring to other biomass pools (e.g., stem tops break
and become coarse woody debris) and (2) the remaining structures decay
as measured by their density (i.e., mass/volume). We accounted for the
decay and degrade of standing dead trees by discounting the live biomass
estimates based on vigor. For trees/saplings with a vigor code of 4, the
discount rate is 0.7283 (aboveground live tree biomass x 0.7283). For
trees/saplings with a vigor code of 5, the discount rate is 0.5683
(aboveground live tree biomass x 0.5683).

## Species code tables

All hardwood and softwood species currently included/recognized in the
`HBEFBiomass()` function are listed in the tables below.

**Hardwoods**

| common name            | scientific name           | 4-letter code |
|:-----------------------|:--------------------------|:--------------|
| Striped maple          | Acer pensylvanicum        | ACPE          |
| Red maple              | Acer rubrum               | ACRU          |
| Sugar maple            | Acer saccharum            | ACSA          |
| Mountain maple         | Acer spicatum             | ACSP          |
| Juneberry/serviceberry | Amelanchier spp.          | AMSP          |
| Yellow birch           | Betula alleghaniensis     | BEAL          |
| Mountain birch         | Betula cordifolia         | BECO          |
| Paper birch            | Betula papyrifera         | BEPA          |
| Grey birch             | Betula populifolia        | BEPO          |
| Alternateleaf dogwood  | Cornus alternalternifolia | COAL          |
| American beech         | Fagus grandifolia         | FAGR          |
| White ash              | Fraxinus americana        | FRAM          |
| Black ash              | Fraxinus nigra            | FRNI          |
| Eastern hophornbeam    | Ostrya virginiana         | OSVI          |
| Bigtooth aspen         | Populus grandidentata     | POGR          |
| Quaking aspen          | Populus tremuloides       | POTR          |
| Pin cherry             | Prunus pensylvanica       | PRPE          |
| Black cherry           | Prunus serotina           | PRSE          |
| Cherry species         | Prunus spp.               | PRSP          |
| Chokecherry            | Prunus virginiana         | PRVI          |
| Red oak                | Quercus rubra             | QURU          |
| Willow species         | Salix spp.                | SASP          |
| Red elderberry         | Sambucus racemosa         | SAPU          |
| American mountain-ash  | Sorbus americana          | SOAM          |
| Basswood               | Tilia americana           | TIAM          |
| Unknown                | NA                        | UNKN          |

<br>

**Softwoods**

| common name     | scientific name  | 4-letter code |
|:----------------|:-----------------|:--------------|
| Balsam fir      | Abies balsamea   | ABBA          |
| Red spruce      | Picea rubens     | PIRU          |
| White pine      | Pinus strobus    | PIST          |
| Eastern hemlock | Tsuga canadensis | TSCA          |
| Unknown         | NA               | UNKN          |

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
