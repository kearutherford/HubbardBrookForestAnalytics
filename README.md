
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

First published: July 1, 2024

# Tree biomass estimates

The `HBEFBiomass` function uses localized equations to estimate
above-ground tree biomass. See “Background information for tree biomass
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
  - **ht_cm:** Predicted height of the individual tree in centimeters.
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

    ##       watershed year plot elev_m exp_factor species status vigor dbh_cm
    ## 5135         W1 1996    1  738.2    16.0000    ABBA   Live     0   15.1
    ## 5505         W1 1996    1  738.2    16.0000    ABBA   Live     0   15.2
    ## 12276        W1 1996    1  738.2   133.3333    ACPE   Live     0    2.1
    ## 15972        W1 1996    1  738.2   133.3333    ACRU   Dead     4    2.9
    ## 16188        W1 1996    1  738.2   133.3333    ACRU   Live     3    2.7
    ## 30016        W1 1996    1  738.2    16.0000    ACSA   Live     0   15.8
    ##           ht_cm    above_kg    leaf_kg  bbd canopy elev_band       forest_type
    ## 5135  1015.8031  50.3670779 8.90393220 <NA>   <NA>         H northern_hardwood
    ## 5505  1020.5396  51.2207335 9.03074010 <NA>   <NA>         H northern_hardwood
    ## 12276  370.5838   0.7164254 0.06835573 <NA>   <NA>         H northern_hardwood
    ## 15972  508.4580   1.3420485 0.00000000 <NA>   <NA>         H northern_hardwood
    ## 16188  489.3990   1.5604984 0.19094001 <NA>   <NA>         H northern_hardwood
    ## 30016 1434.0221 114.9590707 2.64563667 <NA>   <NA>         H northern_hardwood
    ##       plot_area_ha
    ## 5135        0.0625
    ## 5505        0.0625
    ## 12276       0.0075
    ## 15972       0.0075
    ## 16188       0.0075
    ## 30016       0.0625

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

    ##    watershed year plot elev_m exp_factor species status vigor dbh_cm cbh_m
    ## 1         W5 1998    1    500         50    BEPA   Live     1    3.4   0.3
    ## 2         W5 1998    1    500         50    PIST   Live     2   14.5   1.4
    ## 3         W5 1998    1    500         50    FAGR   Live     1   10.8   1.8
    ## 4         W5 1998    2    650         50    ACPE   Dead     4   20.2   2.2
    ## 5         W5 1998    2    650         50    SASP   Live     3    5.5   1.5
    ## 6         W5 1998    2    650         50    BEAL   Dead     5   13.6   1.6
    ## 7         W5 2002    1    500         50    BEPA   Live     1    3.4   1.4
    ## 8         W5 2002    1    500         50    PIST   Dead     4   14.5   0.5
    ## 9         W5 2002    1    500         50    FAGR   Live     1   10.8   0.8
    ## 10        W5 2002    2    650         50    ACPE   Dead     5   20.2   0.2
    ## 11        W5 2002    2    650         50    SASP   Dead     4    5.5   0.5
    ## 12        W5 2002    2    650         50    BEAL   Dead     5   13.6   3.6
    ## 13        W6 1997    1    750         50    FAGR   Dead     4   12.5   1.5
    ## 14        W6 1997    1    750         50    FAGR   Dead     4   11.9   1.9
    ## 15        W6 1997    2    550         50    NONE   <NA>  <NA>     NA    NA

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
    ## 1        W5 1998    1    500       5.01370       0.00000     5.01370    0.10982
    ## 2        W5 1998    2    650       0.24062       8.15022     8.39084    0.01626
    ## 3        W5 2002    1    500       2.21491       2.28540     4.50031    0.06926
    ## 4        W5 2002    2    650       0.00000       7.00306     7.00306    0.00000
    ## 5        W6 1997    1    750       0.00000       4.15763     4.15763    0.00000
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
    ## 1        W1 1996    1 northern_hardwood  738.2      sapling       0.39577
    ## 2        W1 1996    1 northern_hardwood  738.2         tree     119.65839
    ## 3        W1 1996   10 northern_hardwood  738.9      sapling       9.45333
    ## 4        W1 1996   10 northern_hardwood  738.9         tree     167.41554
    ## 5        W1 1996  100 northern_hardwood  622.7      sapling       5.04163
    ## 6        W1 1996  100 northern_hardwood  622.7         tree     144.35868
    ##   above_D_Mg_ha above_Mg_ha leaf_Mg_ha
    ## 1       0.17894     0.57471    0.03752
    ## 2      46.91576   166.57415    3.00160
    ## 3       0.14781     9.60114    0.41259
    ## 4       4.22469   171.64023    3.60931
    ## 5       0.00000     5.04163    0.19035
    ## 6      22.03557   166.39425    2.45552

*Notice in the output dataframe: Since forest_type is included in the
internal data, it is carried through into the summarized output data.
The same idea applies to external data - if forest_type is included in
the input dataframe, it will be carried through into the summarized
output data.*

<br>

# Background information for tree biomass estimations

## Biomass workflow

**Step 1: Predict tree heights**

We fit new equations to predict height based on species, DBH, and
elevation. These equations were fit using valley-wide height samples.

**Step 2. Calculate above-ground live tree biomass**

We fit new equations to predict total above-ground tree biomass
(including all wood, bark, branch, and foliage). We fit separate
equations to predict tree foliage biomass on its own.

**Step 3. Discount above-ground tree biomass for dead trees**

Standing dead trees lose mass in two ways: (1) they degrade with pieces
falling and transferring to other biomass pools (e.g., stem tops break
and become coarse woody debris) and (2) the remaining structures decay
as measured by their density (i.e., mass/volume). We accounted for the
decay and degrade of standing dead trees by discounting the live biomass
estimates based on vigor. For trees/saplings with a vigor code of 4, the
discount rate is 0.7283 (above-ground live tree biomass x 0.7283). For
trees/saplings with a vigor code of 5, the discount rate is 0.5683
(above-ground live tree biomass x 0.5683).

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
