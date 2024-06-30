
################################################################################
# dataframes used for ValidateOptions and ValidateExternal function tests
################################################################################

good_trees_1 <- data.frame(
  watershed = c("W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W6","W6","W6"),
  year = as.character(c(1998,1998,1998,1998,1998,1998,2002,2002,2002,2002,2002,2002,1997,1997,1997)),
  plot = as.character(c(1,1,1,2,2,2,1,1,1,2,2,2,1,1,2)),
  elev_m = c(500,500,500,650,650,650,500,500,500,650,650,650,750,750,550),
  exp_factor = 50,
  species = c("BEPA","PIST","FAGR","ACPE","SASP","BEAL","BEPA","PIST","FAGR","ACPE","SASP","BEAL","FAGR","FAGR","NONE"),
  status = c("Live","Live","Live","Dead","Live","Dead", "Live","Dead","Live","Dead","Dead","Dead","Dead","Dead",NA),
  vigor = as.character(c(1,2,1,4,3,5,1,4,1,5,4,5,4,4,NA)),
  dbh_cm = c(3.4,14.5,10.8,20.2,5.5,13.6,3.4,14.5,10.8,20.2,5.5,13.6,12.5,11.9,NA)
)

good_trees_2 <- data.frame(
  watershed = c("W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W6","W6","W6"),
  year = as.character(c(1998,1998,1998,1998,1998,1998,2002,2002,2002,2002,2002,2002,1997,1997,1997)),
  plot = as.character(c(1,1,1,2,2,2,1,1,1,2,2,2,1,1,2)),
  forest_type = c("spruce-fir","spruce-fir","spruce-fir","spruce-fir","spruce-fir","spruce-fir","spruce-fir","spruce-fir","spruce-fir","spruce-fir","spruce-fir","spruce-fir",
                  "northern_hardwood","northern_hardwood","northern_hardwood"), 
  elev_m = c(500,500,500,650,650,650,500,500,500,650,650,650,750,750,550),
  exp_factor = 50,
  species = c("BEPA","PIST","FAGR","ACPE","SASP","BEAL","BEPA","PIST","FAGR","ACPE","SASP","BEAL","FAGR","FAGR","NONE"),
  status = c("Live","Live","Live","Dead","Live","Dead", "Live","Dead","Live","Dead","Dead","Dead","Dead","Dead",NA),
  vigor = as.character(c(1,2,1,4,3,5,1,4,1,5,4,5,4,4,NA)),
  dbh_cm = c(3.4,14.5,10.8,20.2,5.5,13.6,3.4,14.5,10.8,20.2,5.5,13.6,12.5,11.9,NA),
  cbh_m = c(0.3,1.4,1.8,2.2,1.5,1.6,1.4,0.5,0.8,0.2,0.5,3.6,1.5,1.9,NA)
)

good_trees_3 <- data.frame(
  watershed = c("W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W6","W6","W6"),
  year = as.character(c(1998,1998,1998,1998,1998,1998,2002,2002,2002,2002,2002,2002,1997,1997,1997)),
  plot = as.character(c(1,1,1,2,2,2,1,1,1,2,2,2,1,1,2)),
  elev_m = c(500,500,500,650,650,650,500,500,500,650,650,650,750,750,550),
  exp_factor = 50,
  species = c("BEPA","PIST","FAGR","ACPE","SASP","BEAL","BEPA","PIST","FAGR","ACPE","SASP","BEAL","FAGR","FAGR","NONE"),
  status = c("Live","Live","Live","Dead","Live","Dead", "Live","Dead","Live","Dead","Dead","Dead","Dead","Dead",NA),
  vigor = as.character(c(1,2,1,4,3,5,1,4,1,5,4,5,4,4,NA)),
  dbh_cm = c(3.4,4.5,9.8,20.2,15.5,13.6,3.4,4.5,9.8,20.2,15.5,13.6,12.5,11.9,NA)
)

bad_trees_1 <- data.frame(
  #watershed = c("W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W6","W6","W6"),
  year = as.character(c(1998,1998,1998,1998,1998,1998,2002,2002,2002,2002,2002,2002,1997,1997,1997)),
  plot = as.character(c(1,1,1,2,2,2,1,1,1,2,2,2,1,1,2)),
  elev_m = c(500,500,500,650,650,650,500,500,500,650,650,650,750,750,550),
  exp_factor = 50,
  species = c("BEPA","PIST","FAGR","ACPE","SASP","BEAL","BEPA","PIST","FAGR","ACPE","SASP","BEAL","FAGR","FAGR","NONE"),
  status = c("Live","Live","Live","Dead","Live","Dead", "Live","Dead","Live","Dead","Dead","Dead","Dead","Dead",NA),
  vigor = as.character(c(1,2,1,4,3,5,1,4,1,5,4,5,4,4,NA)),
  dbh_cm = c(3.4,14.5,10.8,20.2,5.5,13.6,3.4,14.5,10.8,20.2,5.5,13.6,12.5,11.9,NA)
)

bad_trees_2 <- data.frame(
  watershed = c("W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W6","W6","W6"),
  #year = as.character(c(1998,1998,1998,1998,1998,1998,2002,2002,2002,2002,2002,2002,1997,1997,1997)),
  plot = as.character(c(1,1,1,2,2,2,1,1,1,2,2,2,1,1,2)),
  elev_m = c(500,500,500,650,650,650,500,500,500,650,650,650,750,750,550),
  exp_factor = 50,
  species = c("BEPA","PIST","FAGR","ACPE","SASP","BEAL","BEPA","PIST","FAGR","ACPE","SASP","BEAL","FAGR","FAGR","NONE"),
  status = c("Live","Live","Live","Dead","Live","Dead", "Live","Dead","Live","Dead","Dead","Dead","Dead","Dead",NA),
  vigor = as.character(c(1,2,1,4,3,5,1,4,1,5,4,5,4,4,NA)),
  dbh_cm = c(3.4,14.5,10.8,20.2,5.5,13.6,3.4,14.5,10.8,20.2,5.5,13.6,12.5,11.9,NA)
)

