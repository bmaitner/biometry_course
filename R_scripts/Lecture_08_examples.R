# Code for lecture 8 (focused on ggplot)

  library(tidyverse)
  library(ggplot2)
  library(ggpubr)
  library(ggridges)    
  


#let's get some data

  avo <- read_rds("https://tinyurl.com/avonetdata")


# distributions -----------------------------------------------------------

  
 # HWI
  
  hist(avo$Hand.Wing.Index)
  
  avo |>
    ggplot(mapping = aes(x=Hand.Wing.Index))+
    geom_histogram()
  
  avo |>
    ggplot(mapping = aes(x=Hand.Wing.Index))+
    geom_density()
  
  avo |>
    ggplot(mapping = aes(x=Hand.Wing.Index))+
    geom_bar()
  

# two variables -----------------------------------------------------------

  
  
# Continuous x + continuous y
  
    # Kipp's distance = space between the tip of the longest primary feather and the tip of the first secondary feather on a bird's folded wing
    # HWI It is the ratio of the Kipp's distance (the length from the carpal joint to the tip of the longest primary feather) to the total wing chord (the distance from the carpal joint to the tip of the first secondary feather)
  
    # geom point
  
      avo |>
        ggplot(mapping = aes(x = Hand.Wing.Index,
                             y = Kipps.Distance))+
        geom_point()
  
    # geom line
  
    avo |>
      ggplot(mapping = aes(x = Hand.Wing.Index,
                           y = Kipps.Distance))+
      geom_line() # doesn't make sense here
    
    avo |>
      mutate(rounded_hwi = round(Hand.Wing.Index)) |>
      group_by(rounded_hwi) |>
      summarise(mean_kipps = mean(Kipps.Distance)) |>
      ggplot(mapping = aes(x = rounded_hwi,
                           y = mean_kipps))+
      geom_line() # makes more sense, but still probably not what we'd want
    
    # geom abline
    
      kipps_v_hwi_model <- avo |> lm(formula = Kipps.Distance ~ Hand.Wing.Index)
      
      ggplot(data = avo,mapping = aes(x = Hand.Wing.Index,
                                      y = Kipps.Distance))+
        geom_point()+
        geom_abline(slope = kipps_v_hwi_model$coefficients[2],
                    intercept = kipps_v_hwi_model$coefficients[1],
                    color = "blue")
      
      # cleaning it up a bit
      
        ggplot(data = avo,mapping = aes(x = Hand.Wing.Index,
                                        y = Kipps.Distance))+
          geom_point(alpha=0.1)+
          geom_abline(slope = kipps_v_hwi_model$coefficients[2],
                      intercept = kipps_v_hwi_model$coefficients[1],
                      color = "blue")+
          theme_bw()
    
    
    # geom smooth
    
        ggplot(data = avo,mapping = aes(x = Hand.Wing.Index,
                                        y = Kipps.Distance))+
          geom_point()+
          geom_smooth()
        
        
      ggplot(data = avo,mapping = aes(x = Hand.Wing.Index,
                                      y = Kipps.Distance))+
        geom_point()+
        geom_smooth(method = "lm")

    


# categorical x + continuous y
  
  #geom_bar    
      
    avo |>
      group_by(Order1) |>
      summarise(mean_mass = mean(Mass)) |>
      slice_max(n = 5, order_by = mean_mass) |>
      ggplot(mapping = aes(y = mean_mass, x = Order1)) +
      geom_bar(stat = "identity")
        
    # as above, but with error bars
    
      avo |>
        group_by(Order1) |>
        summarise(mean_mass = mean(Mass),
                  min_mass = min(Mass),
                  max_mass = max(Mass)) |>
        slice_max(n = 5, order_by = mean_mass) |>
        ggplot(mapping = aes(y = mean_mass,x= Order1)) +
        geom_bar(stat = "identity") +
        geom_errorbar(mapping = aes(ymin = min_mass,
                                    ymax = max_mass))
      
      # default setting (counts)
      
        avo |>
          filter(Order1 %in% c("Struthioniformes",
                               "Cathartiformes",
                               "Gaviiformes",
                               "Sphenisciformes",
                               "Ciconiiformes")) |>
          ggplot(mapping = aes(x= Order1)) +
          geom_bar()
    
  # geom boxplot
        
        avo |>
          filter(Order1 %in% c("Struthioniformes",
                               "Cathartiformes",
                               "Gaviiformes",
                               "Sphenisciformes",
                               "Ciconiiformes")) |>
          ggplot(mapping = aes(x= Order1,
                               y = Wing.Length,
                               fill = Trophic.Level)) +
          geom_bar()    

  # geom_violin
        
        avo |>
          filter(Order1 %in% c("Struthioniformes",
                               "Cathartiformes",
                               "Gaviiformes",
                               "Sphenisciformes",
                               "Ciconiiformes")) |>
          ggplot(mapping = aes(x= Order1,
                               y = Wing.Length)) +
          geom_violin()
        
        # comparing box vs violin 
        
        avo |>
          filter(Order1 %in% c("Struthioniformes",
                               "Cathartiformes",
                               "Gaviiformes",
                               "Sphenisciformes",
                               "Ciconiiformes")) |>
          ggplot(mapping = aes(x= Order1,
                               y = Wing.Length)) +
          geom_violin()+
          geom_boxplot(alpha= 0.1)
    
