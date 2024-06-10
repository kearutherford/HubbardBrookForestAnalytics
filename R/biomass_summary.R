
################################################################################
################################################################################
# SumBy function
################################################################################
################################################################################

SumBy <- function(sum_data, sum_by) {
  
  # convert to Mg/ha
  sum_data$total_ag <- (sum_data$total_ag_kg/1000)*(1/sum_data$exp_factor)
  sum_data$foliage <- (sum_data$foliage_kg/1000)*(1/sum_data$exp_factor)
  
  # route to the appropriate summary function
  if(sum_by == "by_plot") {
    
    output <- ByPlot(sum_data)
    
  }
  
  return(output)
  
}


################################################################################
################################################################################
# ByPlot function
################################################################################
################################################################################

ByPlot <- function(data) {
  
  # create empty dataframe to fill
  fill_df <- data.frame(matrix(nrow = 0, ncol = 5))
  colnames(fill_df) <- c("time", "site", "plot", "total_ag_Mg_ha", "foliage_Mg_ha")
  
  # loop through each time, site and plot
  times <- unique(data$time)
  
  for(t in times) {
    
    all_sites <- subset(data, time == t)
    site_ids <- unique(all_sites$site)
    
    for(s in site_ids) {
    
      all_plots <- subset(data, site == s)
      plot_ids <- unique(all_plots$plot)
    
      for(p in plot_ids) {
      
        all_trees <- subset(all_plots, plot == p)
        sum_stems <- sum(all_trees$exp_factor)
        alert <- all(all_trees$calc_bio == "N")
        
        fill_df[nrow(fill_df) + 1, ] <- NA
        n <- nrow(fill_df)
        
        fill_df$time[n] <- t
        fill_df$site[n] <- s
        fill_df$plot[n] <- p
      
        # if there are no trees in the plot
        if(sum_stems == 0) {
          
          fill_df[n, 4:5] <- 0
          
          # if there are trees in the plot, but all had NA biomass estimates due to missing data
        } else if (sum_stems > 0 & alert == "TRUE") {
          
          fill_df[n, 4:5] <- NA
          
          # there are trees in the plot, and not all had NA biomass estimates
        } else if (sum_stems > 0 & alert == "FALSE") {
          
          fill_df$total_ag_Mg_ha[n] <- round(sum(all_trees$total_ag, na.rm = TRUE),5)
          fill_df$foliage_Mg_ha[n] <- round(sum(all_trees$foliage, na.rm = TRUE),5)
          
        }
      
      }
      
    }
    
  }
  
  return(fill_df)
  
}
