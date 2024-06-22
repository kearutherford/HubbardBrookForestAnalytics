
PredictHeight <- function(data) {
  
  # add variable to dataframe 
  data$calc_ht <- ifelse(is.na(data$dbh_cm) | is.na(data$elev_m), "N", "Y")
  
  # merge coefficient dataframe
  data2 <- merge(data, hgt_coefs, by = c("species", "sample_class"), all.x = TRUE, all.y = FALSE)
  
  # estimate heights (in meters)
  data2$ht_m <- ifelse(data2$eqn == "s" & data2$calc_ht == "Y", ((10+(data2$c*data$elev_m))+(data2$a*(1-exp(-data2$b*data2$dbh_cm)))),
                       ifelse(data2$eqn == "cr" & data2$calc_ht == "Y", ((data2$a+(data2$d*data2$elev_m))*(1-exp(-data2$b*data2$dbh_cm))^data2$c),
                       ifelse(data2$eqn == "lm" & data2$calc_ht == "Y", (data2$a+(data2$b*data2$dbh_cm)+(data2$c*data2$elev_m)),
                       ifelse(data2$eqn == "lm0" & data2$calc_ht == "Y", (1.37+data2$a+(data2$b*data2$dbh_cm)),
                       ifelse(data2$eqn == "cr1" & data2$calc_ht == "Y", ((data2$a+(data2$d*data2$elev_high)+(data2$e*data2$elev_mid))*(1-exp(-data2$b*data2$dbh_cm))^data2$c),
                       ifelse(data2$eqn == "cr0" & data2$calc_ht == "Y", (data2$a*(1-exp(-data2$b*data2$dbh_cm))^data2$c),
                       ifelse(data2$eqn == "s1" & data2$calc_ht == "Y", ((1.37+(data2$c*data2$elev_high)+(data2$d*data2$elev_mid))+(data2$a*(1-exp(-data2$b*data2$dbh_cm)))), NA)))))))
  
  # convert ht from m to cm
  data2$ht_cm <- data2$ht_m*100

  return_df <- subset(data2, select = -c(calc_ht, spp_hgt, a, b, c, d, e, eqn, ht_m, elev_mid, elev_high))
  return(return_df)
  
}


