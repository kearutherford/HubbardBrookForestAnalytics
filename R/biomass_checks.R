
################################################################################
################################################################################
# Top-level function
################################################################################
################################################################################

#' @title HBEFBiomass
#'
#' @description
#' Estimates aboveground tree biomass using localized equations. See \href{https://github.com/kearutherford/HubbardBrookForestAnalytics}{README} for details.
#'
#' @param data_type Specifies whether the data of interest are internal to the package (meaning the clean, archived tree data from Hubbard Brook Experimental Forest for all watersheds, plots, and years) or external to the package (meaning data provided by the user). Must be set to "internal" or "external". The default is set to "internal".
#' @param external_data Only required if data_type is set to "external." A dataframe or tibble with the following columns: watershed, year, plot, elev_m, exp_factor, species, status, vigor, and dbh_cm. A forest_type column is optional. Each row must be an observation of an individual tree.
#' @param results Specifies whether the results will be summarized by tree, by plot, or by plot as well as size class (size class has two categories: (1) tree, DBH >= 10 cm and (2) sapling, DBH < 10 cm). Must be set to either "by_tree", "by_plot", or "by_size". The default is set to "by_plot". 
#'
#' @return Depends on the results setting:
#' \itemize{
#' \item by_tree: a dataframe with tree-level biomass estimates (reported in kilograms).
#' \item by_plot: a dataframe with plot-level biomass estimates (reported in megagrams per hectare).
#' \item by_size: a dataframe with plot-level biomass estimates, further summarized by size class (tree/sapling; reported in megagrams per hectare).
#' }
#' 
#' @examples
#' HBEFBiomass(data_type = "internal",
#'             results = "by_tree")
#'             
#' HBEFBiomass(data_type = "external",
#'             external_data = external_demo_data,
#'             results = "by_plot")
#'
#' @export

HBEFBiomass <- function(data_type = "internal", external_data, results = "by_plot") {
  
  # check that options are set appropriately 
  ValidateOptions(data_type_val = data_type, results_val = results)
  
  # check and prep input data, if external 
  if(data_type == "internal") {
    step1 <- internal_hbef_data
  } else {
    step1 <- ValidateExternal(ext_data_val = external_data)
  }
  
  # predict height
  step2 <- PredictHeight(data = step1)
  
  # calculate biomass
  step3 <- PredictBiomass(data = step2)
  
  # discount biomass (for dead trees)
  step4 <- DiscountBiomass(data = step3)
  
  # compile to the plot level, if desired
  if(results == "by_tree") {
    step5 <- subset(step4, select = -sample_class)
  } else {
    step5 <- SumBy(data = step4, sum_by = results)
  }
  
  return(step5)
  
}


################################################################################
################################################################################
# ValidateOptions function
################################################################################
################################################################################

ValidateOptions <- function(data_type_val, results_val) {

  if(data_type_val == "internal" || data_type_val == "external") {
    # do nothing
  } else {
    stop('The "data_type" parameter must be set to either "internal" or "external".')
  }
  
  if(results_val == "by_tree" || results_val == "by_plot" || results_val == "by_size") {
    # do nothing
  } else {
    stop('The "results" parameter must be set to "by_tree", "by_plot" or "by_size".')
  }
  
}


################################################################################
################################################################################
# ValidateExternal function
################################################################################
################################################################################

