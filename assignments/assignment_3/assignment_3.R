
library(emdbook)
library(ggplot2)
library(readr)
library(tidyverse)


# 1a ----------------------------------------------------------------------

  # This model is focused on explaining how often papers are cited as a function of different factors.
    # r_scripts_available is a binary variable, where papers either share their code (1) or don't (0)
    # age_y is the age, in years, of a publication
    # open access is a binary variable that tells whether the paper is free to access (1) or not (0)


  #load and reformat the data
  
  citation_data <- readr::read_rds("https://github.com/bmaitner/R_citations/raw/refs/heads/main/data/cite_data.RDS") %>%
    mutate(age_y = 2022-year) %>%
    mutate(r_scripts_available = case_when(r_scripts_available == "yes" ~ 1,
                                           r_scripts_available == "no" ~ 0)) %>%
    mutate(citations = as.numeric(citations),
           open_access = as.numeric(open_access)) %>%
    ungroup()%>%
    select(r_scripts_available,citations,open_access,age_y) %>%
    na.omit()
  
  # plot if you like 
  
  citation_data %>%
    ggplot(mapping = aes(x = age_y,y = citations))+
    geom_point()

  # Fit a full model
  
  cites.fit <- mle2(citations ~ dpois(lambda = a*age_y^b +
                                        int +
                                        rsa*r_scripts_available^d +
                                        oa*open_access^c),
                    start = list(a=0.17,
                                 nt=1,
                                 rsa=0.1,
                                 oa=0.1,
                                 b=1,
                                 c=1,
                                 d=1),
                    data = citation_data)
  
  # AIC initial
    AIC(cites.fit)
  

# 1b ----------------------------------------------------------------------

  # This model is focused on what determines rates of R code sharing by authors.
    # r_scripts_available is a binary variable, where papers either share their code (1) or don't (0)
    # year is the year of publication (relative to 2010).
    # open_access is a binary variable that tells whether the paper is free to access (1) or not (0)
    # data_available is a binary variable that tells whether the data are publicly available (1) or not (0)
    
    
  code_data <- readr::read_rds("https://github.com/bmaitner/R_citations/raw/refs/heads/main/data/cite_data.RDS") %>%
    mutate(r_scripts_available = case_when(r_scripts_available == "yes" ~ 1,
                                           r_scripts_available == "no" ~ 0)) %>%
    mutate(data_available = case_when(data_available == "yes" ~ 1,
                                      data_available == "no" ~ 0)) %>%
    
    mutate(citations = as.numeric(citations),
           open_access = as.numeric(open_access)) %>%
    mutate(year = year-2010)
  

  # note that for this function I use a logistic transform to ensure the probability stays between 0 and 1 during optimization
  # 
  

  sharing.fit <- mle2(
    r_scripts_available ~ dbinom(size = 1,
                            prob = plogis(int +
                                            y * year^b +
                                            d * data_available^e +
                                            o * open_access^p
                                            )),
    start = list(int = 0,
                 y = 0,
                 b = 1,
                 d = 0,
                 e = 1,
                 o = 0,
                 p = 1),
    data = code_data
  )
  
  


# 1c ----------------------------------------------------------------------

  # This model attempts to explain size variation in the wings of birds
    # Wing.length is mean adult wing length
    # Mass is mean adult body mass
    # Range.size is the area of the geographic range of each species
    # Order1 is a categorical variable that lists the taxonomic Order each species fall into.
  
  # Note that I provide two ways to load the avonet dataset in case the csv file won't load for some of you.
  
  avonet <- read_rds("https://github.com/bmaitner/Statistical_ecology_course/raw/refs/heads/main/data/Avonet/AVONET1_BirdLife.rds") %>%
    select(Order1, Wing.Length, Mass, Range.Size) %>%
    na.omit()
  
  avonet  <- read.csv("https://github.com/bmaitner/Statistical_ecology_course/raw/refs/heads/main/data/Avonet/AVONET1_BirdLife.csv") %>%
    select(Order1, Wing.Length, Mass, Range.Size) %>%
    na.omit()
  
  avonet %>%
    ggplot(mapping = aes(y=Wing.Length,x=Mass))+
    geom_point()

  # Note: there is a lot of data here, it may take a while to fit the full model
  
  avonet.fit <- mle2(Wing.Length ~ dlnorm(meanlog = int +
                                            m*log(Mass)^b +
                                            rs*Range.Size,
                                          sdlog = sd),
                     start = list(m = 1,
                                  b = 1,
                                  sd = 1,
                                  int = 0,
                                  rs = 10),
                     data = avonet,
                     parameters = list(int ~ Order1))
  



  
