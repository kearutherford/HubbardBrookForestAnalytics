
SumByPlot <- function(data, data_type_input) {
  
  # convert to Mg/ha
  data$above <- (data$above_kg/1000)*data$exp_factor
  data$leaf <- (data$leaf_kg/1000)*data$exp_factor
  
  # create empty dataframe to fill
  if(data_type_input == "internal") {
    
    fill_df <- data.frame(matrix(nrow = 0, ncol = 8))
    colnames(fill_df) <- c("watershed", "year", "plot", "forest_type", "elev_m", "elev_band", "above_Mg_ha", "leaf_Mg_ha")
    
  } else {
  
    fill_df <- data.frame(matrix(nrow = 0, ncol = 5))
    colnames(fill_df) <- c("watershed", "year", "plot", "above_Mg_ha", "leaf_Mg_ha")
  
  }
  
  # loop through each year, watershed and plot
  watershed_ids <- unique(data$watershed)
  
  for(w in watershed_ids) {
    
    all_years <- subset(data, watershed == w)
    year_ids <- unique(all_years$year)
    
    for(y in year_ids) {
    
      all_plots <- subset(all_years, year == y)
      plot_ids <- unique(all_plots$plot)
    
      for(p in plot_ids) {
      
        all_trees <- subset(all_plots, plot == p)
        sum_stems <- sum(all_trees$exp_factor)
        alert <- all(is.na(all_trees$above) & is.na(all_trees$leaf))
        
        fill_df[nrow(fill_df) + 1, ] <- NA
        n <- nrow(fill_df)
        
        fill_df$watershed[n] <- w
        fill_df$year[n] <- y
        fill_df$plot[n] <- p
        
        if(data_type_input == "internal") {
          
          fill_df$forest_type[n] <- all_trees$forest_type[1]
          fill_df$elev_m[n] <- all_trees$elev_m[1]
          fill_df$elev_band[n] <- all_trees$elev_band[1]
          
        }
      
        # if there are no trees in the plot
        if(sum_stems == 0) {
          
          fill_df$above_Mg_ha[n] <- 0
          fill_df$leaf_Mg_ha[n] <- 0
          
          # if there are trees in the plot, but all had NA biomass estimates due to missing data
        } else if (sum_stems > 0 & alert == "TRUE") {
          
          fill_df$above_Mg_ha[n] <- NA
          fill_df$leaf_Mg_ha[n] <- NA
          
          # there are trees in the plot, and not all had NA biomass estimates
        } else if (sum_stems > 0 & alert == "FALSE") {
          
          fill_df$above_Mg_ha[n] <- round(sum(all_trees$above, na.rm = TRUE),5)
          fill_df$leaf_Mg_ha[n] <- round(sum(all_trees$leaf, na.rm = TRUE),5)
          
        }
      
      }
      
    }
    
  }
  
  return(fill_df)
  
}