bad_trees_3 <- data.frame(
  watershed = c("W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W6","W6","W6"),
  year = as.character(c(1998,1998,1998,1998,1998,1998,2002,2002,2002,2002,2002,2002,1997,1997,1997)),
  #plot = as.character(c(1,1,1,2,2,2,1,1,1,2,2,2,1,1,2)),
  elev_m = c(500,500,500,650,650,650,500,500,500,650,650,650,750,750,550),
  exp_factor = 50,
  species = c("BEPA","PIST","FAGR","ACPE","SASP","BEAL","BEPA","PIST","FAGR","ACPE","SASP","BEAL","FAGR","FAGR","NONE"),
  status = c("Live","Live","Live","Dead","Live","Dead", "Live","Dead","Live","Dead","Dead","Dead","Dead","Dead",NA),
  vigor = as.character(c(1,2,1,4,3,5,1,4,1,5,4,5,4,4,NA)),
  dbh_cm = c(3.4,14.5,10.8,20.2,5.5,13.6,3.4,14.5,10.8,20.2,5.5,13.6,12.5,11.9,NA)
)

bad_trees_4 <- data.frame(
  watershed = c("W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W6","W6","W6"),
  year = as.character(c(1998,1998,1998,1998,1998,1998,2002,2002,2002,2002,2002,2002,1997,1997,1997)),
  plot = as.character(c(1,1,1,2,2,2,1,1,1,2,2,2,1,1,2)),
  #elev_m = c(500,500,500,650,650,650,500,500,500,650,650,650,750,750,550),
  exp_factor = 50,
  species = c("BEPA","PIST","FAGR","ACPE","SASP","BEAL","BEPA","PIST","FAGR","ACPE","SASP","BEAL","FAGR","FAGR","NONE"),
  status = c("Live","Live","Live","Dead","Live","Dead", "Live","Dead","Live","Dead","Dead","Dead","Dead","Dead",NA),
  vigor = as.character(c(1,2,1,4,3,5,1,4,1,5,4,5,4,4,NA)),
  dbh_cm = c(3.4,14.5,10.8,20.2,5.5,13.6,3.4,14.5,10.8,20.2,5.5,13.6,12.5,11.9,NA)
)

bad_trees_5 <- data.frame(
  watershed = c("W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W6","W6","W6"),
  year = as.character(c(1998,1998,1998,1998,1998,1998,2002,2002,2002,2002,2002,2002,1997,1997,1997)),
  plot = as.character(c(1,1,1,2,2,2,1,1,1,2,2,2,1,1,2)),
  elev_m = c(500,500,500,650,650,650,500,500,500,650,650,650,750,750,550),
  #exp_factor = 50,
  species = c("BEPA","PIST","FAGR","ACPE","SASP","BEAL","BEPA","PIST","FAGR","ACPE","SASP","BEAL","FAGR","FAGR","NONE"),
  status = c("Live","Live","Live","Dead","Live","Dead", "Live","Dead","Live","Dead","Dead","Dead","Dead","Dead",NA),
  vigor = as.character(c(1,2,1,4,3,5,1,4,1,5,4,5,4,4,NA)),
  dbh_cm = c(3.4,14.5,10.8,20.2,5.5,13.6,3.4,14.5,10.8,20.2,5.5,13.6,12.5,11.9,NA)
)

bad_trees_6 <- data.frame(
  watershed = c("W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W6","W6","W6"),
  year = as.character(c(1998,1998,1998,1998,1998,1998,2002,2002,2002,2002,2002,2002,1997,1997,1997)),
  plot = as.character(c(1,1,1,2,2,2,1,1,1,2,2,2,1,1,2)),
  elev_m = c(500,500,500,650,650,650,500,500,500,650,650,650,750,750,550),
  exp_factor = 50,
  #species = c("BEPA","PIST","FAGR","ACPE","SASP","BEAL","BEPA","PIST","FAGR","ACPE","SASP","BEAL","FAGR","FAGR","NONE"),
  status = c("Live","Live","Live","Dead","Live","Dead", "Live","Dead","Live","Dead","Dead","Dead","Dead","Dead",NA),
  vigor = as.character(c(1,2,1,4,3,5,1,4,1,5,4,5,4,4,NA)),
  dbh_cm = c(3.4,14.5,10.8,20.2,5.5,13.6,3.4,14.5,10.8,20.2,5.5,13.6,12.5,11.9,NA)
)

bad_trees_7 <- data.frame(
  watershed = c("W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W6","W6","W6"),
  year = as.character(c(1998,1998,1998,1998,1998,1998,2002,2002,2002,2002,2002,2002,1997,1997,1997)),
  plot = as.character(c(1,1,1,2,2,2,1,1,1,2,2,2,1,1,2)),
  elev_m = c(500,500,500,650,650,650,500,500,500,650,650,650,750,750,550),
  exp_factor = 50,
  species = c("BEPA","PIST","FAGR","ACPE","SASP","BEAL","BEPA","PIST","FAGR","ACPE","SASP","BEAL","FAGR","FAGR","NONE"),
  #status = c("Live","Live","Live","Dead","Live","Dead", "Live","Dead","Live","Dead","Dead","Dead","Dead","Dead",NA),
  vigor = as.character(c(1,2,1,4,3,5,1,4,1,5,4,5,4,4,NA)),
  dbh_cm = c(3.4,14.5,10.8,20.2,5.5,13.6,3.4,14.5,10.8,20.2,5.5,13.6,12.5,11.9,NA)
)

bad_trees_8 <- data.frame(
  watershed = c("W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W6","W6","W6"),
  year = as.character(c(1998,1998,1998,1998,1998,1998,2002,2002,2002,2002,2002,2002,1997,1997,1997)),
  plot = as.character(c(1,1,1,2,2,2,1,1,1,2,2,2,1,1,2)),
  elev_m = c(500,500,500,650,650,650,500,500,500,650,650,650,750,750,550),
  exp_factor = 50,
  species = c("BEPA","PIST","FAGR","ACPE","SASP","BEAL","BEPA","PIST","FAGR","ACPE","SASP","BEAL","FAGR","FAGR","NONE"),
  status = c("Live","Live","Live","Dead","Live","Dead", "Live","Dead","Live","Dead","Dead","Dead","Dead","Dead",NA),
  #vigor = as.character(c(1,2,1,4,3,5,1,4,1,5,4,5,4,4,NA)),
  dbh_cm = c(3.4,14.5,10.8,20.2,5.5,13.6,3.4,14.5,10.8,20.2,5.5,13.6,12.5,11.9,NA)
)

