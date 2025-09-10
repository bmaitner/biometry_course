
library(bbsAssistant)
library(tidyverse)
library(devtools)
library(geodata)
library(sf)
library(terra)

devtools::install_github("https://github.com/trashbirdecology/bbsAssistant")

# where do I get the bioclim data?


# Grab the BBS dataset

  bbs <- grab_bbs_data(bbs_dir = "data/BBS/",
                       overwrite = FALSE)
  
# Get the individual bits  

  bbs_observation <- bbs$observations
  bbs_species <- bbs$species_list
  bbs_routes <- bbs$routes
  bbs_weather <- bbs$weather 

# Join the parts into one file
  
  bbs_observation <- bbs_observation %>%
    left_join(bbs_species)

  bbs_observation <- bbs_observation %>%
    left_join(bbs_routes)
  
  bbs_observation <- bbs_observation %>%
    left_join(bbs_weather)
  
# Cleanup
  
  rm(bbs,bbs_routes,bbs_species,bbs_weather)
  
# Subset to Florida (state 25)  

  fl_bbs_obs <- 
  bbs_observation %>%
    filter(StateNum == 25)

# Convert to sf
  

  fl_bbs_obs <- fl_bbs_obs %>%
    st_as_sf(coords = c("Longitude","Latitude"),
             remove=FALSE)
  

# Get climate, landcover, and footprint data
  
  # bio <- geodata::worldclim_country(country = "United States",
  #                                    var = "bio",
  #                                    path = "data/BBS/")
  
  tavg <- geodata::worldclim_country(country = "United States",
                             var = "tavg",
                             path = "data/BBS/")
  
  tavg <- crop(x = tavg,y = ext(fl_bbs_obs))
  
  #plot(tavg)
  
  mean_tavg <- mean(tavg)
  
  names(mean_tavg) <- "mean_annual_temp"
  
  #plot(mean_tavg)

  prec <-geodata::worldclim_country(country = "United States",
                             var = "prec",path = "data/BBS/")
  
  prec <- crop(x = prec,y = ext(fl_bbs_obs))
  
  #plot(prec)
  
  total_prec <- sum(prec)
  
  names(total_prec) <- "mean_annual_precip"

  #plot(total_prec)
  
  built <- geodata::landcover(var = "built",path = "data/BBS/")
  
  built <- crop(x = built,y = ext(fl_bbs_obs))
  
  #plot(built)
  
  footprint <- geodata::footprint(year = "2009",path = "data/BBS/")
  
  footprint <- crop(x = footprint,y = ext(fl_bbs_obs))
  
  #plot(footprint)

  fl_bbs_obs$mean_annual_temp <- extract(x = mean_tavg,y = fl_bbs_obs,ID=FALSE) %>%
    pull(mean_annual_temp)
  
  fl_bbs_obs$mean_annual_precip <- extract(x = total_prec,y = fl_bbs_obs,ID=FALSE) %>%
    pull(mean_annual_precip)
  
  fl_bbs_obs$frac_built <- extract(x = built,y = fl_bbs_obs,ID=FALSE) %>%
    pull(built)
  
  fl_bbs_obs$footprint <- extract(x = footprint,y = fl_bbs_obs,ID=FALSE) %>%
    pull('wildareas-v3-2009-human-footprint')

  # add total sightings and subset to key fields
  
    fl_bbs_obs <- 
    fl_bbs_obs %>%
      mutate(total_sightings = rowSums(pick(matches("^Stop"))))%>%
      select(RouteDataID,Route,
             Year,Month,Day,
             ORDER,Family,Genus,Scientific_Name,
             total_sightings,TotalSpp,
             StartTemp,EndTemp,TempScale,StartTime,EndTime,StartWind,EndWind,
             mean_annual_temp,mean_annual_precip,frac_built,footprint,
             Latitude,Longitude) %>%
      st_drop_geometry()

    # save data subset
    
    write.csv(x = fl_bbs_obs,
              file = "data/BBS/FL_BBS.csv",
              row.names = FALSE)

# Remove files to save memory
    
    bbs_files <- list.files(path = "data/BBS/",full.names = TRUE,recursive = TRUE)
    
    bbs_files <-
    data.frame(files = bbs_files) %>%
      mutate(basename = basename(files)) %>%
      filter(!basename %in% c("README","FL_BBS.csv","get_BBS_data.R")) 

    unlink(x = bbs_files$files,recursive = TRUE,force = TRUE)    
  
  
  
    
