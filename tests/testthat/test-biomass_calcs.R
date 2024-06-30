
test_that("Dataframes have expected column names", {
  
  expect_named(HBEFBiomass(data_type = "external", 
                           external_data = good_trees_1,
                           results = "by_tree"),
               c("watershed", "year", "plot", "elev_m", "exp_factor", "species", "status", "vigor", "dbh_cm", "ht_cm", "above_kg", "leaf_kg"))
  
  expect_named(HBEFBiomass(data_type = "external", 
                           external_data = good_trees_2,
                           results = "by_tree"),
               c("watershed", "year", "plot", "elev_m", "exp_factor", "species", "status", "vigor", "dbh_cm", "ht_cm", "above_kg", "leaf_kg", "cbh_m", "forest_type"))
  
  expect_named(HBEFBiomass(data_type = "external", 
                           external_data = good_trees_1,
                           results = "by_plot"),
               c("watershed", "year", "plot", "elev_m", "above_L_Mg_ha", "above_D_Mg_ha", "above_Mg_ha", "leaf_Mg_ha"))
  
  expect_named(HBEFBiomass(data_type = "external", 
                           external_data = good_trees_2,
                           results = "by_plot"),
               c("watershed", "year", "plot", "forest_type", "elev_m", "above_L_Mg_ha", "above_D_Mg_ha", "above_Mg_ha", "leaf_Mg_ha"))
  
  expect_named(HBEFBiomass(data_type = "external", 
                           external_data = good_trees_1,
                           results = "by_size"),
               c("watershed", "year", "plot", "elev_m", "sample_class", "above_L_Mg_ha", "above_D_Mg_ha", "above_Mg_ha", "leaf_Mg_ha"))
  
  expect_named(HBEFBiomass(data_type = "external", 
                           external_data = good_trees_2,
                           results = "by_size"),
               c("watershed", "year", "plot", "forest_type", "elev_m", "sample_class", "above_L_Mg_ha", "above_D_Mg_ha", "above_Mg_ha", "leaf_Mg_ha"))
  
})