bad_trees_9 <- data.frame(
  watershed = c("W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W6","W6","W6"),
  year = as.character(c(1998,1998,1998,1998,1998,1998,2002,2002,2002,2002,2002,2002,1997,1997,1997)),
  plot = as.character(c(1,1,1,2,2,2,1,1,1,2,2,2,1,1,2)),
  elev_m = c(500,500,500,650,650,650,500,500,500,650,650,650,750,750,550),
  exp_factor = 50,
  species = c("BEPA","PIST","FAGR","ACPE","SASP","BEAL","BEPA","PIST","FAGR","ACPE","SASP","BEAL","FAGR","FAGR","NONE"),
  status = c("Live","Live","Live","Dead","Live","Dead", "Live","Dead","Live","Dead","Dead","Dead","Dead","Dead",NA),
  vigor = as.character(c(1,2,1,4,3,5,1,4,1,5,4,5,4,4,NA))
  #dbh_cm = c(3.4,14.5,10.8,20.2,5.5,13.6,3.4,14.5,10.8,20.2,5.5,13.6,12.5,11.9,NA)
)

bad_trees_10 <- data.frame(
  watershed = 1, # wrong class
  year = as.character(c(1998,1998,1998,1998,1998,1998,2002,2002,2002,2002,2002,2002,1997,1997,1997)),
  plot = as.character(c(1,1,1,2,2,2,1,1,1,2,2,2,1,1,2)),
  elev_m = c(500,500,500,650,650,650,500,500,500,650,650,650,750,750,550),
  exp_factor = 50,
  species = c("BEPA","PIST","FAGR","ACPE","SASP","BEAL","BEPA","PIST","FAGR","ACPE","SASP","BEAL","FAGR","FAGR","NONE"),
  status = c("Live","Live","Live","Dead","Live","Dead", "Live","Dead","Live","Dead","Dead","Dead","Dead","Dead",NA),
  vigor = as.character(c(1,2,1,4,3,5,1,4,1,5,4,5,4,4,NA)),
  dbh_cm = c(3.4,14.5,10.8,20.2,5.5,13.6,3.4,14.5,10.8,20.2,5.5,13.6,12.5,11.9,NA)
)

bad_trees_11 <- data.frame(
  watershed = c("W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W6","W6","W6"),
  year = c(1998,1998,1998,1998,1998,1998,2002,2002,2002,2002,2002,2002,1997,1997,1997), # wrong class
  plot = as.character(c(1,1,1,2,2,2,1,1,1,2,2,2,1,1,2)),
  elev_m = c(500,500,500,650,650,650,500,500,500,650,650,650,750,750,550),
  exp_factor = 50,
  species = c("BEPA","PIST","FAGR","ACPE","SASP","BEAL","BEPA","PIST","FAGR","ACPE","SASP","BEAL","FAGR","FAGR","NONE"),
  status = c("Live","Live","Live","Dead","Live","Dead", "Live","Dead","Live","Dead","Dead","Dead","Dead","Dead",NA),
  vigor = as.character(c(1,2,1,4,3,5,1,4,1,5,4,5,4,4,NA)),
  dbh_cm = c(3.4,14.5,10.8,20.2,5.5,13.6,3.4,14.5,10.8,20.2,5.5,13.6,12.5,11.9,NA)
)

bad_trees_12 <- data.frame(
  watershed = c("W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W6","W6","W6"),
  year = as.character(c(1998,1998,1998,1998,1998,1998,2002,2002,2002,2002,2002,2002,1997,1997,1997)),
  plot = c(1,1,1,2,2,2,1,1,1,2,2,2,1,1,2), # wrong class
  elev_m = c(500,500,500,650,650,650,500,500,500,650,650,650,750,750,550),
  exp_factor = 50,
  species = c("BEPA","PIST","FAGR","ACPE","SASP","BEAL","BEPA","PIST","FAGR","ACPE","SASP","BEAL","FAGR","FAGR","NONE"),
  status = c("Live","Live","Live","Dead","Live","Dead", "Live","Dead","Live","Dead","Dead","Dead","Dead","Dead",NA),
  vigor = as.character(c(1,2,1,4,3,5,1,4,1,5,4,5,4,4,NA)),
  dbh_cm = c(3.4,14.5,10.8,20.2,5.5,13.6,3.4,14.5,10.8,20.2,5.5,13.6,12.5,11.9,NA)
)

bad_trees_13 <- data.frame(
  watershed = c("W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W6","W6","W6"),
  year = as.character(c(1998,1998,1998,1998,1998,1998,2002,2002,2002,2002,2002,2002,1997,1997,1997)),
  plot = as.character(c(1,1,1,2,2,2,1,1,1,2,2,2,1,1,2)),
  elev_m = as.character(c(500,500,500,650,650,650,500,500,500,650,650,650,750,750,550)), # wrong class 
  exp_factor = 50,
  species = c("BEPA","PIST","FAGR","ACPE","SASP","BEAL","BEPA","PIST","FAGR","ACPE","SASP","BEAL","FAGR","FAGR","NONE"),
  status = c("Live","Live","Live","Dead","Live","Dead", "Live","Dead","Live","Dead","Dead","Dead","Dead","Dead",NA),
  vigor = as.character(c(1,2,1,4,3,5,1,4,1,5,4,5,4,4,NA)),
  dbh_cm = c(3.4,14.5,10.8,20.2,5.5,13.6,3.4,14.5,10.8,20.2,5.5,13.6,12.5,11.9,NA)
)

