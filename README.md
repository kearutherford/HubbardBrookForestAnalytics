
# Hubbard Brook Forest Analytics

The `HubbardBrookForestAnalytics` package (HBFA) facilitates easy access
and consistent application of the revised Hubbard Brook Experimental
Forest tree biomass equations. The associated Shiny app is available
[here](https://kearutherford.shinyapps.io/HBFAShinyApp/). Further
details on the revised biomass equations are provided in the accompanied
manuscript:

Rutherford, K.H., J.J. Battles, and N.L. Cleavitt. 2026. Quantifying
tree biomass: Insights from a long-term study at Hubbard Brook
Experimental Forest. Canadian Journal of Forest Research.

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
    ##   Kea Rutherford, John Battles (2026). _HubbardBrookForestAnalytics,
    ##   version 2.1.0_. Battles Lab: Forest Ecology and Ecosystem Dynamics,
    ##   University of California, Berkeley.
    ##   <https://github.com/kearutherford/HubbardBrookForestAnalytics>.
    ## 
    ## A BibTeX entry for LaTeX users is
    ## 
    ##   @Manual{,
    ##     title = {HubbardBrookForestAnalytics, version 2.1.0},
    ##     author = {{Kea Rutherford} and {John Battles}},
    ##     organization = {Battles Lab: Forest Ecology and Ecosystem Dynamics, University of California, Berkeley},
    ##     year = {2026},
    ##     url = {https://github.com/kearutherford/HubbardBrookForestAnalytics},
    ##   }

# Tree biomass estimates: `HBEFBiomass( )`

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

    ##       watershed year plot elev_m  hli steep_deg exp_factor species status vigor
    ## 2803         W1 1996    1    738 -0.4         6    16.0000    ABBA   Live     0
    ## 2926         W1 1996    1    738 -0.4         6    16.0000    ABBA   Live     0
    ## 12791        W1 1996    1    738 -0.4         6   133.3333    ACPE   Live     0
    ## 16021        W1 1996    1    738 -0.4         6   133.3333    ACRU   Live     3
    ## 16022        W1 1996    1    738 -0.4         6   133.3333    ACRU   Dead     4
    ## 26245        W1 1996    1    738 -0.4         6    16.0000    ACSA   Live     0
    ##       dbh_cm     ht_cm    above_kg    leaf_kg aspect_deg  bbd canopy
    ## 2803    15.1 1044.9190  51.4953595 8.51238045         72 <NA>   <NA>
    ## 2926    15.2 1049.9174  52.3730708 8.63196138         72 <NA>   <NA>
    ## 12791    2.1  392.8860   0.7164254 0.06835573         72 <NA>   <NA>
    ## 16021    2.7  480.9707   1.6182775 0.19218577         72 <NA>   <NA>
    ## 16022    2.9  504.0964   1.3932184 0.00000000         72 <NA>   <NA>
    ## 26245   15.8 1550.3583 115.6670692 2.89960204         72 <NA>   <NA>
    ##       forest_type plot_area_ha
    ## 2803   spruce-fir       0.0625
    ## 2926   spruce-fir       0.0625
    ## 12791  spruce-fir       0.0075
    ## 16021  spruce-fir       0.0075
    ## 16022  spruce-fir       0.0075
    ## 26245  spruce-fir       0.0625

*Notice in the output dataframe: The `bbd`, `canopy`, `aspect_deg`,
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
    ## 1        W5 1998    1    500       5.40517       0.00000     5.40517    0.11383
    ## 2        W5 1998    2    650       0.25355       8.15022     8.40377    0.01568
    ## 3        W5 2002    1    500       2.46437       2.14178     4.60615    0.07327
    ## 4        W5 2002    2    650       0.00000       7.01248     7.01248    0.00000
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
    ## 1        W1 1996    1        spruce-fir    738      sapling       0.38198
    ## 2        W1 1996    1        spruce-fir    738         tree     110.24471
    ## 3        W1 1996   10 northern_hardwood    739      sapling      11.03994
    ## 4        W1 1996   10 northern_hardwood    739         tree     154.71871
    ## 5        W1 1996  100 northern_hardwood    623      sapling       5.72583
    ## 6        W1 1996  100 northern_hardwood    623         tree     145.68833
    ##   above_D_Mg_ha above_Mg_ha leaf_Mg_ha
    ## 1       0.18576     0.56774    0.03622
    ## 2      47.10919   157.35390    3.07339
    ## 3       0.20946    11.24940    0.51219
    ## 4       4.23677   158.95548    3.65454
    ## 5       0.00000     5.72583    0.24735
    ## 6      22.02741   167.71574    2.39334

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
equations to predict tree foliage biomass on its own. See Rutherford et
al. 2026 for details on the development of the biomass equations.

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
