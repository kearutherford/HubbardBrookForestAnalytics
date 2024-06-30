
SumBy <- function(data, sum_by) {
  
  # convert to Mg/ha
  data$above <- (data$above_kg/1000)*data$exp_factor
  data$leaf <- (data$leaf_kg/1000)*data$exp_factor
  
  # route to the appropriate summary function
  if(sum_by == "by_plot") {
    output <- ByPlot(sum_data = data)
  } else if(sum_by == "by_size") {
    output <- BySize(sum_data = data)
  } 
  
  return(output)
  
}


ByPlot <- function(sum_data) {
  
  # create empty dataframe to fill
  if("forest_type" %in% colnames(sum_data)) {
    
    fill_df <- data.frame(matrix(nrow = 0, ncol = 9))
    colnames(fill_df) <- c("watershed", "year", "plot", "forest_type", "elev_m", "above_L_Mg_ha", "above_D_Mg_ha", "above_Mg_ha", "leaf_Mg_ha")
    
  } else {
  
    fill_df <- data.frame(matrix(nrow = 0, ncol = 8))
    colnames(fill_df) <- c("watershed", "year", "plot", "elev_m", "above_L_Mg_ha", "above_D_Mg_ha", "above_Mg_ha", "leaf_Mg_ha")
  
  }
  
  # loop through each watershed, year and plot
  sum_data$water_year_plot <- paste(sum_data$watershed, sum_data$year, sum_data$plot, sep = "_")
  unq_ids <- unique(sum_data$water_year_plot)
    
  for(u in unq_ids) {
      
      all_trees <- subset(sum_data, water_year_plot == u)
        
      fill_df[nrow(fill_df) + 1, ] <- NA
      n <- nrow(fill_df)
        
      fill_df$watershed[n] <- all_trees$watershed[1]
      fill_df$year[n] <- all_trees$year[1]
      fill_df$plot[n] <- all_trees$plot[1]
      fill_df$elev_m[n] <- all_trees$elev_m[1]
        
      if("forest_type" %in% colnames(sum_data)) {
        fill_df$forest_type[n] <- all_trees$forest_type[1]
      }
      
      live_trees <- subset(all_trees, status == "Live" | species == "NONE")
      dead_trees <- subset(all_trees, status == "Dead" | species == "NONE")
      
      fill_df$above_L_Mg_ha[n] <- round(ifelse(nrow(live_trees) == 0, 0,
                                        ifelse(all(is.na(live_trees$above)), NA, 
                                        sum(live_trees$above, na.rm = TRUE))),5)
        
      fill_df$above_D_Mg_ha[n] <- round(ifelse(nrow(dead_trees) == 0, 0,
                                        ifelse(all(is.na(dead_trees$above)), NA, 
                                        sum(dead_trees$above, na.rm = TRUE))),5)
        
      fill_df$above_Mg_ha[n] <- sum(fill_df$above_L_Mg_ha[n] + fill_df$above_D_Mg_ha[n])
        
      fill_df$leaf_Mg_ha[n] <- round(ifelse(nrow(live_trees) == 0, 0,
                                     ifelse(all(is.na(live_trees$leaf)), NA, 
                                     sum(live_trees$leaf, na.rm = TRUE))),5)
      
  }
  
  return(fill_df)
  
}


BySize <- function(sum_data) {
  
  # create empty dataframe to fill
  if("forest_type" %in% colnames(sum_data)) {
    
    fill_df <- data.frame(matrix(nrow = 0, ncol = 10))
    colnames(fill_df) <- c("watershed", "year", "plot", "forest_type", "elev_m", "sample_class", "above_L_Mg_ha", "above_D_Mg_ha", "above_Mg_ha", "leaf_Mg_ha")
    
  } else {
    
    fill_df <- data.frame(matrix(nrow = 0, ncol = 9))
    colnames(fill_df) <- c("watershed", "year", "plot", "elev_m", "sample_class", "above_L_Mg_ha", "above_D_Mg_ha", "above_Mg_ha", "leaf_Mg_ha")
    
  }
  
  # loop through each watershed, year, plot, and sampling class
  sum_data$water_year_plot <- paste(sum_data$watershed, sum_data$year, sum_data$plot, sep = "_")
  unq_ids <- unique(sum_data$water_year_plot)
  
  for(u in unq_ids) {
    
    all_trees <- subset(sum_data, water_year_plot == u)
    
    for(s in c("sapling", "tree")) {
      
      fill_df[nrow(fill_df) + 1, ] <- NA
      n <- nrow(fill_df)
      
      fill_df$watershed[n] <- all_trees$watershed[1]
      fill_df$year[n] <- all_trees$year[1]
      fill_df$plot[n] <- all_trees$plot[1]
      fill_df$elev_m[n] <- all_trees$elev_m[1]
      fill_df$sample_class[n] <- s
          
      if("forest_type" %in% colnames(sum_data)) {
        fill_df$forest_type[n] <- all_trees$forest_type[1]
      }
      
      if (all(is.na(all_trees$dbh_cm)) & !all(all_trees$species == "NONE")) {
        
        fill_df$above_L_Mg_ha[n] <- NA
        fill_df$above_D_Mg_ha[n] <- NA
        fill_df$above_Mg_ha[n] <- NA
        fill_df$leaf_Mg_ha[n] <- NA
        
      } else { 
        
        all_class <- subset(all_trees, sample_class == s)
        
        if(nrow(all_class) > 0) {
                
          live_trees <- subset(all_class, status == "Live" | species == "NONE")
          dead_trees <- subset(all_class, status == "Dead" | species == "NONE")
                
          fill_df$above_L_Mg_ha[n] <- round(ifelse(nrow(live_trees) == 0, 0,
                                            ifelse(all(is.na(live_trees$above)), NA, 
                                            sum(live_trees$above, na.rm = TRUE))),5)
  
          fill_df$above_D_Mg_ha[n] <- round(ifelse(nrow(dead_trees) == 0, 0,
                                            ifelse(all(is.na(dead_trees$above)), NA, 
                                            sum(dead_trees$above, na.rm = TRUE))),5)
                  
          fill_df$above_Mg_ha[n] <- sum(fill_df$above_L_Mg_ha[n] + fill_df$above_D_Mg_ha[n])
                
          fill_df$leaf_Mg_ha[n] <- round(ifelse(nrow(live_trees) == 0, 0,
                                         ifelse(all(is.na(live_trees$leaf)), NA, 
                                         sum(live_trees$leaf, na.rm = TRUE))),5)
          
        } else {
              
          fill_df$above_L_Mg_ha[n] <- 0
          fill_df$above_D_Mg_ha[n] <- 0
          fill_df$above_Mg_ha[n] <- 0
          fill_df$leaf_Mg_ha[n] <- 0
              
        }
          
      }
      
    }
    
  }
  
  return(fill_df)
  
}