bad_trees_14 <- data.frame(
  watershed = c("W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W6","W6","W6"),
  year = as.character(c(1998,1998,1998,1998,1998,1998,2002,2002,2002,2002,2002,2002,1997,1997,1997)),
  plot = as.character(c(1,1,1,2,2,2,1,1,1,2,2,2,1,1,2)),
  elev_m = c(500,500,500,650,650,650,500,500,500,650,650,650,750,750,550),
  exp_factor = as.character(50), # wrong class 
  species = c("BEPA","PIST","FAGR","ACPE","SASP","BEAL","BEPA","PIST","FAGR","ACPE","SASP","BEAL","FAGR","FAGR","NONE"),
  status = c("Live","Live","Live","Dead","Live","Dead", "Live","Dead","Live","Dead","Dead","Dead","Dead","Dead",NA),
  vigor = as.character(c(1,2,1,4,3,5,1,4,1,5,4,5,4,4,NA)),
  dbh_cm = c(3.4,14.5,10.8,20.2,5.5,13.6,3.4,14.5,10.8,20.2,5.5,13.6,12.5,11.9,NA)
)

bad_trees_15 <- data.frame(
  watershed = c("W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W6","W6","W6"),
  year = as.character(c(1998,1998,1998,1998,1998,1998,2002,2002,2002,2002,2002,2002,1997,1997,1997)),
  plot = as.character(c(1,1,1,2,2,2,1,1,1,2,2,2,1,1,2)),
  elev_m = c(500,500,500,650,650,650,500,500,500,650,650,650,750,750,550),
  exp_factor = 50,
  species = 1, # wrong class (would also cause other errors)
  status = c("Live","Live","Live","Dead","Live","Dead", "Live","Dead","Live","Dead","Dead","Dead","Dead","Dead",NA),
  vigor = as.character(c(1,2,1,4,3,5,1,4,1,5,4,5,4,4,NA)),
  dbh_cm = c(3.4,14.5,10.8,20.2,5.5,13.6,3.4,14.5,10.8,20.2,5.5,13.6,12.5,11.9,NA)
)

bad_trees_16 <- data.frame(
  watershed = c("W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W6","W6","W6"),
  year = as.character(c(1998,1998,1998,1998,1998,1998,2002,2002,2002,2002,2002,2002,1997,1997,1997)),
  plot = as.character(c(1,1,1,2,2,2,1,1,1,2,2,2,1,1,2)),
  elev_m = c(500,500,500,650,650,650,500,500,500,650,650,650,750,750,550),
  exp_factor = 50,
  species = c("BEPA","PIST","FAGR","ACPE","SASP","BEAL","BEPA","PIST","FAGR","ACPE","SASP","BEAL","FAGR","FAGR","NONE"),
  status = 1, # wrong class (would also cause other errors)
  vigor = as.character(c(1,2,1,4,3,5,1,4,1,5,4,5,4,4,NA)),
  dbh_cm = c(3.4,14.5,10.8,20.2,5.5,13.6,3.4,14.5,10.8,20.2,5.5,13.6,12.5,11.9,NA)
)

bad_trees_17 <- data.frame(
  watershed = c("W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W6","W6","W6"),
  year = as.character(c(1998,1998,1998,1998,1998,1998,2002,2002,2002,2002,2002,2002,1997,1997,1997)),
  plot = as.character(c(1,1,1,2,2,2,1,1,1,2,2,2,1,1,2)),
  elev_m = c(500,500,500,650,650,650,500,500,500,650,650,650,750,750,550),
  exp_factor = 50,
  species = c("BEPA","PIST","FAGR","ACPE","SASP","BEAL","BEPA","PIST","FAGR","ACPE","SASP","BEAL","FAGR","FAGR","NONE"),
  status = c("Live","Live","Live","Dead","Live","Dead", "Live","Dead","Live","Dead","Dead","Dead","Dead","Dead",NA),
  vigor = c(1,2,1,4,3,5,1,4,1,5,4,5,4,4,NA), # wrong class 
  dbh_cm = c(3.4,14.5,10.8,20.2,5.5,13.6,3.4,14.5,10.8,20.2,5.5,13.6,12.5,11.9,NA)
)

bad_trees_18 <- data.frame(
  watershed = c("W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W6","W6","W6"),
  year = as.character(c(1998,1998,1998,1998,1998,1998,2002,2002,2002,2002,2002,2002,1997,1997,1997)),
  plot = as.character(c(1,1,1,2,2,2,1,1,1,2,2,2,1,1,2)),
  elev_m = c(500,500,500,650,650,650,500,500,500,650,650,650,750,750,550),
  exp_factor = 50,
  species = c("BEPA","PIST","FAGR","ACPE","SASP","BEAL","BEPA","PIST","FAGR","ACPE","SASP","BEAL","FAGR","FAGR","NONE"),
  status = c("Live","Live","Live","Dead","Live","Dead", "Live","Dead","Live","Dead","Dead","Dead","Dead","Dead",NA),
  vigor = as.character(c(1,2,1,4,3,5,1,4,1,5,4,5,4,4,NA)),
  dbh_cm = as.character(c(3.4,14.5,10.8,20.2,5.5,13.6,3.4,14.5,10.8,20.2,5.5,13.6,12.5,11.9,NA)) # wrong class
)

bad_trees_19 <- data.frame(
  watershed = c("W5",NA,"W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W6","W6","W6"), # NA value
  year = as.character(c(1998,1998,1998,1998,1998,1998,2002,2002,2002,2002,2002,2002,1997,1997,1997)),
  plot = as.character(c(1,1,1,2,2,2,1,1,1,2,2,2,1,1,2)),
  elev_m = c(500,500,500,650,650,650,500,500,500,650,650,650,750,750,550),
  exp_factor = 50,
  species = c("BEPA","PIST","FAGR","ACPE","SASP","BEAL","BEPA","PIST","FAGR","ACPE","SASP","BEAL","FAGR","FAGR","NONE"),
  status = c("Live","Live","Live","Dead","Live","Dead", "Live","Dead","Live","Dead","Dead","Dead","Dead","Dead",NA),
  vigor = as.character(c(1,2,1,4,3,5,1,4,1,5,4,5,4,4,NA)),
  dbh_cm = c(3.4,14.5,10.8,20.2,5.5,13.6,3.4,14.5,10.8,20.2,5.5,13.6,12.5,11.9,NA)
)

