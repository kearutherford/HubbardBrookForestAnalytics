

################################################################################
################################################################################
# Top-level function
################################################################################
################################################################################

#' @title HBEFBiomass
#'
#' @description
#' Describe... 
#'
#' @param data_type describe... 
#' @param external_data describe...
#' @param results describe...
#'
#' @return describe... 
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
    
    return(step4)
    
  } else {
    
    step5 <- SumBy(data = step4, sum_by = results)
    return(step5)
    
  }
  
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
  
  if(results_val == "by_tree" || results_val == "by_plot") {
    # do nothing
  } else {
    stop('The "results" parameter must be set to "by_tree" or "by_plot".')
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
  # Check that year, watershed and plot are as expected
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
    warning('There are missing elevations in the provided dataframe.\n',
            'Trees in plots with NA elevation will have NA biomass estimates. Consider investigating these plots.\n',
            ' \n')
  }
  
  # Check for negative DBH -----------------------------------------------------
  if (min(data_val$elev_m, na.rm = TRUE) < 0) {
    stop('There are negative elevations in the provided dataframe. All elevation values must be >= 0.')
  }
  
  
  ###########################################################
  # Check that species codes are as expected
  ###########################################################
  
  # Check for unrecognized species codes ---------------------------------------
  sp_code_names <- c("FAGR", "POGR", "ABBA", "FRNI", "TSCA", "BECO", "BEPA", "PRPE", "POTR", "ACRU", "PIRU", "ACSA", "ACPE", "FRAM", "BEAL", "PRSE", 
                     "BEPO", "AMSP", "SOAM", "ACSP", "UNKN", "SAPU", "PRVI", "COAL", "TIAM", "QURU", "PIST", "OSVI", "SASP", "PRSP", "VIAL", NA)
  
  if(!all(is.element(data_val$species, sp_code_names))) {
    
    unrecognized_sp <- sort(paste0(unique(data_val[!is.element(data_val$species, sp_code_names), "species"]), sep = " "))
    
    stop('Not all species codes were recognized!\n',
         'Unrecognized codes: ', unrecognized_sp)
    
  }
  
  # Check for NA ---------------------------------------------------------------
  if ('TRUE' %in% is.na(data_val$species)) {
    warning('There are missing species codes in the provided dataframe. Trees with NA species codes will be assigned unknown tree, UNKN. Consider investigating these trees.\n\n')
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
    warning('There are missing status codes in the provided dataframe - outside of plots with species = NONE, signifying plots with no trees, which should have NA status.\n',
            'Trees with NA status codes will be assumed to be live. Consider investigating these trees.\n',
            ' \n')
  }
  
  
  ###########################################################
  # Check that vigor class is as expected
  ###########################################################
  
  # Check for unrecognized vigor codes -----------------------------------------
  if(!all(is.element(data_val$vigor, c("0","1","2","3","4","5","6",NA)))) {
    
    unrecognized_vigor <- sort(paste0(unique(data_val[!is.element(data_val$vigor, 
                               c("0","1","2","3","4","5","6",NA)), "vigor"]), sep = " "))
    
    stop('vigor must be 0 through 6!\n',
         'Unrecognized vigor codes: ', unrecognized_vigor)
    
  }
  
  # Check for vigor code 6 -----------------------------------------------------
  if ("6" %in% data_val$vigor) {
    warning('There are trees with a vigor class of 6, which means that the tree is down.\n',
            'Trees with vigor class 6 will have NA biomass estimates.\n',
            ' \n')
  }
  
  # Check for NA ---------------------------------------------------------------
  if ('TRUE' %in% is.na(plots_w_trees$vigor)) {
    warning('There are missing vigor codes in the provided dataframe - outside of plots with species = NONE, signifying plots with no trees, which should have NA vigor.\n',
            'Dead trees with NA vigor will be assigned a vigor class of 4.\n',
            ' \n')
  }
  
  # Check that status and vigor match ------------------------------------
  dead_trees <- subset(data_val, !is.na(data_val$status) & data_val$status == "Dead" & !is.na(data_val$vigor))
  dead_miss <- subset(dead_trees, dead_trees$vigor == "0" | dead_trees$vigor == "1" | dead_trees$vigor == "2" | dead_trees$vigor == "3")
  live_trees <- subset(data_val, !is.na(data_val$status) & data_val$status == "Live" & !is.na(data_val$vigor))
  live_miss <- subset(live_trees, live_trees$vigor == "4" | live_trees$vigor == "5" | live_trees$vigor == "6")
  
  if (nrow(dead_miss) > 0) {
    warning('There are dead trees with 0-3 vigor class codes.\n',
            'These trees will be assigned a vigor class of 4.\n',
            'Consider investigating these trees with mismatched status/vigor class.\n',
            ' \n')
  }
  
  if (nrow(live_miss) > 0) {
    warning('There are live trees with 4-6 vigor class codes.\n',
            'Live trees should have vigor class codes of 0-3.\n',
            'These trees will still be considered live in the biomass calculations.\n',
            'But you should consider investigating these trees with mismatched status/vigor class.\n',
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
  if (min(data_val$dbh_cm, na.rm = TRUE) < 0) {
    stop('There are negative DBH values in the provided dataframe. All DBH values must be >= 0.')
  }
  
  
  ###########################################################
  # Format output df 
  ###########################################################
  
  # add necessary columns for future calculations 
  data$sample_class <- ifelse(data$dbh_cm < 10, "sapling", "tree")
  data$elev_mid <- ifelse(data$elev_m >= 630 & data$elev_m <= 700, 1, 0)
  data$elev_high <- ifelse(data$elev_m > 700, 1, 0)
  
  # fill in certain missing/incorrect values
  data_val$species <- ifelse(is.na(data_val$species), "UNKN", data_val$species)
  data_val$status <- ifelse(species != "NONE" & is.na(data_val$status), "Live", data_val$status)
  data_val$vigor <- ifelse(data_val$status == "Dead" & is.na(data_val$vigor), "4", 
                           ifelse(data_val$status == "Dead" & data_val$vigor %in% c("0", "1", "2", "3"), "4", data_val$vigor))
  
  return(data_val)
  
}