test_that("Final column classes are as expected", {
  
  by_tree_1 <- HBEFBiomass(data_type = "external", 
                           external_data = good_trees_1,
                           results = "by_tree")
  
  expect_equal(class(by_tree_1$watershed), "character")
  expect_equal(class(by_tree_1$year), "character")
  expect_equal(class(by_tree_1$plot), "character")
  expect_equal(class(by_tree_1$elev_m), "numeric")
  expect_equal(class(by_tree_1$exp_factor), "numeric")
  expect_equal(class(by_tree_1$species), "character")
  expect_equal(class(by_tree_1$status), "character")
  expect_equal(class(by_tree_1$vigor), "character")
  expect_equal(class(by_tree_1$dbh_cm), "numeric")
  expect_equal(class(by_tree_1$ht_cm), "numeric")
  expect_equal(class(by_tree_1$above_kg), "numeric")
  expect_equal(class(by_tree_1$leaf_kg), "numeric")
  
  by_tree_2 <- HBEFBiomass(data_type = "external", 
                           external_data = good_trees_2,
                           results = "by_tree")
  
  expect_equal(class(by_tree_2$watershed), "character")
  expect_equal(class(by_tree_2$year), "character")
  expect_equal(class(by_tree_2$plot), "character")
  expect_equal(class(by_tree_2$elev_m), "numeric")
  expect_equal(class(by_tree_2$exp_factor), "numeric")
  expect_equal(class(by_tree_2$species), "character")
  expect_equal(class(by_tree_2$status), "character")
  expect_equal(class(by_tree_2$vigor), "character")
  expect_equal(class(by_tree_2$dbh_cm), "numeric")
  expect_equal(class(by_tree_2$ht_cm), "numeric")
  expect_equal(class(by_tree_2$above_kg), "numeric")
  expect_equal(class(by_tree_2$leaf_kg), "numeric")
  expect_equal(class(by_tree_2$cbh_m), "numeric")
  expect_equal(class(by_tree_2$forest_type), "character")
  
  by_tree_3 <- HBEFBiomass(data_type = "external", 
                           external_data = good_trees_1,
                           results = "by_plot")
  
  expect_equal(class(by_tree_3$watershed), "character")
  expect_equal(class(by_tree_3$year), "character")
  expect_equal(class(by_tree_3$plot), "character")
  expect_equal(class(by_tree_3$elev_m), "numeric")
  expect_equal(class(by_tree_3$above_L_Mg_ha), "numeric")
  expect_equal(class(by_tree_3$above_D_Mg_ha), "numeric")
  expect_equal(class(by_tree_3$above_Mg_ha), "numeric")
  expect_equal(class(by_tree_3$leaf_Mg_ha), "numeric")
  
  by_tree_4 <- HBEFBiomass(data_type = "external", 
                           external_data = good_trees_2,
                           results = "by_plot")
  
  expect_equal(class(by_tree_4$watershed), "character")
  expect_equal(class(by_tree_4$year), "character")
  expect_equal(class(by_tree_4$plot), "character")
  expect_equal(class(by_tree_4$forest_type), "character")
  expect_equal(class(by_tree_4$elev_m), "numeric")
  expect_equal(class(by_tree_4$above_L_Mg_ha), "numeric")
  expect_equal(class(by_tree_4$above_D_Mg_ha), "numeric")
  expect_equal(class(by_tree_4$above_Mg_ha), "numeric")
  expect_equal(class(by_tree_4$leaf_Mg_ha), "numeric")
  
  by_tree_5 <- HBEFBiomass(data_type = "external", 
                           external_data = good_trees_1,
                           results = "by_size")
  
  expect_equal(class(by_tree_5$watershed), "character")
  expect_equal(class(by_tree_5$year), "character")
  expect_equal(class(by_tree_5$plot), "character")
  expect_equal(class(by_tree_5$elev_m), "numeric")
  expect_equal(class(by_tree_5$sample_class), "character")
  expect_equal(class(by_tree_5$above_L_Mg_ha), "numeric")
  expect_equal(class(by_tree_5$above_D_Mg_ha), "numeric")
  expect_equal(class(by_tree_5$above_Mg_ha), "numeric")
  expect_equal(class(by_tree_5$leaf_Mg_ha), "numeric")
  
  by_tree_6 <- HBEFBiomass(data_type = "external", 
                           external_data = good_trees_2,
                           results = "by_size")
  
  expect_equal(class(by_tree_6$watershed), "character")
  expect_equal(class(by_tree_6$year), "character")
  expect_equal(class(by_tree_6$plot), "character")
  expect_equal(class(by_tree_6$forest_type), "character")
  expect_equal(class(by_tree_6$elev_m), "numeric")
  expect_equal(class(by_tree_6$sample_class), "character")
  expect_equal(class(by_tree_6$above_L_Mg_ha), "numeric")
  expect_equal(class(by_tree_6$above_D_Mg_ha), "numeric")
  expect_equal(class(by_tree_6$above_Mg_ha), "numeric")
  expect_equal(class(by_tree_6$leaf_Mg_ha), "numeric")
  
})