bad_trees_20 <- data.frame(
  watershed = c("W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W6","W6","W6"), 
  year = as.character(c(1998,NA,1998,1998,1998,1998,2002,2002,2002,2002,2002,2002,1997,1997,1997)), #NA value
  plot = as.character(c(1,1,1,2,2,2,1,1,1,2,2,2,1,1,2)),
  elev_m = c(500,500,500,650,650,650,500,500,500,650,650,650,750,750,550),
  exp_factor = 50,
  species = c("BEPA","PIST","FAGR","ACPE","SASP","BEAL","BEPA","PIST","FAGR","ACPE","SASP","BEAL","FAGR","FAGR","NONE"),
  status = c("Live","Live","Live","Dead","Live","Dead", "Live","Dead","Live","Dead","Dead","Dead","Dead","Dead",NA),
  vigor = as.character(c(1,2,1,4,3,5,1,4,1,5,4,5,4,4,NA)),
  dbh_cm = c(3.4,14.5,10.8,20.2,5.5,13.6,3.4,14.5,10.8,20.2,5.5,13.6,12.5,11.9,NA)
)

bad_trees_21 <- data.frame(
  watershed = c("W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W6","W6","W6"), 
  year = as.character(c(1998,1998,1998,1998,1998,1998,2002,2002,2002,2002,2002,2002,1997,1997,1997)),
  plot = as.character(c(1,NA,1,2,2,2,1,1,1,2,2,2,1,1,2)), # NA value
  elev_m = c(500,500,500,650,650,650,500,500,500,650,650,650,750,750,550),
  exp_factor = 50,
  species = c("BEPA","PIST","FAGR","ACPE","SASP","BEAL","BEPA","PIST","FAGR","ACPE","SASP","BEAL","FAGR","FAGR","NONE"),
  status = c("Live","Live","Live","Dead","Live","Dead", "Live","Dead","Live","Dead","Dead","Dead","Dead","Dead",NA),
  vigor = as.character(c(1,2,1,4,3,5,1,4,1,5,4,5,4,4,NA)),
  dbh_cm = c(3.4,14.5,10.8,20.2,5.5,13.6,3.4,14.5,10.8,20.2,5.5,13.6,12.5,11.9,NA)
)

bad_trees_22 <- data.frame(
  watershed = c("W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W6","W6","W6"), 
  year = as.character(c(1998,1998,1998,1998,1998,1998,2002,2002,2002,2002,2002,2002,1997,1997,1997)),
  plot = as.character(c(1,1,1,2,2,2,1,1,1,2,2,2,1,1,2)),
  elev_m = c(500,500,500,650,650,650,500,500,500,650,650,650,750,750,550),
  exp_factor = c(50,NA,50,50,50,50,50,50,50,50,50,50,50,50,50), # NA value
  species = c("BEPA","PIST","FAGR","ACPE","SASP","BEAL","BEPA","PIST","FAGR","ACPE","SASP","BEAL","FAGR","FAGR","NONE"),
  status = c("Live","Live","Live","Dead","Live","Dead", "Live","Dead","Live","Dead","Dead","Dead","Dead","Dead",NA),
  vigor = as.character(c(1,2,1,4,3,5,1,4,1,5,4,5,4,4,NA)),
  dbh_cm = c(3.4,14.5,10.8,20.2,5.5,13.6,3.4,14.5,10.8,20.2,5.5,13.6,12.5,11.9,NA)
)

bad_trees_23 <- data.frame(
  watershed = c("W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W6","W6","W6"), 
  year = as.character(c(1998,1998,1998,1998,1998,1998,2002,2002,2002,2002,2002,2002,1997,1997,1997)),
  plot = as.character(c(1,1,1,2,2,2,1,1,1,2,2,2,1,1,2)),
  elev_m = c(500,500,500,650,650,650,500,500,500,650,650,650,750,750,550),
  exp_factor = c(50,-50,50,50,50,50,50,50,50,50,50,50,50,50,50), # negative value
  species = c("BEPA","PIST","FAGR","ACPE","SASP","BEAL","BEPA","PIST","FAGR","ACPE","SASP","BEAL","FAGR","FAGR","NONE"),
  status = c("Live","Live","Live","Dead","Live","Dead", "Live","Dead","Live","Dead","Dead","Dead","Dead","Dead",NA),
  vigor = as.character(c(1,2,1,4,3,5,1,4,1,5,4,5,4,4,NA)),
  dbh_cm = c(3.4,14.5,10.8,20.2,5.5,13.6,3.4,14.5,10.8,20.2,5.5,13.6,12.5,11.9,NA)
)

bad_trees_24 <- data.frame(
  watershed = c("W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W6","W6","W6"), 
  year = as.character(c(1998,1998,1998,1998,1998,1998,2002,2002,2002,2002,2002,2002,1997,1997,1997)),
  plot = as.character(c(1,1,1,2,2,2,1,1,1,2,2,2,1,1,2)),
  elev_m = c(NA,NA,NA,650,650,650,500,500,500,650,650,650,750,750,550), # NA value
  exp_factor = 50,
  species = c("BEPA","PIST","FAGR","ACPE","SASP","BEAL","BEPA","PIST","FAGR","ACPE","SASP","BEAL","FAGR","FAGR","NONE"),
  status = c("Live","Live","Live","Dead","Live","Dead", "Live","Dead","Live","Dead","Dead","Dead","Dead","Dead",NA),
  vigor = as.character(c(1,2,1,4,3,5,1,4,1,5,4,5,4,4,NA)),
  dbh_cm = c(3.4,14.5,10.8,20.2,5.5,13.6,3.4,14.5,10.8,20.2,5.5,13.6,12.5,11.9,NA)
)

