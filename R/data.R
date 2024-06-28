

good_trees <- data.frame(
  watershed = c("W5","W5","W5","W5","W5", "W5","W5","W5","W5","W5","W5", "W5"),
  year = as.character(c(1998,1998,1998,1998,1998,1998,2002,2002,2002,2002,2002,2002)),
  plot = c(1,1,1,2,2,2,1,1,1,2,2,2),
  elev_m = c(500,500,500,650,650,650,500,500,500,650,650,650,750,750,700),
  exp_factor = 50,
  species = c("BEPA","PIST","FAGR","ACPE","SASP","BEAL","BEPA","PIST","FAGR","ACPE","SASP","BEAL"),
  status = c("Live","Live","Live","Dead","Live","Dead", "Live","Live","Live","Dead","Live","Dead"),
  vigor = c(1,2,1,4,3,5,1,4,1,5,4,5),
  dbh_cm = c(3.4,14.5,10.8,20.2,5.5,13.6,3.4,14.5,10.8,20.2,5.5,13.6)

)