test_that("Summaries are working as expected for external data", {
  
  # NA dbh has NA biomass estimates --------------------------------------------
  expect_warning(sum_1.1 <- HBEFBiomass(data_type = "external", 
                                        external_data = bad_trees_38,
                                        results = "by_tree"))
  
  sum_1.2 <- subset(sum_1.1, watershed == "W5" & year == "1998" & plot == "1" & species == "PIST")
  expect_equal(sum_1.2$above_kg, as.numeric(NA))
  expect_equal(sum_1.2$leaf_kg, as.numeric(NA))
  
  # NA elev has NA biomass estimates -------------------------------------------
  expect_warning(sum_2.1 <- HBEFBiomass(data_type = "external", 
                                        external_data = bad_trees_24,
                                        results = "by_tree"))
  
  sum_2.2 <- subset(sum_2.1, watershed == "W5" & year == "1998" & plot == "1")
  expect_equal(unique(sum_2.2$above_kg), as.numeric(NA))
  expect_equal(unique(sum_2.2$leaf_kg), as.numeric(NA))
  
  # check plots with no trees --------------------------------------------------
  # for by_tree 
  sum_3.1 <- HBEFBiomass(data_type = "external", 
                         external_data = good_trees_1,
                         results = "by_tree")
  
  sum_3.2 <- subset(sum_3.1, species == "NONE")
  expect_equal(sum_3.2$above_kg, 0)
  expect_equal(sum_3.2$leaf_kg, 0)
  
  # for by_plot
  sum_4.1 <- HBEFBiomass(data_type = "external", 
                         external_data = good_trees_1,
                         results = "by_plot")
  
  sum_4.2 <- subset(sum_4.1, watershed == "W6" & year == "1997" & plot == "2")
  expect_equal(sum_4.2$above_L_Mg_ha, 0)
  expect_equal(sum_4.2$above_D_Mg_ha, 0)
  expect_equal(sum_4.2$above_Mg_ha, 0)
  expect_equal(sum_4.2$leaf_Mg_ha, 0)
  
  # for by_size
  sum_5.1 <- HBEFBiomass(data_type = "external", 
                         external_data = good_trees_1,
                         results = "by_size")
  
  sum_5.2 <- subset(sum_5.1, watershed == "W6" & year == "1997" & plot == "2")
  expect_equal(sum_5.2$above_L_Mg_ha, c(0,0))
  expect_equal(sum_5.2$above_D_Mg_ha, c(0,0))
  expect_equal(sum_5.2$above_Mg_ha, c(0,0))
  expect_equal(sum_5.2$leaf_Mg_ha, c(0,0))
  
  # check plots with all NA biomass (bc of all NA elev) ------------------------
  # for by_plot
  expect_warning(sum_6.1 <- HBEFBiomass(data_type = "external", 
                                        external_data = bad_trees_24,
                                        results = "by_plot"))
  
  sum_6.2 <- subset(sum_6.1, watershed == "W5" & year == "1998" & plot == "1")
  expect_equal(sum_6.2$above_L_Mg_ha, as.numeric(NA))
  expect_equal(sum_6.2$above_D_Mg_ha, 0)
  expect_equal(sum_6.2$above_Mg_ha, as.numeric(NA))
  expect_equal(sum_6.2$leaf_Mg_ha, as.numeric(NA))
  
  # for by_size
  expect_warning(sum_7.1 <- HBEFBiomass(data_type = "external", 
                                        external_data = bad_trees_24,
                                        results = "by_size"))
  
  sum_7.2 <- subset(sum_7.1, watershed == "W5" & year == "1998" & plot == "1")
  expect_equal(sum_7.2$above_L_Mg_ha, as.numeric(c(NA,NA)))
  expect_equal(sum_7.2$above_D_Mg_ha, c(0,0))
  expect_equal(sum_7.2$above_Mg_ha, as.numeric(c(NA,NA)))
  expect_equal(sum_7.2$leaf_Mg_ha, as.numeric(c(NA,NA)))
  
  # check plots with all NA biomass (bc of all NA dbh) -------------------------
  # for by_plot
  expect_warning(sum_8.1 <- HBEFBiomass(data_type = "external", 
                                        external_data = bad_trees_40,
                                        results = "by_plot"))
  
  sum_8.2 <- subset(sum_8.1, watershed == "W5" & year == "1998" & plot == "1")
  expect_equal(sum_8.2$above_L_Mg_ha, as.numeric(NA))
  expect_equal(sum_8.2$above_D_Mg_ha, 0)
  expect_equal(sum_8.2$above_Mg_ha, as.numeric(NA))
  expect_equal(sum_8.2$leaf_Mg_ha, as.numeric(NA))
  
  # for by_size
  expect_warning(sum_9.1 <- HBEFBiomass(data_type = "external", 
                                        external_data = bad_trees_40,
                                        results = "by_size"))
  
  sum_9.2 <- subset(sum_9.1, watershed == "W5" & year == "1998" & plot == "1")
  expect_equal(sum_9.2$above_L_Mg_ha, as.numeric(c(NA,NA)))
  expect_equal(sum_9.2$above_D_Mg_ha, as.numeric(c(NA,NA)))
  expect_equal(sum_9.2$above_Mg_ha, as.numeric(c(NA,NA)))
  expect_equal(sum_9.2$leaf_Mg_ha, as.numeric(c(NA,NA)))
  
  # check plots with some NA biomass estimates ---------------------------------
  # for by_plot
  expect_warning(sum_10.1 <- HBEFBiomass(data_type = "external", 
                                         external_data = bad_trees_38,
                                         results = "by_plot"))
  
  sum_10.2 <- subset(sum_10.1, watershed == "W5" & year == "1998" & plot == "1")
  expect_equal(is.na(sum_10.2$above_L_Mg_ha), FALSE)
  expect_equal(is.na(sum_10.2$above_D_Mg_ha), FALSE)
  expect_equal(is.na(sum_10.2$above_Mg_ha), FALSE)
  expect_equal(is.na(sum_10.2$leaf_Mg_ha), FALSE)
  
  # for by_size
  expect_warning(sum_11.1 <- HBEFBiomass(data_type = "external", 
                                         external_data = bad_trees_38,
                                         results = "by_size"))
  
  sum_11.2 <- subset(sum_11.1, watershed == "W5" & year == "1998" & plot == "1")
  expect_equal(is.na(sum_11.2$above_L_Mg_ha), c(FALSE,FALSE))
  expect_equal(is.na(sum_11.2$above_D_Mg_ha), c(FALSE,FALSE))
  expect_equal(is.na(sum_11.2$above_Mg_ha), c(FALSE,FALSE))
  expect_equal(is.na(sum_11.2$leaf_Mg_ha), c(FALSE,FALSE))
  
  # check plots with no live (and no dead) trees -------------------------------
  # for by_plot
  sum_12.1 <- HBEFBiomass(data_type = "external", 
                          external_data = good_trees_1,
                          results = "by_plot")
  
  sum_12.2 <- subset(sum_12.1, watershed == "W5" & year == "1998" & plot == "1")
  expect_equal(sum_12.2$above_L_Mg_ha > 0, TRUE)
  expect_equal(sum_12.2$above_D_Mg_ha, 0)
  expect_equal(sum_12.2$above_Mg_h > 0, TRUE)
  expect_equal(sum_12.2$leaf_Mg_ha > 0, TRUE)
  
  sum_12.3 <- subset(sum_12.1, watershed == "W5" & year == "2002" & plot == "2")
  expect_equal(sum_12.3$above_L_Mg_ha, 0)
  expect_equal(sum_12.3$above_D_Mg_ha > 0, TRUE)
  expect_equal(sum_12.3$above_Mg_h > 0, TRUE)
  expect_equal(sum_12.3$leaf_Mg_ha, 0)
  
  # for by_size
  sum_13.1 <- HBEFBiomass(data_type = "external", 
                          external_data = good_trees_1,
                          results = "by_size")
  
  sum_13.2 <- subset(sum_13.1, watershed == "W5" & year == "1998" & plot == "1")
  expect_equal(all(sum_13.2$above_L_Mg_ha > 0), TRUE)
  expect_equal(sum_13.2$above_D_Mg_ha, c(0,0))
  expect_equal(all(sum_13.2$above_Mg_h > 0), TRUE)
  expect_equal(all(sum_13.2$leaf_Mg_ha > 0), TRUE)
  
  sum_13.3 <- subset(sum_13.1, watershed == "W5" & year == "2002" & plot == "2")
  expect_equal(sum_13.3$above_L_Mg_ha, c(0,0))
  expect_equal(all(sum_13.3$above_D_Mg_ha > 0), TRUE)
  expect_equal(all(sum_13.3$above_Mg_h > 0), TRUE)
  expect_equal(sum_13.3$leaf_Mg_ha, c(0,0))
  
  # check plots with no trees (and no saps) ------------------------------------
  sum_14.1 <- HBEFBiomass(data_type = "external", 
                          external_data = good_trees_3,
                          results = "by_size")
  
  sum_14.2 <- subset(sum_14.1, watershed == "W5" & year == "1998" & plot == "1" & sample_class == "tree")
  expect_equal(sum_14.2$above_L_Mg_ha, 0)
  expect_equal(sum_14.2$above_D_Mg_ha, 0)
  expect_equal(sum_14.2$above_Mg_ha, 0)
  expect_equal(sum_14.2$leaf_Mg_ha, 0)
  
  sum_14.3 <- subset(sum_14.1, watershed == "W5" & year == "1998" & plot == "2" & sample_class == "sapling")
  expect_equal(sum_14.3$above_L_Mg_ha, 0)
  expect_equal(sum_14.3$above_D_Mg_ha, 0)
  expect_equal(sum_14.3$above_Mg_ha, 0)
  expect_equal(sum_14.3$leaf_Mg_ha, 0)
  
})


