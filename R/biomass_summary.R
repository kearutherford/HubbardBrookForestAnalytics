
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
  if("forest_type" %in% colnames(internal_hbef_data)) {
    
    fill_df <- data.frame(matrix(nrow = 0, ncol = 9))
    colnames(fill_df) <- c("watershed", "year", "plot", "forest_type", "elev_m", "above_L_Mg_ha", "above_D_Mg_ha", "above_Mg_ha", "leaf_Mg_ha")
    
  } else {
  
    fill_df <- data.frame(matrix(nrow = 0, ncol = 8))
    colnames(fill_df) <- c("watershed", "year", "plot", "elev_m", "above_L_Mg_ha", "above_D_Mg_ha", "above_Mg_ha", "leaf_Mg_ha")
  
  }
  
  # loop through each year, watershed and plot
  watershed_ids <- unique(sum_data$watershed)
  
  for(w in watershed_ids) {
    
    all_years <- subset(sum_data, watershed == w)
    year_ids <- unique(all_years$year)
    
    for(y in year_ids) {
    
      all_plots <- subset(all_years, year == y)
      plot_ids <- unique(all_plots$plot)
    
      for(p in plot_ids) {
      
        all_trees <- subset(all_plots, plot == p)
        
        check1 <- all(all_trees$species == "NONE")
        check2 <- all(all_trees$status == "Dead" & all_trees$vigor == "6")
        check3 <- all(is.na(all_trees$above))
        
        fill_df[nrow(fill_df) + 1, ] <- NA
        n <- nrow(fill_df)
        
        fill_df$watershed[n] <- w
        fill_df$year[n] <- y
        fill_df$plot[n] <- p
        fill_df$elev_m[n] <- all_trees$elev_m[1]
        
        if("forest_type" %in% colnames(internal_hbef_data)) {
          
          fill_df$forest_type[n] <- all_trees$forest_type[1]
          
        }
      
        # if there are no trees in the plot
        # note: if a plot only has dead, vigor 6 trees this is equivalent to a no tree plot 
        if(check1 == "TRUE" | check2 == "TRUE") {
          
          fill_df$above_L_Mg_ha[n] <- 0
          fill_df$above_D_Mg_ha[n] <- 0
          fill_df$above_Mg_ha[n] <- 0
          fill_df$leaf_Mg_ha[n] <- 0
          
          # if there are trees in the plot, but all had NA biomass estimates due to missing data
        } else if (cleck1 == "FALSE" & check2 == "FALSE" & check3 == "TRUE") {
          
          fill_df$above_L_Mg_ha[n] <- NA
          fill_df$above_D_Mg_ha[n] <- NA
          fill_df$above_Mg_ha[n] <- NA
          fill_df$leaf_Mg_ha[n] <- NA
          
          # there are trees in the plot, and not all had NA biomass estimates
        } else if (check1 == "FALSE" & check2 == "FALSE" & check3 == "FALSE") {
          
          live_trees <- subset(all_trees, status == "Live")
          dead_trees <- subset(all_trees, status == "Dead")
          
          fill_df$above_L_Mg_ha[n] <- round(sum(live_trees$above, na.rm = TRUE),5)
          fill_df$above_D_Mg_ha[n] <- round(sum(dead_trees$above, na.rm = TRUE),5)
          fill_df$above_Mg_ha[n] <- round(sum(fill_df$above_L_Mg_ha[n] + fill_df$above_D_Mg_ha[n]),5)
          fill_df$leaf_Mg_ha[n] <- round(sum(live_trees$leaf, na.rm = TRUE),5)
          
        }
      
      }
      
    }
    
  }
  
  return(fill_df)
  
}