bad_trees_25 <- data.frame(
  watershed = c("W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W6","W6","W6"), 
  year = as.character(c(1998,1998,1998,1998,1998,1998,2002,2002,2002,2002,2002,2002,1997,1997,1997)),
  plot = as.character(c(1,1,1,2,2,2,1,1,1,2,2,2,1,1,2)),
  elev_m = c(-500,-500,-500,650,650,650,500,500,500,650,650,650,750,750,550), # negative value
  exp_factor = 50,
  species = c("BEPA","PIST","FAGR","ACPE","SASP","BEAL","BEPA","PIST","FAGR","ACPE","SASP","BEAL","FAGR","FAGR","NONE"),
  status = c("Live","Live","Live","Dead","Live","Dead", "Live","Dead","Live","Dead","Dead","Dead","Dead","Dead",NA),
  vigor = as.character(c(1,2,1,4,3,5,1,4,1,5,4,5,4,4,NA)),
  dbh_cm = c(3.4,14.5,10.8,20.2,5.5,13.6,3.4,14.5,10.8,20.2,5.5,13.6,12.5,11.9,NA)
)

bad_trees_26 <- data.frame(
  watershed = c("W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W6","W6","W6"), 
  year = as.character(c(1998,1998,1998,1998,1998,1998,2002,2002,2002,2002,2002,2002,1997,1997,1997)),
  plot = as.character(c(1,1,1,2,2,2,1,1,1,2,2,2,1,1,2)),
  elev_m = c(500,50,500,650,50,650,500,500,500,650,650,650,750,750,550), # mismatching elevs within a plot
  exp_factor = 50,
  species = c("BEPA","PIST","FAGR","ACPE","SASP","BEAL","BEPA","PIST","FAGR","ACPE","SASP","BEAL","FAGR","FAGR","NONE"),
  status = c("Live","Live","Live","Dead","Live","Dead", "Live","Dead","Live","Dead","Dead","Dead","Dead","Dead",NA),
  vigor = as.character(c(1,2,1,4,3,5,1,4,1,5,4,5,4,4,NA)),
  dbh_cm = c(3.4,14.5,10.8,20.2,5.5,13.6,3.4,14.5,10.8,20.2,5.5,13.6,12.5,11.9,NA)
)

bad_trees_27 <- data.frame(
  watershed = c("W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W6","W6","W6"), 
  year = as.character(c(1998,1998,1998,1998,1998,1998,2002,2002,2002,2002,2002,2002,1997,1997,1997)),
  plot = as.character(c(1,1,1,2,2,2,1,1,1,2,2,2,1,1,2)),
  elev_m = c(500,500,500,650,650,650,500,500,500,650,650,650,750,750,550),
  forest_type = c("spruce-fir","nothern_hardwood","spruce-fir","spruce-fir","spruce-fir","spruce-fir","spruce-fir","spruce-fir","spruce-fir","spruce-fir","spruce-fir","spruce-fir",
                  "northern_hardwood","northern_hardwood","northern_hardwood"), # mismatching forest types within a plot
  exp_factor = 50,
  species = c("BEPA","PIST","FAGR","ACPE","SASP","BEAL","BEPA","PIST","FAGR","ACPE","SASP","BEAL","FAGR","FAGR","NONE"),
  status = c("Live","Live","Live","Dead","Live","Dead", "Live","Dead","Live","Dead","Dead","Dead","Dead","Dead",NA),
  vigor = as.character(c(1,2,1,4,3,5,1,4,1,5,4,5,4,4,NA)),
  dbh_cm = c(3.4,14.5,10.8,20.2,5.5,13.6,3.4,14.5,10.8,20.2,5.5,13.6,12.5,11.9,NA)
)

bad_trees_28 <- data.frame(
  watershed = c("W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W6","W6","W6"), 
  year = as.character(c(1998,1998,1998,1998,1998,1998,2002,2002,2002,2002,2002,2002,1997,1997,1997)),
  plot = as.character(c(1,1,1,2,2,2,1,1,1,2,2,2,1,1,2)),
  elev_m = c(500,500,500,650,650,650,500,500,500,650,650,650,750,750,550),
  exp_factor = 50,
  species = c("BEPAA","PIST","FAAGR","ACPE","SASP","BEAL","BEPA","PIST","FAGR","ACPE","SASP","BEAL","FAGR","FAGR","NONE"), # incorrect species codes
  status = c("Live","Live","Live","Dead","Live","Dead", "Live","Dead","Live","Dead","Dead","Dead","Dead","Dead",NA),
  vigor = as.character(c(1,2,1,4,3,5,1,4,1,5,4,5,4,4,NA)),
  dbh_cm = c(3.4,14.5,10.8,20.2,5.5,13.6,3.4,14.5,10.8,20.2,5.5,13.6,12.5,11.9,NA)
)

bad_trees_29 <- data.frame(
  watershed = c("W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W6","W6","W6"), 
  year = as.character(c(1998,1998,1998,1998,1998,1998,2002,2002,2002,2002,2002,2002,1997,1997,1997)),
  plot = as.character(c(1,1,1,2,2,2,1,1,1,2,2,2,1,1,2)),
  elev_m = c(500,500,500,650,650,650,500,500,500,650,650,650,750,750,550),
  exp_factor = 50,
  species = c("BEPA",NA,"FAGR","ACPE","SASP","BEAL","BEPA","PIST","FAGR","ACPE","SASP","BEAL","FAGR","FAGR","NONE"), # NA value
  status = c("Live","Live","Live","Dead","Live","Dead", "Live","Dead","Live","Dead","Dead","Dead","Dead","Dead",NA),
  vigor = as.character(c(1,2,1,4,3,5,1,4,1,5,4,5,4,4,NA)),
  dbh_cm = c(3.4,14.5,10.8,20.2,5.5,13.6,3.4,14.5,10.8,20.2,5.5,13.6,12.5,11.9,NA)
)