test_that("Summaries are working as expected for internal data", {

  plot_check <- HBEFBiomass(data_type = "internal", 
                            results = "by_plot")
  
  size_check <- HBEFBiomass(data_type = "internal", 
                            results = "by_size")
  
  # check plots with no live or dead trees or saps -----------------------------
  # for by_plot
  intern_check_1 <- subset(plot_check, watershed == "W5" & year == "1990" & plot == "6")
  expect_equal(intern_check_1$above_L_Mg_ha, 0)
  expect_equal(intern_check_1$above_D_Mg_ha, 0)
  expect_equal(intern_check_1$above_Mg_h, 0)
  expect_equal(intern_check_1$leaf_Mg_ha, 0)
  
  # for by_size
  intern_check_2 <- subset(size_check, watershed == "W5" & year == "1990" & plot == "6")
  expect_equal(intern_check_2$above_L_Mg_ha, c(0,0))
  expect_equal(intern_check_2$above_D_Mg_ha, c(0,0))
  expect_equal(intern_check_2$above_Mg_h, c(0,0))
  expect_equal(intern_check_2$leaf_Mg_ha, c(0,0))
  
  # check plots with no dead trees/saps (but with live trees/saps) -------------
  # for by_plot
  intern_check_3 <- subset(plot_check, watershed == "W6" & year == "1965" & plot == "23")
  expect_equal(intern_check_3$above_L_Mg_ha > 0, TRUE)
  expect_equal(intern_check_3$above_D_Mg_ha, 0)
  expect_equal(intern_check_3$above_Mg_h > 0, TRUE)
  expect_equal(intern_check_3$leaf_Mg_ha > 0, TRUE)
  
  # for by_size
  intern_check_4 <- subset(size_check, watershed == "W6" & year == "1965" & plot == "23")
  expect_equal(all(intern_check_4$above_L_Mg_ha > 0), TRUE)
  expect_equal(intern_check_4$above_D_Mg_ha, c(0,0))
  expect_equal(all(intern_check_4$above_Mg_h > 0), TRUE)
  expect_equal(all(intern_check_4$leaf_Mg_ha > 0), TRUE)
  
  # check plots with no trees (but with saps) ----------------------------------
  intern_check_5 <- subset(size_check, watershed == "W5" & year == "1990" & plot == "1" & sample_class == "tree")
  expect_equal(intern_check_5$above_L_Mg_ha, 0)
  expect_equal(intern_check_5$above_D_Mg_ha, 0)
  expect_equal(intern_check_5$above_Mg_h, 0)
  expect_equal(intern_check_5$leaf_Mg_ha, 0)
  
})


