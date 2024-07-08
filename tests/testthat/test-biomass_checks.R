
test_that("Invalid settings throw an error", {
  
  expect_error(HBEFBiomass(data_type = "intern", # intentional error here 
                           results = "by_plot"),
              'The "data_type" parameter must be set to either "internal" or "external".')
  
  expect_error(HBEFBiomass(data_type = "internal",
                           results = "by_pt"), # intentional error here 
              'The "results" parameter must be set to "by_tree", "by_plot" or "by_size".')
  
})


test_that("Properly formatted external dataframes throw no errors, warnings, or messages", {
  
  expect_no_error(HBEFBiomass(data_type = "external", 
                              external_data = good_trees_1,
                              results = "by_plot"))
  
  expect_no_warning(HBEFBiomass(data_type = "external", 
                                external_data = good_trees_1,
                                results = "by_plot"))
  
  expect_no_message(HBEFBiomass(data_type = "external", 
                                external_data = good_trees_1,
                                results = "by_plot"))
  
})


test_that("Missing columns throw an error", {
  
  expect_error(HBEFBiomass(data_type = "external", 
                           external_data = bad_trees_1,
                           results = "by_plot"),
               'Input data is missing the necessary "watershed" column.')
  
  expect_error(HBEFBiomass(data_type = "external", 
                           external_data = bad_trees_2,
                           results = "by_plot"),
               'Input data is missing the necessary "year" column.')
  
  expect_error(HBEFBiomass(data_type = "external", 
                           external_data = bad_trees_3,
                           results = "by_plot"),
               'Input data is missing the necessary "plot" column.')
  
  expect_error(HBEFBiomass(data_type = "external", 
                           external_data = bad_trees_4,
                           results = "by_plot"),
               'Input data is missing the necessary "elev_m" column.')
  
  expect_error(HBEFBiomass(data_type = "external", 
                           external_data = bad_trees_5,
                           results = "by_plot"),
               'Input data is missing the necessary "exp_factor" column.')
  
  expect_error(HBEFBiomass(data_type = "external", 
                           external_data = bad_trees_6,
                           results = "by_plot"),
               'Input data is missing the necessary "species" column.')
  
  expect_error(HBEFBiomass(data_type = "external", 
                           external_data = bad_trees_7,
                           results = "by_plot"),
               'Input data is missing the necessary "status" column.')
  
  expect_error(HBEFBiomass(data_type = "external", 
                           external_data = bad_trees_8,
                           results = "by_plot"),
               'Input data is missing the necessary "vigor" column.')
  
  expect_error(HBEFBiomass(data_type = "external", 
                           external_data = bad_trees_9,
                           results = "by_plot"),
               'Input data is missing the necessary "dbh_cm" column.')
  
})


test_that("Column class handling works", {
  
  expect_error(HBEFBiomass(data_type = "external", 
                           external_data = bad_trees_10,
                           results = "by_plot"),
               '"watershed" must be a character variable.\nYou have input a variable of class: numeric')
  
  expect_error(HBEFBiomass(data_type = "external", 
                           external_data = bad_trees_11,
                           results = "by_plot"),
               '"year" must be a character variable.\nYou have input a variable of class: numeric')
  
  expect_error(HBEFBiomass(data_type = "external", 
                           external_data = bad_trees_12,
                           results = "by_plot"),
               '"plot" must be a character variable.\nYou have input a variable of class: numeric')
  
  expect_error(HBEFBiomass(data_type = "external", 
                           external_data = bad_trees_13,
                           results = "by_plot"),
               '"elev_m" must be a numerical variable.\nYou have input a variable of class: character')
  
  expect_error(HBEFBiomass(data_type = "external", 
                           external_data = bad_trees_14,
                           results = "by_plot"),
               '"exp_factor" must be a numerical variable.\nYou have input a variable of class: character')
  
  expect_error(HBEFBiomass(data_type = "external", 
                           external_data = bad_trees_15,
                           results = "by_plot"),
               '"species" must be a character variable.\nYou have input a variable of class: numeric')
  
  expect_error(HBEFBiomass(data_type = "external", 
                           external_data = bad_trees_16,
                           results = "by_plot"),
               '"status" must be a character variable.\nYou have input a variable of class: numeric')
  
  expect_error(HBEFBiomass(data_type = "external", 
                           external_data = bad_trees_17,
                           results = "by_plot"),
               '"vigor" must be a character variable.\nYou have input a variable of class: numeric')
  
  expect_error(HBEFBiomass(data_type = "external", 
                           external_data = bad_trees_18,
                           results = "by_plot"),
               '"dbh_cm" must be a numerical variable.\nYou have input a variable of class: character')
  
})


