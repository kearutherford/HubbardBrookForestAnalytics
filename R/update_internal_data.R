
# This file is not directly used in HBFA calculations. 
# It is for updating the internal data for the package. 
# After use comment out the code again. 

# Load packages:
#library(tidyverse)
#library(devtools)

# Bring in height coefficient csv
#hgt_coefs <- read_csv("hgt_coefs.csv",
#                      col_types = cols(
#                        species = col_character(),
#                        spp_hgt = col_character(),
#                        a = col_double(),
#                        b = col_double(),
#                        c = col_double(),
#                        d = col_double(),
#                        e = col_double(),
#                        f = col_double(),
#                        eqn = col_character()))

# Bring in internal hbef data csv
#internal_hbef_data <- read_csv("internal_hbef_data.csv",
#                               col_types = cols(
#                                watershed = col_character(),
#                                 plot = col_character(),
#                                 plot_area_ha = col_double(),
#                                 year = col_character(),
#                                 forest_type = col_character(),
#                                 sample_class = col_character(),
#                                 species = col_character(),
#                                 dbh_cm = col_double(),
#                                 status = col_character(),
#                                 vigor = col_character(),
#                                 canopy = col_character(),
#                                 bbd = col_character(),
#                                 exp_factor = col_double(),
#                                 elev_m = col_double(),
#                                 steep_deg = col_double(),
#                                 aspect_deg = col_double(),
#                                 hli = col_double())) %>%
#  select(watershed, year, plot, forest_type, elev_m, hli, steep_deg, aspect_deg, plot_area_ha, 
#         exp_factor, species, status, vigor, canopy, bbd, sample_class, dbh_cm)

# To update internal data run the following:  
#use_data(above_coefs, hgt_coefs, internal_hbef_data, leaf_coefs, internal = TRUE, overwrite = TRUE)