ValidateExternal <- function(ext_data_val) {
  
  # coerce tibble inputs into data.frame
  data_val <- as.data.frame(ext_data_val)
  
  
  ###########################################################
  # Check that all columns are in the provided dataframe
  ###########################################################
  
  if(!("watershed" %in% colnames(data_val))) {
    stop('Input data is missing the necessary "watershed" column.')
  }
  
  if(!("year" %in% colnames(data_val))) {
    stop('Input data is missing the necessary "year" column.')
  }
  
  if(!("plot" %in% colnames(data_val))) {
    stop('Input data is missing the necessary "plot" column.')
  }
  
  if(!("elev_m" %in% colnames(data_val))) {
    stop('Input data is missing the necessary "elev_m" column.')
  }
  
  if(!("exp_factor" %in% colnames(data_val))) {
    stop('Input data is missing the necessary "exp_factor" column.')
  }
  
  if(!("species" %in% colnames(data_val))) {
    stop('Input data is missing the necessary "species" column.')
  }
  
  if(!("status" %in% colnames(data_val))) {
    stop('Input data is missing the necessary "status" column.')
  }
  
  if(!("vigor" %in% colnames(data_val))) {
    stop('Input data is missing the necessary "vigor" column.')
  }
  
  if(!("dbh_cm" %in% colnames(data_val))) {
    stop('Input data is missing the necessary "dbh_cm" column.')
  }
  
  
  ###########################################################
  # Check that column classes are as expected
  ###########################################################
  
  # Categorical variables ------------------------------------------------------
  if(!is.character(data_val$watershed)) {
    stop('"watershed" must be a character variable.\n',
         'You have input a variable of class: ', class(data_val$watershed))
  }
  
  if(!is.character(data_val$year)) {
    stop('"year" must be a character variable.\n',
         'You have input a variable of class: ', class(data_val$year))
  }
  
  if(!is.character(data_val$plot)) {
    stop('"plot" must be a character variable.\n',
         'You have input a variable of class: ', class(data_val$plot))
  }
  
  if(!is.character(data_val$species)) {
    stop('"species" must be a character variable.\n',
         'You have input a variable of class: ', class(data_val$species))
  }
  
  if(!is.character(data_val$status)) {
    stop('"status" must be a character variable.\n',
         'You have input a variable of class: ', class(data_val$status))
  }
  
  if(!is.character(data_val$vigor)) {
    stop('"vigor" must be a character variable.\n',
         'You have input a variable of class: ', class(data_val$vigor))
  }
  
  # Numerical variables --------------------------------------------------------
  if(!is.numeric(data_val$elev_m)) {
    stop('"elev_m" must be a numerical variable.\n',
         'You have input a variable of class: ', class(data_val$elev_m))
  }
  
  if(!is.numeric(data_val$exp_factor)) {
    stop('"exp_factor" must be a numerical variable.\n',
         'You have input a variable of class: ', class(data_val$exp_factor))
  }
  
  if(!is.numeric(data_val$dbh_cm)) {
    stop('"dbh_cm" must be a numerical variable.\n',
         'You have input a variable of class: ', class(data_val$dbh_cm))
  }
  
  
  #########################################################
  # Check that watershed, year and plot are as expected
  #########################################################
  
  if ('TRUE' %in% is.na(data_val$watershed)) {
    stop('There are missing values in the watershed column in the provided dataframe.')
  }
  
  if ('TRUE' %in% is.na(data_val$year)) {
    stop('There are missing values in the year column in the provided dataframe.')
  }
  
  if ('TRUE' %in% is.na(data_val$plot)) {
    stop('There are missing values in the plot column in the provided dataframe.')
  }
  
  
  ##########################################################
  # Check that expansion factor is as expected
  ##########################################################
  
  # Check for NA ---------------------------------------------------------------
  if ('TRUE' %in% is.na(data_val$exp_factor)) {
    stop('There are missing expansion factors in the provided dataframe.')
  }
  
  # Check for negative ef ------------------------------------------------------
  if (min(data_val$exp_factor) < 0) {
    stop('There are negative expansion factors in the provided dataframe. All expansion factors must be >= 0.')
  }
  
  
  ###########################################################
  # Check elevation 
  ###########################################################
  
  # Check for NA ---------------------------------------------------------------
  if ('TRUE' %in% is.na(data_val$elev_m)) {
    stop('There are missing elevations in the provided dataframe.')
  }
  
  # Check for negative elev ----------------------------------------------------
  if (min(data_val$elev_m, na.rm = TRUE) < 0) {
    stop('There are negative elevations in the provided dataframe. All elevation values must be >= 0.')
  }
  
  # Check for matching elevations within a plot --------------------------------
  data_val$water_year_plot <- paste(data_val$watershed, data_val$year, data_val$plot, sep = "_")
  unq_ids <- unique(data_val$water_year_plot)
  elev_check_vec <- c()
  
  for(u in unq_ids) {
    
    all_trees <- subset(data_val, water_year_plot == u)
    
    if(length(unique(all_trees$elev_m)) != 1) {
      elev_check_vec <- c(elev_check_vec, u)
    }
    
  }
  
  if(length(elev_check_vec) > 0) {
    
    elev_check <- paste0(elev_check_vec, sep = "   ")
    
    stop('Each watershed:year:plot should have the same elevation recorded.\n',
         'The following watershed:year:plot combinations have multiple elev_m values: ', elev_check)
    
  }
  
  
  ###########################################################
  # Check forest type (if in dataframe)
  ###########################################################
  
  # Check for matching forest type within a plot -------------------------------
  if("forest_type" %in% colnames(data_val)) {
    
    for_check_vec <- c()
    
    for(u in unq_ids) {
      
      all_trees <- subset(data_val, water_year_plot == u)
      
      if(length(unique(all_trees$forest_type)) != 1) {
        for_check_vec <- c(for_check_vec, u)
      }
      
    }
    
    if(length(for_check_vec) > 0) {
      
      for_check <- paste0(for_check_vec, sep = "   ")
      
      stop('Each watershed:year:plot should have the same forest type recorded.\n',
           'The following watershed:year:plot combinations have multiple forest types recorded: ', for_check)
      
    }
    
  }
  
  
  ###########################################################
  # Check that species codes are as expected
  ###########################################################
  
  # Check for unrecognized species codes ---------------------------------------
  sp_code_names <- c("FAGR", "POGR", "ABBA", "FRNI", "TSCA", "BECO", "BEPA", "PRPE", "POTR", "ACRU", "PIRU", "ACSA", "ACPE", "FRAM", "BEAL", "PRSE", 
                     "BEPO", "AMSP", "SOAM", "ACSP", "UNKN", "SAPU", "PRVI", "COAL", "TIAM", "QURU", "PIST", "OSVI", "SASP", "PRSP", "NONE", NA)
  
  if(!all(is.element(data_val$species, sp_code_names))) {
    
    unrecognized_sp <- sort(paste0(unique(data_val[!is.element(data_val$species, sp_code_names), "species"]), sep = " "))
    
    stop('Not all species codes were recognized!\n',
         'Unrecognized codes: ', unrecognized_sp)
    
  }
  
  # Check for NA ---------------------------------------------------------------
  if ('TRUE' %in% is.na(data_val$species)) {
    warning('There are missing species codes in the provided dataframe. Trees with NA species codes will be assigned unknown tree, UNKN. Consider investigating these trees.\n\n')
  }
  
  # Check for proper use of NONE species ---------------------------------------
  for(u in unq_ids) {
      
    all_trees <- subset(data_val, water_year_plot == u)
      
    if('TRUE' %in% is.element(all_trees$species, "NONE")) {
        
      n <- nrow(all_trees)
        
      if(n > 1) {
          
        stop('There are plots with a recorded species code of NONE, but with more than one row.\n',
             'Plots with no trees or saplings should be represented by a single row with watershed, year, plot, exp_factor, elev_m, and forest_type filled in as appropriate and a species code of NONE.')
          
      }
        
    }
      
  }
  
  plots_wo_trees <- subset(data_val, species == "NONE",
                           select = c(status, vigor, dbh_cm))
  
  if('FALSE' %in% is.na(plots_wo_trees)) {
    
    stop('There are plots with a recorded species code of NONE, but with non-NA status, vigor and/or dbh_cm.\n',
         'Plots with no trees or saplings should be represented by a single row with watershed, year, plot, exp_factor, elev_m, and forest_type filled in as appropriate, a species code of NONE,\n',
         'and NA status, vigor and/or dbh_cm.')
    
  }
  
  ###########################################################
  # Check that status is as expected
  ###########################################################
  
  # Check for unrecognized status codes ----------------------------------------
  if(!all(is.element(data_val$status, c("Dead","Live", NA)))) {
    
    unrecognized_status <- sort(paste0(unique(data_val[!is.element(data_val$status, c("Dead", "Live", NA)), "status"]), sep = " "))
    
    stop('Status must be Dead or Live!\n',
         'Unrecognized status codes: ', unrecognized_status)
  
  }
  
  # Check for NA ---------------------------------------------------------------
  plots_w_trees <- subset(data_val, species != "NONE")
  
  if ('TRUE' %in% is.na(plots_w_trees$status)) {
    warning('There are missing status codes in the provided dataframe - outside of plots with species = NONE, signifying plots with no trees or saplings, which should have NA status.\n',
            'Trees with NA status codes will be assumed to be live. Consider investigating these trees.\n',
            ' \n')
  }
  
  
  ###########################################################
  # Check that vigor is as expected
  ###########################################################
  
  # Check for unrecognized vigor codes -----------------------------------------
  if(!all(is.element(data_val$vigor, c("0","1","2","3","4","5",NA)))) {
    
    unrecognized_vigor <- sort(paste0(unique(data_val[!is.element(data_val$vigor, 
                               c("0","1","2","3","4","5",NA)), "vigor"]), sep = " "))
    
    stop('vigor must be 0 through 5!\n',
         'Unrecognized vigor codes: ', unrecognized_vigor)
    
  }
  
  # Check for NA ---------------------------------------------------------------
  if ('TRUE' %in% is.na(plots_w_trees$vigor)) {
    warning('There are missing vigor codes in the provided dataframe - outside of plots with species = NONE, signifying plots with no trees, which should have NA vigor.\n',
            'Dead trees with NA vigor will be assigned a vigor of 4.\n',
            ' \n')
  }
  
  # Check that status and vigor match ------------------------------------
  dead_trees <- subset(data_val, !is.na(data_val$status) & data_val$status == "Dead" & !is.na(data_val$vigor))
  dead_miss <- subset(dead_trees, dead_trees$vigor == "0" | dead_trees$vigor == "1" | dead_trees$vigor == "2" | dead_trees$vigor == "3")
  live_trees <- subset(data_val, !is.na(data_val$status) & data_val$status == "Live" & !is.na(data_val$vigor))
  live_miss <- subset(live_trees, live_trees$vigor == "4" | live_trees$vigor == "5" | live_trees$vigor == "6")
  
  if (nrow(dead_miss) > 0) {
    warning('There are dead trees with 0-3 vigor codes.\n',
            'These trees will be assigned a vigor of 4.\n',
            'Consider investigating these trees with mismatched status/vigor.\n',
            ' \n')
  }
  
  if (nrow(live_miss) > 0) {
    warning('There are live trees with 4-5 vigor codes.\n',
            'Live trees should have vigor codes of 0-3.\n',
            'These trees will still be considered live in the biomass calculations.\n',
            'But you should consider investigating these trees with mismatched status/vigor.\n',
            ' \n')
  }
  
  
  ###########################################################
  # Check DBH
  ###########################################################
  
  # Check for NA ---------------------------------------------------------------
  if ('TRUE' %in% is.na(plots_w_trees$dbh_cm)) {
    warning('There are missing DBH values in the provided dataframe - outside of plots with species = NONE, signifying plots with no trees, which should have NA DBH.\n',
            'Trees with NA DBH will have NA biomass estimates. Consider investigating these trees.\n',
            ' \n')
  }
  
  # Check for negative DBH -----------------------------------------------------
  if (min(data_val$dbh_cm, na.rm = TRUE) < 2) {
    stop('There are DBH values < 2 in the provided dataframe. All DBH values must be >= 2 cm.')
  }
  
  
  ###########################################################
  # Format output df 
  ###########################################################
  
  # add necessary columns for future calculations 
  data_val$sample_class <- ifelse(is.na(data_val$dbh_cm), "unk", ifelse(data_val$dbh_cm < 10, "sapling", "tree"))
  data_val$elev_mid <- ifelse(data_val$elev_m >= 630 & data_val$elev_m <= 700, 1, 0)
  data_val$elev_high <- ifelse(data_val$elev_m > 700, 1, 0)
  
  # fill in certain missing/incorrect values
  data_val$species <- ifelse(is.na(data_val$species), "UNKN", data_val$species)
  data_val$status <- ifelse(data_val$species != "NONE" & is.na(data_val$status), "Live", data_val$status)
  data_val$vigor <- ifelse(data_val$species != "NONE" & data_val$status == "Dead" & is.na(data_val$vigor), "4", 
                           ifelse(data_val$species != "NONE" & data_val$status == "Dead" & data_val$vigor %in% c("0", "1", "2", "3"), "4", data_val$vigor))
  
  # remove column created only for checks
  data_val <- subset(data_val, select = -water_year_plot)
  
  return(data_val)
  
}


globalVariables(c("a", "above_g", "b", "b1_ag", "b1_lf", "b2_ag", "b2_lf", "b3_ag", "b3_lf", "calc_bio", "calc_ht",
    "crown_ratio", "cull", "d", "dbh_cm", "decay_class", "division", "e", "elev_high", "elev_mid",
    "eqn", "eqn_ag", "eqn_lf", "foliage_c", "ht1_m", "ht2_m", "ht_m", "leaf_g", "merch_bark_c",
    "merch_bark_kg", "merch_top_c", "merch_top_kg", "merch_total_c", "merch_total_kg",
    "merch_wood_c", "merch_wood_kg", "province", "sample_class", "site species",
    "species_fia", "spp_hgt", "status", "stump_bark_c", "stump_bark_kg", "stump_total_c",
    "stump_total_kg", "stump_wood_c", "stump_wood_kg", "top", "total_ag_c", "total_ag_kg",
    "total_bark_c", "total_bark_kg", "total_branch_c", "total_branch_kg",
    "total_wood_c", "total_wood_kg", "vigor", "water_year_plot", "site", "species"))