test_that("NA handling works for watershed, year and plot columns", {
  
  expect_error(HBEFBiomass(data_type = "external", 
                           external_data = bad_trees_19,
                           results = "by_plot"),
               'There are missing values in the watershed column in the provided dataframe.')
  
  expect_error(HBEFBiomass(data_type = "external", 
                           external_data = bad_trees_20,
                           results = "by_plot"),
               'There are missing values in the year column in the provided dataframe.')
  
  expect_error(HBEFBiomass(data_type = "external", 
                           external_data = bad_trees_21,
                           results = "by_plot"),
               'There are missing values in the plot column in the provided dataframe.')
  
})


test_that("Expansion factor handling works", {
  
  expect_error(HBEFBiomass(data_type = "external", 
                           external_data = bad_trees_22,
                           results = "by_plot"),
               'There are missing expansion factors in the provided dataframe.')
  
  expect_error(HBEFBiomass(data_type = "external", 
                           external_data = bad_trees_23,
                           results = "by_plot"),
               'There are negative expansion factors in the provided dataframe. All expansion factors must be >= 0.')
  
})


test_that("Elevation handling works", {
  
  expect_error(HBEFBiomass(data_type = "external", 
                           external_data = bad_trees_24,
                           results = "by_plot"),
              'There are missing elevations in the provided dataframe.')
  
  expect_error(HBEFBiomass(data_type = "external", 
                           external_data = bad_trees_25,
                           results = "by_plot"),
               'There are negative elevations in the provided dataframe. All elevation values must be >= 0.')
  
  expect_error(HBEFBiomass(data_type = "external", 
                           external_data = bad_trees_26,
                           results = "by_plot"),
               'Each watershed:year:plot should have the same elevation recorded.\nThe following watershed:year:plot combinations have multiple elev_m values: W5_1998_1   W5_1998_2')
  
})


test_that("Forest type handling works", {
  
  expect_error(HBEFBiomass(data_type = "external", 
                           external_data = bad_trees_27,
                           results = "by_plot"),
               'Each watershed:year:plot should have the same forest type recorded.\nThe following watershed:year:plot combinations have multiple forest types recorded: W5_1998_1')
  
})


test_that("Species code handling works", {
  
  expect_error(HBEFBiomass(data_type = "external", 
                           external_data = bad_trees_28,
                           results = "by_plot"),
                 'Not all species codes were recognized!\nUnrecognized codes: BEPAA FAAGR ')
  
  expect_warning(HBEFBiomass(data_type = "external", 
                             external_data = bad_trees_29,
                             results = "by_plot"),
                 'There are missing species codes in the provided dataframe. Trees with NA species codes will be assigned unknown tree, UNKN. Consider investigating these trees.\n')
  
  expect_error(HBEFBiomass(data_type = "external", 
                           external_data = bad_trees_30,
                           results = "by_plot"),
               'There are plots with a recorded species code of NONE, but with more than one row.\nPlots with no trees or saplings should be represented by a single row with watershed, year, plot, exp_factor, elev_m, and forest_type filled in as appropriate and a species code of NONE.')
  
  expect_error(HBEFBiomass(data_type = "external", 
                           external_data = bad_trees_31,
                           results = "by_plot"),
               'There are plots with a recorded species code of NONE, but with non-NA status, vigor and/or dbh_cm.\nPlots with no trees or saplings should be represented by a single row with watershed, year, plot, exp_factor, elev_m, and forest_type filled in as appropriate, a species code of NONE,\nand NA status, vigor and/or dbh_cm.')
  
})


