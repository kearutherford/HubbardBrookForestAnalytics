
################################################################################
################################################################################
# PredictHeight function
################################################################################
################################################################################

PredictHeight <- function(data) {
  
  # add variable to dataframe 
  data$calc_ht <- ifelse(is.na(data$dbh_cm), "N", "Y")
  
  # merge coefficient dataframe
  data2 <- merge(data, hgt_coefs, by = "species", all.x = TRUE, all.y = FALSE)
  
  # estimate heights (in meters)
  data2$ht_m <- ifelse(data2$eqn == "s" & data2$calc_ht == "Y", (1.37+(data2$a+(data2$d*data2$elev_m)+(data2$e*data2$hli)+(data2$f*data2$steep_deg))*(1-exp(-data2$b*data2$dbh_cm))),
                       ifelse(data2$eqn == "cr" & data2$calc_ht == "Y", (1.37+(data2$a+(data2$d*data2$elev_m)+(data2$e*data2$hli)+(data2$f*data2$steep_deg))*(1-exp(-data2$b*data2$dbh_cm))^data2$c), NA))
  
  # convert ht from m to cm
  data2$ht_cm <- data2$ht_m*100

  return_df <- subset(data2, select = -c(calc_ht, spp_hgt, a, b, c, d, e, f, eqn, ht_m))
  return(return_df)
  
}


################################################################################
################################################################################
# PredictBiomass function
################################################################################
################################################################################

