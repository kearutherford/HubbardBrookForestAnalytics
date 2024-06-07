
above_coefs <- read.csv("aboveg_coefs.csv")
leaf_coefs <- read.csv("leafg_coefs.csv")

trial_data <- read.csv("W5_data.csv")

trial_data$site <- paste0(trial_data$Year,'_W5') # BFA only accepts site/plot
trial_data$plot <- trial_data$PlotID
trial_data$exp_factor <- trial_data$PlotArea.ha
trial_data$status <- "1"
trial_data$decay_class <- "0"
trial_data$species <- trial_data$Species4
trial_data$dbh_cm <- trial_data$DBH.cm
trial_data$ht_cm <- trial_data$HGT.cm
trial_data <- subset(trial_data, select = c("site", "plot", "exp_factor", "status", "decay_class", "species", "dbh_cm", "ht_cm"))


PredictBiomass <- function(data) {
  
  # split data 
  sp_w_eqs <- c("FAGR", "POGR", "ABBA", "FRNI", "TSCA", "BECO", "BEPA", "PRPE", "POTR", "ACRU", "PIRU", "ACSA", "ACPE", "FRAM", "BEAL")
  sp_set_1 <- subset(data, species %in% sp_w_eqs) # species that we fit our own equations for
  sp_set_2 <- subset(data, !(species %in% sp_w_eqs)) # species that we use NSVB equations for 
  
  # species set 1 --------------------------------------------------------------
  # add a species/size class column for ABOVEg
  sp_set_1$sp_size_abv <- sp_set_1$species
  sp_set_1$sp_size_abv <- ifelse(sp_set_1$sp_size_abv == "ACRU" & sp_set_1$dbh_cm < 10, "ACRU_S", sp_set_1$sp_size_abv)
  sp_set_1$sp_size_abv <- ifelse(sp_set_1$sp_size_abv == "ACRU" & sp_set_1$dbh_cm >= 10, "ACRU_L", sp_set_1$sp_size_abv)
  sp_set_1$sp_size_abv <- ifelse(sp_set_1$sp_size_abv == "ACSA" & sp_set_1$dbh_cm < 10, "ACSA_S", sp_set_1$sp_size_abv)
  sp_set_1$sp_size_abv <- ifelse(sp_set_1$sp_size_abv == "ACSA" & sp_set_1$dbh_cm >= 10, "ACSA_L", sp_set_1$sp_size_abv)
  sp_set_1$sp_size_abv <- ifelse(sp_set_1$sp_size_abv == "BEAL" & sp_set_1$dbh_cm < 10, "BEAL_S", sp_set_1$sp_size_abv)
  sp_set_1$sp_size_abv <- ifelse(sp_set_1$sp_size_abv == "BEAL" & sp_set_1$dbh_cm >= 10, "BEAL_L", sp_set_1$sp_size_abv)
  sp_set_1$sp_size_abv <- ifelse(sp_set_1$sp_size_abv == "BEPA" & sp_set_1$dbh_cm < 10, "BEPA_S", sp_set_1$sp_size_abv)
  sp_set_1$sp_size_abv <- ifelse(sp_set_1$sp_size_abv == "BEPA" & sp_set_1$dbh_cm >= 10, "BEPA_L", sp_set_1$sp_size_abv)
  sp_set_1$sp_size_abv <- ifelse(sp_set_1$sp_size_abv == "BECO" & sp_set_1$dbh_cm < 10, "BEPA_S", sp_set_1$sp_size_abv) # BECO uses BEPA eqs.
  sp_set_1$sp_size_abv <- ifelse(sp_set_1$sp_size_abv == "BECO" & sp_set_1$dbh_cm >= 10, "BEPA_L", sp_set_1$sp_size_abv) # BECO uses BEPA eqs.
  sp_set_1$sp_size_abv <- ifelse(sp_set_1$sp_size_abv == "FAGR" & sp_set_1$dbh_cm < 10, "FAGR_S", sp_set_1$sp_size_abv)
  sp_set_1$sp_size_abv <- ifelse(sp_set_1$sp_size_abv == "FAGR" & sp_set_1$dbh_cm >= 10, "FAGR_L", sp_set_1$sp_size_abv)
  sp_set_1$sp_size_abv <- ifelse(sp_set_1$sp_size_abv == "POTR" & sp_set_1$dbh_cm < 10, "POTR_S", sp_set_1$sp_size_abv)
  sp_set_1$sp_size_abv <- ifelse(sp_set_1$sp_size_abv == "POTR" & sp_set_1$dbh_cm >= 10, "POTR_L", sp_set_1$sp_size_abv)
  
  # add ABOVEg coefficients and estimate ABOVEg
  sp_set_1 <- merge(sp_set_1, above_coefs, by = "sp_size_abv", all.x = TRUE, all.y = FALSE)
  sp_set_1$total_ag_g <- ifelse(sp_set_1$model_abv == "M1", sp_set_1$b1_abv*(sp_set_1$dbh_cm^sp_set_1$b2_abv)*(sp_set_1$ht_cm^sp_set_1$b3_abv), sp_set_1$b1_abv*(sp_set_1$dbh_cm^sp_set_1$b2_abv))
  sp_set_1$total_ag_kg <- sp_set_1$total_ag_g*0.001
  
  # add a species/size class column for LEAFg
  sp_set_1$sp_size_lf <- sp_set_1$species
  sp_set_1$sp_size_lf <- ifelse(sp_set_1$sp_size_lf == "BECO", "BEPA", sp_set_1$sp_size_lf) # BECO uses BEPA eqs
  sp_set_1$sp_size_lf <- ifelse(sp_set_1$sp_size_lf == "ACRU" & sp_set_1$dbh_cm < 10, "ACRU_S", sp_set_1$sp_size_lf)
  sp_set_1$sp_size_lf <- ifelse(sp_set_1$sp_size_lf == "ACRU" & sp_set_1$dbh_cm >= 10, "ACRU_L", sp_set_1$sp_size_lf)
  sp_set_1$sp_size_lf <- ifelse(sp_set_1$sp_size_lf == "ACSA" & sp_set_1$dbh_cm < 10, "ACSA_S", sp_set_1$sp_size_lf)
  sp_set_1$sp_size_lf <- ifelse(sp_set_1$sp_size_lf == "ACSA" & sp_set_1$dbh_cm >= 10, "ACSA_L", sp_set_1$sp_size_lf)
  sp_set_1$sp_size_lf <- ifelse(sp_set_1$sp_size_lf == "BEAL" & sp_set_1$dbh_cm < 10, "BEAL_S", sp_set_1$sp_size_lf)
  sp_set_1$sp_size_lf <- ifelse(sp_set_1$sp_size_lf == "BEAL" & sp_set_1$dbh_cm >= 10, "BEAL_L", sp_set_1$sp_size_lf)
  sp_set_1$sp_size_lf <- ifelse(sp_set_1$sp_size_lf == "FAGR" & sp_set_1$dbh_cm < 10, "FAGR_S", sp_set_1$sp_size_lf)
  sp_set_1$sp_size_lf <- ifelse(sp_set_1$sp_size_lf == "FAGR" & sp_set_1$dbh_cm >= 10, "FAGR_L", sp_set_1$sp_size_lf)
  sp_set_1$sp_size_lf <- ifelse(sp_set_1$sp_size_lf == "POTR" & sp_set_1$dbh_cm < 10, "POTR_S", sp_set_1$sp_size_lf)
  sp_set_1$sp_size_lf <- ifelse(sp_set_1$sp_size_lf == "POTR" & sp_set_1$dbh_cm >= 10, "POTR_L", sp_set_1$sp_size_lf)
  
  # add LEAFg coefficients and estimate LEAFg
  sp_set_1 <- merge(sp_set_1, leaf_coefs, by = "sp_size_lf", all.x = TRUE, all.y = FALSE)
  sp_set_1$foliage_g <- ifelse(sp_set_1$model_lf == "M1", sp_set_1$b1_lf*(sp_set_1$dbh_cm^sp_set_1$b2_lf)*(sp_set_1$ht_cm^sp_set_1$b3_lf), sp_set_1$b1_lf*(sp_set_1$dbh_cm^sp_set_1$b2_lf))
  sp_set_1$foliage_kg <- sp_set_1$foliage_g*0.001
  
  set_1_output <- subset(sp_set_1, select = c(site, plot, exp_factor, status, decay_class, species, dbh_cm, total_ag_kg, foliage_kg))
  
  # species set 1 --------------------------------------------------------------
  # add columns necessary for running NVSB in BFA
  sp_set_2$division <- "M210"
  sp_set_2$province <- "M211"
  sp_set_2$site <- "HBEF"
  sp_set_2$plot <- as.character(sp_set_2$plot)
  sp_set_2$status <- "1"
  sp_set_2$decay_class <- "0"
  sp_set_2$species <- ifelse(sp_set_2$species == "UNKN", "UNTR", sp_set_2$species) # UNKN = UNTR in BFA
  sp_set_2$dbh <- sp_set_2$dbh_cm
  sp_set_2$ht1 <- sp_set_2$ht_cm*0.01 # convert ht from cm to m
  sp_set_2$ht2 <- as.numeric(NA)
  sp_set_2$crown_ratio <- as.numeric(NA)
  sp_set_2$top <- "Y"
  sp_set_2$cull <- 0
  
  # run NSVB function from BFA 
  sp_set_2 <- BiomassNSVB(data = sp_set_2, sp_codes = "4letter", input_units = "metric", output_units = "metric", results = "by_tree")$dataframe
  set_2_output <- subset(sp_set_2, select = c(site, plot, exp_factor, status, decay_class, species, dbh_cm, total_ag_kg, foliage_kg))
  
  return_df <- rbind(set_1_output, set_2_output)
  
  return(return_df)
  
}


trial_output <- PredictBiomass(data = trial_data)