test_that("There are no NA biomass estimates for internal data", {
  
  # for by_tree
  missing_check_1 <- HBEFBiomass(data_type = "internal", 
                                 results = "by_tree")
  
  expect_equal(all(!is.na(missing_check_1$above_kg)), TRUE)
  expect_equal(all(!is.na(missing_check_1$leaf_kg)), TRUE)
  
  # for by_plot
  missing_check_2 <- HBEFBiomass(data_type = "internal", 
                                 results = "by_plot")
  
  expect_equal(all(!is.na(missing_check_2$above_L_Mg_ha)), TRUE)
  expect_equal(all(!is.na(missing_check_2$above_D_Mg_ha)), TRUE)
  expect_equal(all(!is.na(missing_check_2$above_Mg_ha)), TRUE)
  expect_equal(all(!is.na(missing_check_2$leaf_Mg_ha)), TRUE)
  
  # for by_size
  missing_check_3 <- HBEFBiomass(data_type = "internal", 
                                 results = "by_size")
  
  expect_equal(all(!is.na(missing_check_3$above_L_Mg_ha)), TRUE)
  expect_equal(all(!is.na(missing_check_3$above_D_Mg_ha)), TRUE)
  expect_equal(all(!is.na(missing_check_3$above_Mg_ha)), TRUE)
  expect_equal(all(!is.na(missing_check_3$leaf_Mg_ha)), TRUE)
  
})