bad_trees_30 <- data.frame(
  watershed = c("W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W6","W6","W6"), 
  year = as.character(c(1998,1998,1998,1998,1998,1998,2002,2002,2002,2002,2002,2002,1997,1997,1997)),
  plot = as.character(c(1,1,1,2,2,2,1,1,1,2,2,2,1,2,2)),
  elev_m = c(500,500,500,650,650,650,500,500,500,650,650,650,750,550,550),
  exp_factor = 50,
  species = c("BEPA","PIST","FAGR","ACPE","SASP","BEAL","BEPA","PIST","FAGR","ACPE","SASP","BEAL","FAGR","FAGR","NONE"), # incorrect use of NONE species
  status = c("Live","Live","Live","Dead","Live","Dead", "Live","Dead","Live","Dead","Dead","Dead","Dead","Dead",NA),
  vigor = as.character(c(1,2,1,4,3,5,1,4,1,5,4,5,4,4,NA)),
  dbh_cm = c(3.4,14.5,10.8,20.2,5.5,13.6,3.4,14.5,10.8,20.2,5.5,13.6,12.5,11.9,NA)
)

bad_trees_31 <- data.frame(
  watershed = c("W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W6","W6","W6"), 
  year = as.character(c(1998,1998,1998,1998,1998,1998,2002,2002,2002,2002,2002,2002,1997,1997,1997)),
  plot = as.character(c(1,1,1,2,2,2,1,1,1,2,2,2,1,1,2)),
  elev_m = c(500,500,500,650,650,650,500,500,500,650,650,650,750,750,550),
  exp_factor = 50,
  species = c("BEPA","PIST","FAGR","ACPE","SASP","BEAL","BEPA","PIST","FAGR","ACPE","SASP","BEAL","FAGR","FAGR","NONE"), 
  status = c("Live","Live","Live","Dead","Live","Dead", "Live","Dead","Live","Dead","Dead","Dead","Dead","Dead","Live"), # non-NA status with NONE species
  vigor = as.character(c(1,2,1,4,3,5,1,4,1,5,4,5,4,4,NA)),
  dbh_cm = c(3.4,14.5,10.8,20.2,5.5,13.6,3.4,14.5,10.8,20.2,5.5,13.6,12.5,11.9,NA)
)

bad_trees_32 <- data.frame(
  watershed = c("W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W6","W6","W6"), 
  year = as.character(c(1998,1998,1998,1998,1998,1998,2002,2002,2002,2002,2002,2002,1997,1997,1997)),
  plot = as.character(c(1,1,1,2,2,2,1,1,1,2,2,2,1,1,2)),
  elev_m = c(500,500,500,650,650,650,500,500,500,650,650,650,750,750,550),
  exp_factor = 50,
  species = c("BEPA","PIST","FAGR","ACPE","SASP","BEAL","BEPA","PIST","FAGR","ACPE","SASP","BEAL","FAGR","FAGR","NONE"), 
  status = c("Livee","Live","Live","Dead","Live","Dead", "Live","Dead","Live","Dead","Dead","Dead","Dead","Dead",NA), # incorrect status code 
  vigor = as.character(c(1,2,1,4,3,5,1,4,1,5,4,5,4,4,NA)),
  dbh_cm = c(3.4,14.5,10.8,20.2,5.5,13.6,3.4,14.5,10.8,20.2,5.5,13.6,12.5,11.9,NA)
)

bad_trees_33 <- data.frame(
  watershed = c("W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W6","W6","W6"), 
  year = as.character(c(1998,1998,1998,1998,1998,1998,2002,2002,2002,2002,2002,2002,1997,1997,1997)),
  plot = as.character(c(1,1,1,2,2,2,1,1,1,2,2,2,1,1,2)),
  elev_m = c(500,500,500,650,650,650,500,500,500,650,650,650,750,750,550),
  exp_factor = 50,
  species = c("BEPA","PIST","FAGR","ACPE","SASP","BEAL","BEPA","PIST","FAGR","ACPE","SASP","BEAL","FAGR","FAGR","NONE"), 
  status = c("Live",NA,"Live","Dead","Live","Dead", "Live","Dead","Live","Dead","Dead","Dead","Dead","Dead",NA), # NA value
  vigor = as.character(c(1,2,1,4,3,5,1,4,1,5,4,5,4,4,NA)),
  dbh_cm = c(3.4,14.5,10.8,20.2,5.5,13.6,3.4,14.5,10.8,20.2,5.5,13.6,12.5,11.9,NA)
)

bad_trees_34 <- data.frame(
  watershed = c("W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W6","W6","W6"), 
  year = as.character(c(1998,1998,1998,1998,1998,1998,2002,2002,2002,2002,2002,2002,1997,1997,1997)),
  plot = as.character(c(1,1,1,2,2,2,1,1,1,2,2,2,1,1,2)),
  elev_m = c(500,500,500,650,650,650,500,500,500,650,650,650,750,750,550),
  exp_factor = 50,
  species = c("BEPA","PIST","FAGR","ACPE","SASP","BEAL","BEPA","PIST","FAGR","ACPE","SASP","BEAL","FAGR","FAGR","NONE"), 
  status = c("Live","Live","Live","Dead","Live","Dead", "Live","Dead","Live","Dead","Dead","Dead","Dead","Dead",NA),
  vigor = as.character(c(1,2,1,4,3,6,1,4,1,5,4,5,4,4,NA)), # incorrect vigor code
  dbh_cm = c(3.4,14.5,10.8,20.2,5.5,13.6,3.4,14.5,10.8,20.2,5.5,13.6,12.5,11.9,NA)
)

bad_trees_35 <- data.frame(
  watershed = c("W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W6","W6","W6"), 
  year = as.character(c(1998,1998,1998,1998,1998,1998,2002,2002,2002,2002,2002,2002,1997,1997,1997)),
  plot = as.character(c(1,1,1,2,2,2,1,1,1,2,2,2,1,1,2)),
  elev_m = c(500,500,500,650,650,650,500,500,500,650,650,650,750,750,550),
  exp_factor = 50,
  species = c("BEPA","PIST","FAGR","ACPE","SASP","BEAL","BEPA","PIST","FAGR","ACPE","SASP","BEAL","FAGR","FAGR","NONE"), 
  status = c("Live","Live","Live","Dead","Live","Dead", "Live","Dead","Live","Dead","Dead","Dead","Dead","Dead",NA),
  vigor = as.character(c(1,NA,1,NA,3,5,1,4,1,5,4,5,4,4,NA)), # NA value
  dbh_cm = c(3.4,14.5,10.8,20.2,5.5,13.6,3.4,14.5,10.8,20.2,5.5,13.6,12.5,11.9,NA)
)