test_that("Status code handling works", {
  
  expect_error(HBEFBiomass(data_type = "external", 
                           external_data = bad_trees_32,
                           results = "by_plot"),
               'Status must be Dead or Live!\nUnrecognized status codes: Livee ')
  
  expect_warning(HBEFBiomass(data_type = "external", 
                             external_data = bad_trees_33,
                             results = "by_plot"),
                 'There are missing status codes in the provided dataframe - outside of plots with species = NONE, signifying plots with no trees or saplings, which should have NA status.\nTrees with NA status codes will be assumed to be live. Consider investigating these trees.\n')
  
})


test_that("Vigor code handling works", {
  
  expect_error(HBEFBiomass(data_type = "external", 
                           external_data = bad_trees_34,
                           results = "by_plot"),
               'vigor must be 0 through 5!\nUnrecognized vigor codes: ')
  
  expect_warning(HBEFBiomass(data_type = "external", 
                             external_data = bad_trees_35,
                             results = "by_plot"),
                 'There are missing vigor codes in the provided dataframe - outside of plots with species = NONE, signifying plots with no trees, which should have NA vigor.\nDead trees with NA vigor will be assigned a vigor of 4.\n')
  
  expect_warning(HBEFBiomass(data_type = "external", 
                             external_data = bad_trees_36,
                             results = "by_plot"),
                 'There are dead trees with 0-3 vigor codes.\nThese trees will be assigned a vigor of 4.\nConsider investigating these trees with mismatched status/vigor.\n')
  
  expect_warning(HBEFBiomass(data_type = "external", 
                             external_data = bad_trees_37,
                             results = "by_plot"),
                 'There are live trees with 4-5 vigor codes.\nLive trees should have vigor codes of 0-3.\nThese trees will still be considered live in the biomass calculations.\nBut you should consider investigating these trees with mismatched status/vigor.\n')
  
})


test_that("DBH handling works", {
  
  expect_warning(HBEFBiomass(data_type = "external", 
                             external_data = bad_trees_38,
                             results = "by_plot"),
                 'There are missing DBH values in the provided dataframe - outside of plots with species = NONE, signifying plots with no trees, which should have NA DBH.\nTrees with NA DBH will have NA biomass estimates. Consider investigating these trees.\n')
  
  expect_error(HBEFBiomass(data_type = "external", 
                           external_data = bad_trees_39,
                           results = "by_plot"),
               'There are DBH values < 2 in the provided dataframe. All DBH values must be >= 2 cm.')
  
})


test_that("Filling in missing/incorect values is working as expected", {
  
  # missing species is given "UNKN"
  expect_warning(check_1.1 <- HBEFBiomass(data_type = "external", 
                                          external_data = bad_trees_29,
                                          results = "by_tree"))
  
  check_1.2 <- subset(check_1.1, watershed == "W5" & year == "1998" & plot == "1" & species != "BEPA" & species != "FAGR")
  expect_equal(check_1.2$species, "UNKN")
  
  # missing status is given "Live"
  expect_warning(check_2.1 <- HBEFBiomass(data_type = "external", 
                                          external_data = bad_trees_33,
                                          results = "by_tree"))
  
  check_2.2 <- subset(check_2.1, watershed == "W5" & year == "1998" & plot == "1" & species == "PIST")
  expect_equal(check_2.2$status, "Live")
  
  check_2.3 <- subset(check_2.1, species == "NONE")
  expect_equal(check_2.3$status, as.character(NA))
  
  # dead tree with missing vigor is given "4"
  expect_warning(check_3.1 <- HBEFBiomass(data_type = "external", 
                                          external_data = bad_trees_35,
                                          results = "by_tree"))
  
  check_3.2 <- subset(check_3.1, watershed == "W5" & year == "1998" & plot == "2" & species == "ACPE")
  expect_equal(check_3.2$vigor, "4")
  
  check_3.3 <- subset(check_3.1, species == "NONE")
  expect_equal(check_3.3$vigor, as.character(NA))
  
  # dead tree with live vigor is given "4"
  expect_warning(check_4.1 <- HBEFBiomass(data_type = "external", 
                                          external_data = bad_trees_36,
                                          results = "by_tree"))
  
  check_4.2 <- subset(check_4.1, watershed == "W5" & year == "1998" & plot == "2" & species == "ACPE")
  expect_equal(check_4.2$vigor, "4")
  
  check_4.3 <- subset(check_4.1, species == "NONE")
  expect_equal(check_4.3$vigor, as.character(NA))
  
})

