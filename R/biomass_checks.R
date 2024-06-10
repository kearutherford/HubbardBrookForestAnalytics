
################################################################################
################################################################################
# Top-level function
################################################################################
################################################################################

Biomass <- function(data_type = "internal", external_data, results = "by_plot") {
  
  # check that options are set appropriately 
  ValidateOptions(data_type_val = data_type, results_val = results)
  
  # check and prep input data, if external 
  if(data_type == "internal") {
    
    step1 <- internal_hbef_data
    
  } else {
  
    step1 <- ValidateExternal(ext_data_val = external_data)
  
  }
  
  # calculate biomass
  step2 <- PredictBiomass(data = step1)
  
  # compile to the plot level, if desired
  if(results == "by_tree") {

    return(step2)
    
  } else {
    
    step3 <- SumBy(sum_data = step2, sum_by = results)
    return(step3)
    
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
# ValidateNSVB function
################################################################################
################################################################################

ValidateNSVB <- function(ext_data_val) {
  
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
  
  if(!("decay_class" %in% colnames(data_val))) {
    stop('Input data is missing the necessary "decay_class" column.')
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
  
  if(!is.character(data_val$decay_class)) {
    stop('"decay_class" must be a character variable.\n',
         'You have input a variable of class: ', class(data_val$decay_class))
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
  # check that site and plot are as expected
  #########################################################
  
  if ('TRUE' %in% is.na(data_val$time)) {
    stop('There are missing time names in the provided dataframe.')
  }
  
  if ('TRUE' %in% is.na(data_val$site)) {
    stop('There are missing site names in the provided dataframe.')
  }
  
  if ('TRUE' %in% is.na(data_val$plot)) {
    stop('There are missing plot names in the provided dataframe.')
  }
  
  
  ##########################################################
  # check that expansion factor is as expected
  ##########################################################
  
  # Check for NA ---------------------------------------------------------------
  if ('TRUE' %in% is.na(data_val$exp_factor)) {
    stop('There are missing expansion factors in the provided dataframe.\n',
         'For plots with no trees, put 0 for the exp_factor.')
  }
  
  # Check for negative ef ------------------------------------------------------{
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
             'Plots with no trees should be represented by a single row with site and plot filled in as appropriate and an exp_factor of 0.')
          
      }
        
    }
      
  }
  
  plots_wo_trees <- subset(data_val, exp_factor == 0,
                           select = c(status, decay_class, species, dbh_cm, ht_cm))
  
  if('FALSE' %in% is.na(plots_wo_trees)) {
    
    stop('There are plots with a recorded expansion factor of 0, but with non-NA status, decay_class, species, dbh_cm and/or ht_cm.\n',
         'Plots with no trees should be represented by a single row with site and plot filled in as appropriate, an exp_factor of 0,\n',
         'and NA status, decay_class, species, dbh_cm and ht_cm.')
    
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
            'Trees with NA status codes will be assumed to be alive (status = 1). Consider investigating these trees.\n',
            ' \n')
  }
  
  
  ###########################################################
  # Check that decay class is as expected
  ###########################################################
  
  # Check for unrecognized decay codes -----------------------------------------
  if(!all(is.element(data_val$decay_class,
                     c("0","1","2","3","4","5",NA)))) {
    
    unrecognized_decay <- sort(paste0(unique(data_val[!is.element(data_val$decay_class,
                                                                  c("0","1","2","3","4","5",NA)), "decay_class"]),
                                      sep = " "))
    
    stop('decay_class must be 0 through 5!\n',
         'Unrecognized decay class codes: ', unrecognized_decay)
  }
  
  
  # Check that status and decay_class match ------------------------------------
  dead_trees <- subset(data_val, !is.na(data_val$status) & data_val$status == "0")
  dead_miss <- subset(dead_trees, is.na(dead_trees$decay_class) | dead_trees$decay_class == "0")
  live_trees <- subset(data_val, !is.na(data_val$status) & data_val$status == "1")
  live_miss <- subset(live_trees, !is.na(live_trees$decay_class) & live_trees$decay_class != "0")
  
  if (nrow(dead_miss) > 0) {
    
    warning('There are dead trees with NA and/or 0 decay class codes.\n',
            'These trees will be assigned a decay class of 3.\n',
            'Consider investigating these trees with mismatched status/decay class.\n',
            ' \n')
    
  }
  
  if (nrow(live_miss) > 0) {
    
    warning('There are live trees with 1-5 decay class codes.\n',
            'Live trees should have decay class codes of NA or 0.\n',
            'These trees will still be considered live in the biomass/carbon calculations.\n',
            'But you should consider investigating these trees with mismatched status/decay class.\n',
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
            'Trees with NA species codes will be assigned unknown tree. Consider investigating these trees.\n',
            ' \n')
  }
  
  
  ###########################################################
  # Check DBH
  ###########################################################
  
  if ('TRUE' %in% is.na(plots_w_trees$dbh_cm)) {
    
    warning('There are missing DBH values in the provided dataframe - outside of plots with exp_factor of 0, signifying plots with no trees, which should have NA dbh.\n',
            'Trees with NA DBH will have NA biomass estimates. Consider investigating these trees.\n',
            ' \n')
  }
  
  # assign missing status Live
  # assign missing decay
  # assign missing species UNTR 
  
}