bad_trees_36 <- data.frame(
  watershed = c("W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W6","W6","W6"), 
  year = as.character(c(1998,1998,1998,1998,1998,1998,2002,2002,2002,2002,2002,2002,1997,1997,1997)),
  plot = as.character(c(1,1,1,2,2,2,1,1,1,2,2,2,1,1,2)),
  elev_m = c(500,500,500,650,650,650,500,500,500,650,650,650,750,750,550),
  exp_factor = 50,
  species = c("BEPA","PIST","FAGR","ACPE","SASP","BEAL","BEPA","PIST","FAGR","ACPE","SASP","BEAL","FAGR","FAGR","NONE"), 
  status = c("Live","Live","Live","Dead","Live","Dead", "Live","Dead","Live","Dead","Dead","Dead","Dead","Dead",NA),
  vigor = as.character(c(1,2,1,3,3,5,1,4,1,5,4,5,4,4,NA)), # dead tree with live vigor code
  dbh_cm = c(3.4,14.5,10.8,20.2,5.5,13.6,3.4,14.5,10.8,20.2,5.5,13.6,12.5,11.9,NA)
)

bad_trees_37 <- data.frame(
  watershed = c("W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W6","W6","W6"), 
  year = as.character(c(1998,1998,1998,1998,1998,1998,2002,2002,2002,2002,2002,2002,1997,1997,1997)),
  plot = as.character(c(1,1,1,2,2,2,1,1,1,2,2,2,1,1,2)),
  elev_m = c(500,500,500,650,650,650,500,500,500,650,650,650,750,750,550),
  exp_factor = 50,
  species = c("BEPA","PIST","FAGR","ACPE","SASP","BEAL","BEPA","PIST","FAGR","ACPE","SASP","BEAL","FAGR","FAGR","NONE"), 
  status = c("Live","Live","Live","Dead","Live","Dead", "Live","Dead","Live","Dead","Dead","Dead","Dead","Dead",NA),
  vigor = as.character(c(1,4,1,4,3,5,1,4,1,5,4,5,4,4,NA)), # live tree with dead vigor code
  dbh_cm = c(3.4,14.5,10.8,20.2,5.5,13.6,3.4,14.5,10.8,20.2,5.5,13.6,12.5,11.9,NA)
)

bad_trees_38 <- data.frame(
  watershed = c("W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W6","W6","W6"), 
  year = as.character(c(1998,1998,1998,1998,1998,1998,2002,2002,2002,2002,2002,2002,1997,1997,1997)),
  plot = as.character(c(1,1,1,2,2,2,1,1,1,2,2,2,1,1,2)),
  elev_m = c(500,500,500,650,650,650,500,500,500,650,650,650,750,750,550),
  exp_factor = 50,
  species = c("BEPA","PIST","FAGR","ACPE","SASP","BEAL","BEPA","PIST","FAGR","ACPE","SASP","BEAL","FAGR","FAGR","NONE"), 
  status = c("Live","Live","Live","Dead","Live","Dead", "Live","Dead","Live","Dead","Dead","Dead","Dead","Dead",NA),
  vigor = as.character(c(1,2,1,4,3,5,1,4,1,5,4,5,4,4,NA)),
  dbh_cm = c(3.4,NA,10.8,20.2,5.5,13.6,3.4,14.5,10.8,20.2,5.5,13.6,12.5,11.9,NA) # NA values
)

bad_trees_39 <- data.frame(
  watershed = c("W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W6","W6","W6"), 
  year = as.character(c(1998,1998,1998,1998,1998,1998,2002,2002,2002,2002,2002,2002,1997,1997,1997)),
  plot = as.character(c(1,1,1,2,2,2,1,1,1,2,2,2,1,1,2)),
  elev_m = c(500,500,500,650,650,650,500,500,500,650,650,650,750,750,550),
  exp_factor = 50,
  species = c("BEPA","PIST","FAGR","ACPE","SASP","BEAL","BEPA","PIST","FAGR","ACPE","SASP","BEAL","FAGR","FAGR","NONE"), 
  status = c("Live","Live","Live","Dead","Live","Dead", "Live","Dead","Live","Dead","Dead","Dead","Dead","Dead",NA),
  vigor = as.character(c(1,2,1,4,3,5,1,4,1,5,4,5,4,4,NA)), 
  dbh_cm = c(1.4,14.5,10.8,20.2,5.5,13.6,3.4,14.5,10.8,20.2,5.5,13.6,12.5,11.9,NA) # dbh < 2 cm
)

bad_trees_40 <- data.frame(
  watershed = c("W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W5","W6","W6","W6"), 
  year = as.character(c(1998,1998,1998,1998,1998,1998,2002,2002,2002,2002,2002,2002,1997,1997,1997)),
  plot = as.character(c(1,1,1,2,2,2,1,1,1,2,2,2,1,1,2)),
  elev_m = c(500,500,500,650,650,650,500,500,500,650,650,650,750,750,550),
  exp_factor = 50,
  species = c("BEPA","PIST","FAGR","ACPE","SASP","BEAL","BEPA","PIST","FAGR","ACPE","SASP","BEAL","FAGR","FAGR","NONE"), 
  status = c("Live","Live","Live","Dead","Live","Dead", "Live","Dead","Live","Dead","Dead","Dead","Dead","Dead",NA),
  vigor = as.character(c(1,2,1,4,3,5,1,4,1,5,4,5,4,4,NA)),
  dbh_cm = c(NA,NA,NA,20.2,5.5,13.6,3.4,14.5,10.8,20.2,5.5,13.6,12.5,11.9,NA) # NA values
)