# continuous x + categorical y
  
  # functions from cat x and cont y, just flipped
        
        #geom_bar    
        
        avo |>
          group_by(Order1) |>
          summarise(mean_mass = mean(Mass)) |>
          slice_max(n = 5, order_by = mean_mass) |>
          ggplot(mapping = aes(x = mean_mass, y = Order1)) +
          geom_bar(stat = "identity")
        
        #geom_bar    
        
        avo |>
          group_by(Order1) |>
          summarise(mean_mass = mean(Mass)) |>
          slice_max(n = 5, order_by = mean_mass) |>
          ggplot(mapping = aes(y = mean_mass, x = Order1)) +
          geom_bar(stat = "identity")+
          coord_flip()
        
    # geom joy        
        
        avo |>
          group_by(Order1) |>
          mutate(mean_mass = mean(Mass)) |>
          filter(Order1 %in% c("Struthioniformes",
                               "Cathartiformes",
                               "Gaviiformes",
                               "Sphenisciformes",
                               "Ciconiiformes")) |>
          ggplot(mapping = aes(x=Wing.Length,
                               y=Order1,
                               group = Order1))+
          geom_density_ridges()
              


# categorical x + categorical y

  avo |>
    filter(Family1 %in% c("Psittacidae","Cacatuidae"))|>
    ggplot(mapping = aes(x = Family1,y = Habitat))+
    geom_count()
  
  
  avo |>
    group_by(Family1, Trophic.Level) |>
    mutate(n_species = n()) |>
    filter(Family1 %in% c("Psittacidae","Cacatuidae"))|>
    ggplot(mapping = aes(x = Family1,
                         y = Trophic.Level,
                         fill = n_species))+
    geom_raster()
  
  
  avo |>
    group_by(Family1, Trophic.Level) |>
    mutate(n_species = n(),
           log10_species = n() |> log10()) |>
    filter(Family1 %in% c("Psittacidae", "Cacatuidae"))|>
    ggplot(mapping = aes(x = Family1,
                         y = Trophic.Level,
                         fill = log10_species))+
    geom_tile()
  
        
    
#  more than 2 variables --------------------------------------------------

  # color
  
  avo |>
    filter(Family1 %in% c("Psittacidae","Cacatuidae"))|>
    group_by(Family1,Habitat) |>
    summarise(mean_mass = mean(Mass)) |>
    slice_max(n = 5, order_by = mean_mass) |>
    ggplot(mapping = aes(y = mean_mass, x = Family1,fill=Habitat)) +
    geom_bar(stat = "identity")
  
  avo |>
    filter(Family1 %in% c("Psittacidae","Cacatuidae"))|>
    group_by(Family1,Habitat) |>
    summarise(mean_mass = mean(Mass)) |>
    slice_max(n = 5, order_by = mean_mass) |>
    ggplot(mapping = aes(y = mean_mass, x = Family1,fill=Habitat)) +
    geom_bar(stat = "identity",position = "dodge")
  
  
    # facet wrap, facet grid

  
    avo |>
      filter(Family1 %in% c("Psittacidae","Cacatuidae"))|>
      ggplot(mapping = aes(x = Mass,
                           y = Wing.Length))+
      geom_point()+
      facet_wrap(~Family1)
    
    avo |>
      filter(Family1 %in% c("Psittacidae","Cacatuidae"))|>
      ggplot(mapping = aes(x = Mass,
                           y = Wing.Length))+
      geom_point()+
      facet_grid(Family1~Trophic.Niche)
    
  