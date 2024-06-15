
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
  
  # discount biomass
  step4 <- DiscountBiomass(data = step3)
  
  # compile to the plot level, if desired
  if(results == "by_tree") {

    return(step4)
    
  } else {
    
    step5 <- SumByPlot(data = step4)
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
  
  if(!("time" %in% colnames(data_val))) {
    stop('Input data is missing the necessary "time" column.')
  }
  
  if(!("site" %in% colnames(data_val))) {
    stop('Input data is missing the necessary "site" column.')
  }
  
  if(!("plot" %in% colnames(data_val))) {
    stop('Input data is missing the necessary "plot" column.')
  }
  
  if(!("exp_factor" %in% colnames(data_val))) {
    stop('Input data is missing the necessary "exp_factor" column.')
  }
  
  if(!("status" %in% colnames(data_val))) {
    stop('Input data is missing the necessary "status" column.')
  }
  
  if(!("vigor_class" %in% colnames(data_val))) {
    stop('Input data is missing the necessary "vigor_class" column.')
  }
  
  if(!("species" %in% colnames(data_val))) {
    stop('Input data is missing the necessary "species" column.')
  }
  
  if(!("dbh_cm" %in% colnames(data_val))) {
    stop('Input data is missing the necessary "dbh_cm" column.')
  }
  
  
  ###########################################################
  # Check that column classes are as expected
  ###########################################################
  
  # Categorical variables ------------------------------------------------------
  if(!is.character(data_val$time)) {
    stop('"time" must be a character variable.\n',
         'You have input a variable of class: ', class(data_val$time))
  }
  
  if(!is.character(data_val$site)) {
    stop('"site" must be a character variable.\n',
         'You have input a variable of class: ', class(data_val$site))
  }
  
  if(!is.character(data_val$plot)) {
    stop('"plot" must be a character variable.\n',
         'You have input a variable of class: ', class(data_val$plot))
  }
  
  if(!is.character(data_val$status)) {
    stop('"status" must be a character variable.\n',
         'You have input a variable of class: ', class(data_val$status))
  }
  
  if(!is.character(data_val$vigor_class)) {
    stop('"vigor_class" must be a character variable.\n',
         'You have input a variable of class: ', class(data_val$vigor_class))
  }
  
  if(!is.character(data_val$species)) {
    stop('"species" must be a character variable.\n',
         'You have input a variable of class: ', class(data_val$species))
  }
  
  # Numerical variables --------------------------------------------------------
  if(!is.numeric(data_val$exp_factor)) {
    stop('"exp_factor" must be a numerical variable.\n',
         'You have input a variable of class: ', class(data_val$exp_factor))
  }
  
  if(!is.numeric(data_val$dbh_cm)) {
    stop('"dbh_cm" must be a numerical variable.\n',
         'You have input a variable of class: ', class(data_val$dbh_cm))
  }
  
  
  #########################################################
  # Check that time, site and plot are as expected
  #########################################################
  
  if ('TRUE' %in% is.na(data_val$time)) {
    stop('There are missing values in the time column in the provided dataframe.')
  }
  
  if ('TRUE' %in% is.na(data_val$site)) {
    stop('There are missing values in the site column in the provided dataframe.')
  }
  
  if ('TRUE' %in% is.na(data_val$plot)) {
    stop('There are missing values in the plot column in the provided dataframe.')
  }
  
  
  ##########################################################
  # Check that expansion factor is as expected
  ##########################################################
  
  # Check for NA ---------------------------------------------------------------
  if ('TRUE' %in% is.na(data_val$exp_factor)) {
    stop('There are missing expansion factors in the provided dataframe.\n',
         'For plots with no trees, put 0 for the exp_factor.')
  }
  
  # Check for negative ef ------------------------------------------------------
  if (min(data_val$exp_factor) < 0) {
    stop('There are negative expansion factors in the provided dataframe. All expansion factors must be >= 0.')
  }
  
  # Check for proper use of 0 ef -----------------------------------------------
  data_val$unique_id <- paste0(data_val$time, data_val$site, data_val$plot)
  ids <- unique(data_val$unique_id)
  
  for(d in ids) {
      
    all_trees <- subset(data_val, unique_id == d)
      
    if('TRUE' %in% is.element(all_trees$exp_factor, 0)) {
        
      n <- nrow(all_trees)
        
      if(n > 1) {
          
        stop('There are plots with a recorded expansion factor of 0, but with more than one row.\n',
             'Plots with no trees should be represented by a single row with time, site and plot filled in as appropriate and an exp_factor of 0.')
          
      }
        
    }
      
  }
  
  plots_wo_trees <- subset(data_val, exp_factor == 0, select = c(status, vigor_class, species, dbh_cm, ht_cm))
  
  if('FALSE' %in% is.na(plots_wo_trees)) {
    
    stop('There are plots with a recorded expansion factor of 0, but with non-NA status, vigor_class, species and/or dbh_cm.\n',
         'Plots with no trees should be represented by a single row with time, site and plot filled in as appropriate, an exp_factor of 0,\n',
         'and NA status, vigor_class, species and dbh_cm.')
    
  }
  
  
  ###########################################################
  # Check that status is as expected
  ###########################################################
  
  # Check for unrecognized status codes ----------------------------------------
  if(!all(is.element(data_val$status, c("0","1", NA)))) {
    
    unrecognized_status <- sort(paste0(unique(data_val[!is.element(data_val$status, c("0", "1", NA)), "status"]), sep = " "))
    
    stop('Status must be 0 or 1!\n',
         'Unrecognized status codes: ', unrecognized_status)
  
  }
  
  # Check for NA ---------------------------------------------------------------
  plots_w_trees <- subset(data_val, exp_factor > 0)
  
  if ('TRUE' %in% is.na(plots_w_trees$status)) {
    
    warning('There are missing status codes in the provided dataframe - outside of plots with exp_factor of 0, signifying plots with no trees, which should have NA status.\n',
            'Trees with NA status codes will be assumed to be live and assigned status = 1. Consider investigating these trees.\n',
            ' \n')
    
  }
  
  
  ###########################################################
  # Check that vigor class is as expected
  ###########################################################
  
  # Check for unrecognized vigor codes -----------------------------------------
  if(!all(is.element(data_val$vigor_class, c("0","1","2","3","4","5","6",NA)))) {
    
    unrecognized_vigor <- sort(paste0(unique(data_val[!is.element(data_val$vigor_class, 
                               c("0","1","2","3","4","5","6",NA)), "vigor_class"]), sep = " "))
    
    stop('vigor_class must be 0 through 6!\n',
         'Unrecognized vigor class codes: ', unrecognized_vigor)
    
  }
  
  # Check for vigor code 6 -----------------------------------------------------
  if ("6" %in% data_val$vigor_class) {
    
    warning('There are trees with a vigor class of 6, which means that the tree is down.\n',
            'Trees with vigor class 6 will have NA biomass estimates.\n',
            ' \n')
    
  }
  
  # Check for NA ---------------------------------------------------------------
  if ('TRUE' %in% is.na(plots_w_trees$vigor_class)) {
    
    warning('There are missing vigor class codes in the provided dataframe - outside of plots with exp_factor of 0, signifying plots with no trees, which should have NA vigor class.\n',
            'Dead trees with NA vigor class will be assigned a vigor class of 4.\n',
            ' \n')
    
  }
  
  # Check that status and vigor_class match ------------------------------------
  dead_trees <- subset(data_val, !is.na(data_val$status) & data_val$status == "0" & !is.na(data_val$vigor_class))
  dead_miss <- subset(dead_trees, dead_trees$vigor_class == "0" | dead_trees$vigor_class == "1" | dead_trees$vigor_class == "2" | dead_trees$vigor_class == "3")
  live_trees <- subset(data_val, !is.na(data_val$status) & data_val$status == "1" & !is.na(data_val$vigor_class))
  live_miss <- subset(live_trees, live_trees$vigor_class == "4" | live_trees$vigor_class == "5" | live_trees$vigor_class == "6")
  
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
  # Check that species codes are as expected
  ###########################################################
  
  # Check for unrecognized species codes ---------------------------------------
  sp_code_names <- c("FAGR", "POGR", "ABBA", "FRNI", "TSCA", "BECO", "BEPA", "PRPE", "POTR", "ACRU", "PIRU", "ACSA", "ACPE", "FRAM", "BEAL",
                     "PRSE", "BEPO", "AMSP", "SOAM", "ACSP", "UNKN", "SAPU", "PRVI", NA)
  
  if(!all(is.element(data_val$species, sp_code_names))) {
      
    unrecognized_sp <- sort(paste0(unique(data_val[!is.element(data_val$species, sp_code_names), "species"]), sep = " "))
      
    stop('Not all species codes were recognized!\n',
         'Unrecognized codes: ', unrecognized_sp)
  
  }
  
  # Check for NA ---------------------------------------------------------------
  if ('TRUE' %in% is.na(plots_w_trees$species)) {
    
    warning('There are missing species codes in the provided dataframe - outside of plots with exp_factor of 0, signifying plots with no trees, which should have NA species.\n',
            'Trees with NA species codes will be assigned unknown tree, UNKN. Consider investigating these trees.\n',
            ' \n')
  
  }
  
  
  ###########################################################
  # Check DBH
  ###########################################################
  
  # Check for NA ---------------------------------------------------------------
  if ('TRUE' %in% is.na(plots_w_trees$dbh_cm)) {
    
    warning('There are missing DBH values in the provided dataframe - outside of plots with exp_factor of 0, signifying plots with no trees, which should have NA DBH.\n',
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
  
  data_val$status <- ifelse(is.na(data_val$status), "1", data_val$status)
  data_val$vigor_class <- ifelse(data_val$status == "0" & is.na(data_val$vigor_class), "4", data_val$vigor_class, 
                                 ifelse(data_val$status == "0" & data_val$vigor_class %in% c("0", "1", "2", "3"), "4", data_val$vigor_class))
  data_val$species <- ifelse(is.na(data_val$species), "UNKN", data_val$species)
  
  return_data <- subset(data_val, select = -unique_id)
  
  return(return_data)
  
}