PredictBiomass <- function(data) {
  
  # add variable to dataframe 
  # NA ht_cm has NA dbh_cm baked in (see function above)
  data$calc_bio <- ifelse(is.na(data$ht_cm), "N", "Y")
  
  # split data 
  sp_w_eqs <- c(unique(above_coefs$species), "PRSP", "BECO")
  sp_set_1.1 <- subset(data, species %in% sp_w_eqs) # species that we fit our own equations for
  sp_set_2.1 <- subset(data, !(species %in% sp_w_eqs) & species != "NONE") # species that we use NSVB equations for 
  sp_set_3.1 <- subset(data, species == "NONE") # plots without trees 
  
  
  ##############################################################################
  # species set 1 (we fit our own equations)
  ##############################################################################
  
  # preserve original species column
  names(sp_set_1.1)[names(sp_set_1.1) == "species"] <- "species_og"
  
  # add a new species column
  sp_set_1.1$species <- ifelse(sp_set_1.1$species_og == "PRSP", "PRPE", # PRSP uses PRPE eqs
                               ifelse(sp_set_1.1$species_og == "BECO", "BEPA", sp_set_1.1$species_og)) # BECO uses BEPA eqs.
  
  # add ABOVEg coefficients, and estimate ABOVEg biomass
  sp_set_1.2 <- merge(sp_set_1.1, above_coefs, by = c("species", "sample_class"), all.x = TRUE, all.y = FALSE)
  sp_set_1.2$above_g <- ifelse(sp_set_1.2$calc_bio == "Y" & sp_set_1.2$eqn_ag == "M1", sp_set_1.2$b1_ag*(sp_set_1.2$dbh_cm^sp_set_1.2$b2_ag)*(sp_set_1.2$ht_cm^sp_set_1.2$b3_ag), 
                               ifelse(sp_set_1.2$calc_bio == "Y" & sp_set_1.2$eqn_ag == "M2", sp_set_1.2$b1_ag*(sp_set_1.2$dbh_cm^sp_set_1.2$b2_ag), NA))
  sp_set_1.2$above_kg <- sp_set_1.2$above_g*0.001 # convert from g to kg
  
  # add LEAFg coefficients, and estimate LEAFg biomass
  sp_set_1.3 <- merge(sp_set_1.2, leaf_coefs, by = c("species", "sample_class"), all.x = TRUE, all.y = FALSE)
  sp_set_1.3$leaf_g <- ifelse(sp_set_1.3$calc_bio == "Y" & sp_set_1.3$eqn_lf == "M1", sp_set_1.3$b1_lf*(sp_set_1.3$dbh_cm^sp_set_1.3$b2_lf)*(sp_set_1.3$ht_cm^sp_set_1.3$b3_lf),
                              ifelse(sp_set_1.3$calc_bio == "Y" & sp_set_1.3$eqn_lf == "M2", sp_set_1.3$b1_lf*(sp_set_1.3$dbh_cm^sp_set_1.3$b2_lf), NA))
  sp_set_1.3$leaf_kg <- sp_set_1.3$leaf_g*0.001 # convert from g to kg
  
  # create clean output df 
  set_1_output <- subset(sp_set_1.3, select = -c(eqn_ag, b1_ag, b2_ag, b3_ag, eqn_lf, b1_lf, b2_lf, b3_lf, calc_bio, above_g, leaf_g, species))
  names(set_1_output)[names(set_1_output) == "species_og"] <- "species"
  set_1_output <- subset(set_1_output, select = order(colnames(set_1_output)))
  
  
  ##############################################################################
  # species set 2 (we use NSVB equations)
  ##############################################################################
  
  sp_nsvb <- data.frame(
    species_og = c("PRSE","BEPO","AMSP","SOAM","ACSP","UNKN","SAPU","PRVI","COAL","TIAM","OSVI","SASP"),
    species = c("762","379","356","935","319","999","6991","763","490","951","701","920")
  )
  
  if(nrow(sp_set_2.1 > 0)) {
  
    # preserve original columns 
    names(sp_set_2.1)[names(sp_set_2.1) == "status"] <- "status_og"
    names(sp_set_2.1)[names(sp_set_2.1) == "species"] <- "species_og"
    names(sp_set_2.1)[names(sp_set_2.1) == "dbh_cm"] <- "dbh_og"
    
    # add columns necessary for running NVSB in BFA
    sp_set_2.2 <- merge(sp_set_2.1, sp_nsvb, by = "species_og") # add fia species
    sp_set_2.2$division <- "M210"
    sp_set_2.2$province <- "M211"
    sp_set_2.2$site <- paste(sp_set_2.2$watershed, sp_set_2.2$year, sp_set_2.2$sample_class, sep = "_")
    sp_set_2.2$status <- "1" # all trees sent to BFA NSVB are live (decay/degrade later in this workflow)
    sp_set_2.2$decay_class <- "0"
    sp_set_2.2$dbh <- ifelse(sp_set_2.2$dbh_og < 2.54, 2.54, sp_set_2.2$dbh_og)
    sp_set_2.2$ht1 <- sp_set_2.2$ht_cm*0.01 # convert ht from cm to m
    sp_set_2.2$ht2 <- as.numeric(NA)
    sp_set_2.2$crown_ratio <- as.numeric(NA)
    sp_set_2.2$top <- "Y"
    sp_set_2.2$cull <- 0
    
    # run NSVB function from BFA 
    sp_set_2.3 <- suppressWarnings(BiomassNSVB(data = sp_set_2.2, input_units = "metric", output_units = "metric", results = "by_tree")$dataframe)
    
    # make sure HBEF and BFA NSVB values are cohesive
    # In HBEF data, ABOVEg includes LEAFg. In NSVB workflow, foliage is separate from wood/bark/branch biomass.
    sp_set_2.3$above_kg <- sp_set_2.3$total_ag_kg + sp_set_2.3$foliage_kg
    
    # create clean output df
    set_2_output <- subset(sp_set_2.3, select = -c(division, province, site, status, decay_class, species, species_fia, dbh_cm, ht1_m, ht2_m, crown_ratio, top, cull,
                                                   total_wood_kg, total_bark_kg, total_branch_kg, total_ag_kg, merch_wood_kg, merch_bark_kg, merch_total_kg,
                                                   merch_top_kg, stump_wood_kg, stump_bark_kg, stump_total_kg,
                                                   total_wood_c, total_bark_c, total_branch_c, total_ag_c, merch_wood_c, merch_bark_c, merch_total_c,
                                                   merch_top_c, stump_wood_c, stump_bark_c, stump_total_c, foliage_c, calc_bio))
    
    names(set_2_output)[names(set_2_output) == "status_og"] <- "status"
    names(set_2_output)[names(set_2_output) == "species_og"] <- "species"
    names(set_2_output)[names(set_2_output) == "dbh_og"] <- "dbh_cm"
    names(set_2_output)[names(set_2_output) == "foliage_kg"] <- "leaf_kg"
    set_2_output <- subset(set_2_output, select = order(colnames(set_2_output)))
  
  }
  
  ##############################################################################
  # species set 3 (plots without trees)
  ##############################################################################
  
  if(nrow(sp_set_3.1 > 0)) {
  
    sp_set_3.1$above_kg <- 0
    sp_set_3.1$leaf_kg <- 0
    set_3_output <- subset(sp_set_3.1, select = -calc_bio)
    set_3_output <- subset(set_3_output, select = order(colnames(set_3_output)))
  
  }
  
  ##############################################################################
  # combine species sets 1, 2, and 3
  ##############################################################################
  
  # merge species sets
  merged_df <- set_1_output
  
  if(nrow(sp_set_2.1 > 0)) {
    merged_df <- rbind(merged_df, set_2_output)
  }
  
  if(nrow(sp_set_3.1 > 0)) {
    merged_df <- rbind(merged_df, set_3_output)
  }
  
  # re-order columns
  # this approach allows flexibility for which additional columns are included in the dataframe 
  name_vec1 <- c("watershed", "year", "plot", "elev_m", "hli", "steep_deg", "exp_factor", "species", "status", "vigor", "dbh_cm", "ht_cm", "above_kg", "leaf_kg", "sample_class")
  name_vec2 <- colnames(subset(merged_df, select = -c(watershed, year, plot, elev_m, hli, steep_deg, exp_factor, species, status, vigor, dbh_cm, ht_cm, above_kg, leaf_kg, sample_class)))
  return_df <- subset(merged_df, select = c(name_vec1, name_vec2))
  return_df <- return_df[order(return_df$watershed, return_df$year, return_df$plot), ]
  
  return(return_df)
  
}


################################################################################
################################################################################
# DiscountBiomass function
################################################################################
################################################################################

DiscountBiomass <- function(data) {
  
  # discount above biomass for dead trees 
  data$above_kg <- ifelse(!is.na(data$status) & data$status == "Dead" & !is.na(data$vigor) & data$vigor == "4", data$above_kg*0.7283, 
                          ifelse(!is.na(data$status) & data$status == "Dead" & !is.na(data$vigor) & data$vigor == "5", data$above_kg*0.5683, data$above_kg))
  
  # discount leaf biomass for dead trees
  data$leaf_kg <- ifelse(!is.na(data$status) & data$status == "Dead", 0, data$leaf_kg)
  
  return(data)
  
}

