
PredictBiomass <- function(data) {
  
  # split data 
  sp_w_eqs <- c("FAGR", "POGR", "ABBA", "FRNI", "TSCA", "BECO", "BEPA", "PRPE", "POTR", "ACRU", "PIRU", "ACSA", "ACPE", "FRAM", "BEAL")
  sp_set_1.1 <- subset(data, species %in% sp_w_eqs) # species that we fit our own equations for
  sp_set_2.1 <- subset(data, !(species %in% sp_w_eqs)) # species that we use NSVB equations for 
  
  
  ##############################################################################
  # species set 1 (we fit our own equations)
  ##############################################################################
  
  # add a column for trees that will have NA biomass estimates 
  sp_set_1.1$calc_bio <- "Y"
  sp_set_1.1$calc_bio <- ifelse(is.na(sp_set_1.1$dbh_cm), "N", sp_set_1.1$calc_bio)
  
  # add a species/size class column for ABOVEg
  sp_set_1.1$sp_size_abv <- sp_set_1.1$species
  sp_set_1.1$sp_size_abv <- ifelse(sp_set_1.1$sp_size_abv == "ACRU" & sp_set_1.1$dbh_cm < 10, "ACRU_S", sp_set_1.1$sp_size_abv)
  sp_set_1.1$sp_size_abv <- ifelse(sp_set_1.1$sp_size_abv == "ACRU" & sp_set_1.1$dbh_cm >= 10, "ACRU_L", sp_set_1.1$sp_size_abv)
  sp_set_1.1$sp_size_abv <- ifelse(sp_set_1.1$sp_size_abv == "ACSA" & sp_set_1.1$dbh_cm < 10, "ACSA_S", sp_set_1.1$sp_size_abv)
  sp_set_1.1$sp_size_abv <- ifelse(sp_set_1.1$sp_size_abv == "ACSA" & sp_set_1.1$dbh_cm >= 10, "ACSA_L", sp_set_1.1$sp_size_abv)
  sp_set_1.1$sp_size_abv <- ifelse(sp_set_1.1$sp_size_abv == "BEAL" & sp_set_1.1$dbh_cm < 10, "BEAL_S", sp_set_1.1$sp_size_abv)
  sp_set_1.1$sp_size_abv <- ifelse(sp_set_1.1$sp_size_abv == "BEAL" & sp_set_1.1$dbh_cm >= 10, "BEAL_L", sp_set_1.1$sp_size_abv)
  sp_set_1.1$sp_size_abv <- ifelse(sp_set_1.1$sp_size_abv == "BEPA" & sp_set_1.1$dbh_cm < 10, "BEPA_S", sp_set_1.1$sp_size_abv)
  sp_set_1.1$sp_size_abv <- ifelse(sp_set_1.1$sp_size_abv == "BEPA" & sp_set_1.1$dbh_cm >= 10, "BEPA_L", sp_set_1.1$sp_size_abv)
  sp_set_1.1$sp_size_abv <- ifelse(sp_set_1.1$sp_size_abv == "BECO" & sp_set_1.1$dbh_cm < 10, "BEPA_S", sp_set_1.1$sp_size_abv) # BECO uses BEPA eqs.
  sp_set_1.1$sp_size_abv <- ifelse(sp_set_1.1$sp_size_abv == "BECO" & sp_set_1.1$dbh_cm >= 10, "BEPA_L", sp_set_1.1$sp_size_abv) # BECO uses BEPA eqs.
  sp_set_1.1$sp_size_abv <- ifelse(sp_set_1.1$sp_size_abv == "FAGR" & sp_set_1.1$dbh_cm < 10, "FAGR_S", sp_set_1.1$sp_size_abv)
  sp_set_1.1$sp_size_abv <- ifelse(sp_set_1.1$sp_size_abv == "FAGR" & sp_set_1.1$dbh_cm >= 10, "FAGR_L", sp_set_1.1$sp_size_abv)
  sp_set_1.1$sp_size_abv <- ifelse(sp_set_1.1$sp_size_abv == "POTR" & sp_set_1.1$dbh_cm < 10, "POTR_S", sp_set_1.1$sp_size_abv)
  sp_set_1.1$sp_size_abv <- ifelse(sp_set_1.1$sp_size_abv == "POTR" & sp_set_1.1$dbh_cm >= 10, "POTR_L", sp_set_1.1$sp_size_abv)
  
  # add ABOVEg coefficients, and estimate ABOVEg biomass
  sp_set_1.2 <- merge(sp_set_1.1, above_coefs, by = "sp_size_abv", all.x = TRUE, all.y = FALSE)
  
  sp_set_1.2$total_ag_g <- NA
  sp_set_1.2$total_ag_g <- ifelse(sp_set_1.2$calc_bio == "Y" & sp_set_1.2$model_abv == "M1", sp_set_1.2$b1_abv*(sp_set_1.2$dbh_cm^sp_set_1.2$b2_abv)*(sp_set_1.2$ht_cm^sp_set_1.2$b3_abv), sp_set_1.2$total_ag_g)
  sp_set_1.2$total_ag_g <- ifelse(sp_set_1.2$calc_bio == "Y" & sp_set_1.2$model_abv == "M2", sp_set_1.2$b1_abv*(sp_set_1.2$dbh_cm^sp_set_1.2$b2_abv), sp_set_1.2$total_ag_g)
  
  sp_set_1.2$total_ag_kg <- sp_set_1.2$total_ag_g*0.001
  
  # add a species/size class column for LEAFg
  sp_set_1.2$sp_size_lf <- sp_set_1.2$species
  sp_set_1.2$sp_size_lf <- ifelse(sp_set_1.2$sp_size_lf == "BECO", "BEPA", sp_set_1.2$sp_size_lf) # BECO uses BEPA eqs
  sp_set_1.2$sp_size_lf <- ifelse(sp_set_1.2$sp_size_lf == "ACRU" & sp_set_1.2$dbh_cm < 10, "ACRU_S", sp_set_1.2$sp_size_lf)
  sp_set_1.2$sp_size_lf <- ifelse(sp_set_1.2$sp_size_lf == "ACRU" & sp_set_1.2$dbh_cm >= 10, "ACRU_L", sp_set_1.2$sp_size_lf)
  sp_set_1.2$sp_size_lf <- ifelse(sp_set_1.2$sp_size_lf == "ACSA" & sp_set_1.2$dbh_cm < 10, "ACSA_S", sp_set_1.2$sp_size_lf)
  sp_set_1.2$sp_size_lf <- ifelse(sp_set_1.2$sp_size_lf == "ACSA" & sp_set_1.2$dbh_cm >= 10, "ACSA_L", sp_set_1.2$sp_size_lf)
  sp_set_1.2$sp_size_lf <- ifelse(sp_set_1.2$sp_size_lf == "BEAL" & sp_set_1.2$dbh_cm < 10, "BEAL_S", sp_set_1.2$sp_size_lf)
  sp_set_1.2$sp_size_lf <- ifelse(sp_set_1.2$sp_size_lf == "BEAL" & sp_set_1.2$dbh_cm >= 10, "BEAL_L", sp_set_1.2$sp_size_lf)
  sp_set_1.2$sp_size_lf <- ifelse(sp_set_1.2$sp_size_lf == "FAGR" & sp_set_1.2$dbh_cm < 10, "FAGR_S", sp_set_1.2$sp_size_lf)
  sp_set_1.2$sp_size_lf <- ifelse(sp_set_1.2$sp_size_lf == "FAGR" & sp_set_1.2$dbh_cm >= 10, "FAGR_L", sp_set_1.2$sp_size_lf)
  sp_set_1.2$sp_size_lf <- ifelse(sp_set_1.2$sp_size_lf == "POTR" & sp_set_1.2$dbh_cm < 10, "POTR_S", sp_set_1.2$sp_size_lf)
  sp_set_1.2$sp_size_lf <- ifelse(sp_set_1.2$sp_size_lf == "POTR" & sp_set_1.2$dbh_cm >= 10, "POTR_L", sp_set_1.2$sp_size_lf)
  
  # add LEAFg coefficients, and estimate LEAFg biomass
  sp_set_1.3 <- merge(sp_set_1.2, leaf_coefs, by = "sp_size_lf", all.x = TRUE, all.y = FALSE)
  
  sp_set_1.3$foliage_g <- NA
  sp_set_1.3$foliage_g <- ifelse(sp_set_1.3$calc_bio == "Y" & sp_set_1.3$model_lf == "M1", sp_set_1.3$b1_lf*(sp_set_1.3$dbh_cm^sp_set_1.3$b2_lf)*(sp_set_1.3$ht_cm^sp_set_1.3$b3_lf), sp_set_1.3$foliage_g)
  sp_set_1.3$foliage_g <- ifelse(sp_set_1.3$calc_bio == "Y" & sp_set_1.3$model_lf == "M2", sp_set_1.3$b1_lf*(sp_set_1.3$dbh_cm^sp_set_1.3$b2_lf), sp_set_1.3$foliage_g)
  
  sp_set_1.3$foliage_kg <- sp_set_1.3$foliage_g*0.001
  
  # create clean output df 
  set_1_output <- subset(sp_set_1.3, select = c(time, site, plot, exp_factor, status, decay_class, species, dbh_cm, ht_cm, total_ag_kg, foliage_kg, calc_bio))

  
  ##############################################################################
  # species set 1 (we use NSVB equations)
  ##############################################################################
  
  # preserve original columns 
  sp_set_2.1$status_og <- sp_set_2.1$status
  sp_set_2.1$decay_class_og <- sp_set_2.1$decay_class
  sp_set_2.1$species_og <- sp_set_2.1$species
  
  # add columns necessary for running NVSB in BFA
  sp_set_2.1$division <- "M210"
  sp_set_2.1$province <- "M211"
  sp_set_2.1$status <- "1"
  sp_set_2.1$decay_class <- "0"
  sp_set_2.1$species <- ifelse(sp_set_2.1$species == "UNKN", "UNTR", sp_set_2.1$species) # UNKN = UNTR in BFA
  sp_set_2.1$dbh <- sp_set_2.1$dbh_cm
  sp_set_2.1$ht1 <- sp_set_2.1$ht_cm*0.01 # convert ht from cm to m
  sp_set_2.1$ht2 <- as.numeric(NA)
  sp_set_2.1$crown_ratio <- as.numeric(NA)
  sp_set_2.1$top <- "Y"
  sp_set_2.1$cull <- 0
  
  # run NSVB function from BFA 
  sp_set_2.2 <- suppressWarnings(BiomassNSVB(data = sp_set_2.1, sp_codes = "4letter", input_units = "metric", output_units = "metric", results = "by_tree")$dataframe)
  
  # reassign original columns
  sp_set_2.1$status <- sp_set_2.1$status_og
  sp_set_2.1$decay_class <- sp_set_2.1$decay_class_og
  sp_set_2.1$species <- sp_set_2.1$species_og
  
  # create clean output df 
  set_2_output <- subset(sp_set_2.2, select = c(time, site, plot, exp_factor, status, decay_class, species, dbh_cm, ht_cm, total_ag_kg, foliage_kg, calc_bio))
  
  
  ##############################################################################
  # combine species sets 1 and 2
  ##############################################################################
  
  return_df <- rbind(set_1_output, set_2_output)
  
  return(return_df)
  
}