PredictBiomass <- function(data) {
  
  # add variable to dataframe 
  # NA ht_cm has NA dbh_cm and NA elev_m baked in 
  data$calc_bio <- ifelse(is.na(data$ht_cm), "N", "Y")
  
  # split data 
  sp_w_eqs <- c("FAGR", "POGR", "ABBA", "FRNI", "TSCA", "BECO", "BEPA", "PRPE", "POTR", "ACRU", "PIRU", "ACSA", "ACPE", "FRAM", "BEAL")
  sp_set_1.1 <- subset(data, species %in% sp_w_eqs) # species that we fit our own equations for
  sp_set_2.1 <- subset(data, !(species %in% sp_w_eqs) & species != "NONE") # species that we use NSVB equations for 
  sp_set_3.1 <- subset(data, species == "NONE") # plots without trees 
  
  
  ##############################################################################
  # species set 1 (we fit our own equations)
  ##############################################################################

  # add a species/size class column for ABOVEg
  sp_set_1.1$sp_size_abv <- sp_set_1.1$species
  sp_set_1.1$sp_size_abv <- ifelse(sp_set_1.1$sp_size_abv == "PRSP", "PRPE", sp_set_1.1$sp_size_abv) # PRSP uses PRPE eqs
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
  sp_set_1.2$above_g <- ifelse(sp_set_1.2$calc_bio == "Y" & sp_set_1.2$model_abv == "M1", sp_set_1.2$b1_abv*(sp_set_1.2$dbh_cm^sp_set_1.2$b2_abv)*(sp_set_1.2$ht_cm^sp_set_1.2$b3_abv), NA)
  sp_set_1.2$above_g <- ifelse(sp_set_1.2$calc_bio == "Y" & sp_set_1.2$model_abv == "M2", sp_set_1.2$b1_abv*(sp_set_1.2$dbh_cm^sp_set_1.2$b2_abv), sp_set_1.2$above_g)
  sp_set_1.2$above_kg <- sp_set_1.2$above_g*0.001 # convert from g to kg
  
  # add a species/size class column for LEAFg
  sp_set_1.2$sp_size_lf <- sp_set_1.2$species
  sp_set_1.2$sp_size_lf <- ifelse(sp_set_1.2$sp_size_lf == "BECO", "BEPA", sp_set_1.2$sp_size_lf) # BECO uses BEPA eqs
  sp_set_1.2$sp_size_lf <- ifelse(sp_set_1.2$sp_size_lf == "PRSP", "PRPE", sp_set_1.2$sp_size_lf) # PRSP uses PRPE eqs
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
  sp_set_1.3$leaf_g <- ifelse(sp_set_1.3$calc_bio == "Y" & sp_set_1.3$model_lf == "M1", sp_set_1.3$b1_lf*(sp_set_1.3$dbh_cm^sp_set_1.3$b2_lf)*(sp_set_1.3$ht_cm^sp_set_1.3$b3_lf), NA)
  sp_set_1.3$leaf_g <- ifelse(sp_set_1.3$calc_bio == "Y" & sp_set_1.3$model_lf == "M2", sp_set_1.3$b1_lf*(sp_set_1.3$dbh_cm^sp_set_1.3$b2_lf), sp_set_1.3$leaf_g)
  sp_set_1.3$leaf_kg <- sp_set_1.3$leaf_g*0.001 # convert from g to kg
  
  # create clean output df 
  set_1_output <- subset(sp_set_1.3, select = -c(sp_size_abv, model_abv, b1_abv, b2_abv, b3_abv, sp_size_lf, model_lf, b1_lf, b2_lf, b3_lf, calc_bio, above_g, leaf_g))
  set_1_output <- subset(set_1_output, select = order(colnames(set_1_output)))
  
  
  ##############################################################################
  # species set 2 (we use NSVB equations)
  ##############################################################################
  
  # preserve original columns 
  names(sp_set_2.1)[names(sp_set_2.1) == "status"] <- "status_og"
  names(sp_set_2.1)[names(sp_set_2.1) == "species"] <- "species_og"
  names(sp_set_2.1)[names(sp_set_2.1) == "dbh_cm"] <- "dbh_og"
  
  # add columns necessary for running NVSB in BFA
  sp_set_2.1$division <- "M210"
  sp_set_2.1$province <- "M211"
  sp_set_2.1$site <- paste(sp_set_2.1$watershed, sp_set_2.1$year, sp_set_2.1$sample_class, sep = "_")
  sp_set_2.1$status <- "1" # all trees sent to BFA NSVB are live (decay/degrade later in this workflow)
  sp_set_2.1$decay_class <- "0"
  sp_set_2.1$species <- ifelse(sp_set_2.1$species_og == "UNKN", "UNTR", # UNKN = UNTR in BFA
                               ifelse(sp_set_2.1$species_og == "COAL", "COSP", sp_set_2.1$species_og)) # COAL routed to COSP in BFA
  sp_set_2.1$dbh <- ifelse(sp_set_2.1$dbh_og < 2.54, 2.54, sp_set_2.1$dbh_og)
  sp_set_2.1$ht1 <- sp_set_2.1$ht_cm*0.01 # convert ht from cm to m
  sp_set_2.1$ht2 <- as.numeric(NA)
  sp_set_2.1$crown_ratio <- as.numeric(NA)
  sp_set_2.1$top <- "Y"
  sp_set_2.1$cull <- 0
  
  # run NSVB function from BFA 
  sp_set_2.2 <- BiomassNSVB(data = sp_set_2.1, sp_codes = "4letter", input_units = "metric", output_units = "metric", results = "by_tree")$dataframe
  
  # make sure HBEF and BFA NSVB values are cohesive
  # In HBEF data, ABOVEg includes LEAFg. In NSVB workflow, foliage is separate from wood/bark/branch biomass.
  sp_set_2.2$above_kg <- sp_set_2.2$total_ag_kg + sp_set_2.2$foliage_kg
  
  # create clean output df
  set_2_output <- subset(sp_set_2.2, select = -c(division, province, site, status, decay_class, species, species_fia, dbh_cm, ht1_m, ht2_m, crown_ratio, top, cull,
                                                 total_wood_kg, total_bark_kg, total_branch_kg, total_ag_kg, merch_wood_kg, merch_bark_kg, merch_total_kg,
                                                 merch_top_kg, stump_wood_kg, stump_bark_kg, stump_total_kg,
                                                 total_wood_c, total_bark_c, total_branch_c, total_ag_c, merch_wood_c, merch_bark_c, merch_total_c,
                                                 merch_top_c, stump_wood_c, stump_bark_c, stump_total_c, foliage_c, calc_bio))
  
  names(set_2_output)[names(set_2_output) == "status_og"] <- "status"
  names(set_2_output)[names(set_2_output) == "species_og"] <- "species"
  names(set_2_output)[names(set_2_output) == "dbh_og"] <- "dbh_cm"
  names(set_2_output)[names(set_2_output) == "foliage_kg"] <- "leaf_kg"
  set_2_output <- subset(set_2_output, select = order(colnames(set_2_output)))
  
  
  ##############################################################################
  # species set 3 (plots without trees)
  ##############################################################################
  
  # biomass is NA, not 0, at the tree level
  # biomass becomes 0 at the plot level 
  sp_set_3.1$above_kg <- NA
  sp_set_3.1$leaf_kg <- NA
  set_3_output <- subset(sp_set_3.1, select = -calc_bio)
  set_3_output <- subset(set_3_output, select = order(colnames(set_3_output)))
  
  
  ##############################################################################
  # combine species sets 1, 2, and 3
  ##############################################################################
  
  # merge species sets
  merged_df <- rbind(set_1_output, set_2_output, set_3_output)
  
  # re-order columns
  # this approach allows flexibility for which additional columns are included in the dataframe 
  name_vec1 <- c("watershed", "year", "plot", "elev_m", "exp_factor", "species", "status", "vigor", "dbh_cm", "above_kg", "leaf_kg")
  name_vec2 <- colnames(merged_df[,!is.element(colnames(merged_df), name_vec1)])
  return_df <- subset(merged_df, select = c(name_vec1, name_vec2))
  
  return(return_df)
  
}


DiscountBiomass <- function(data) {
  
  # discount above biomass for dead trees 
  data$above_kg <- ifelse(data$status == "Dead" & data$vigor == "4", data$above_kg*0.7283, 
                          ifelse(data$status == "Dead" & data$vigor == "5", data$above_kg*0.5683, data$above_kg))
  
  # discount leaf biomass for dead trees
  data$leaf_kg <- ifelse(data$status == "Dead", 0, data$leaf_kg)
  
  return(data)
  
}

