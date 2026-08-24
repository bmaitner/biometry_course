
library(readr)
library(tidyverse)

code_data <- readr::read_rds("https://github.com/bmaitner/R_citations/raw/refs/heads/main/data/cite_data.RDS") |>
  mutate(r_scripts_available = case_when(r_scripts_available == "yes" ~ 1,
                                         r_scripts_available == "no" ~ 0)) |>
  mutate(data_available = case_when(data_available == "yes" ~ 1,
                                    data_available == "no" ~ 0)) |>
  
  mutate(citations = as.numeric(citations),
         open_access = as.numeric(open_access)) |>
  mutate(age_y = year-2010)

saveRDS(object = code_data,file = "data/Code_sharing/code_data.RDS")
