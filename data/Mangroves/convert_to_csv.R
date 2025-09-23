#converting to csv

library(readxl)

mangroves <- read_xlsx("data/Mangroves/Cannicci_et_al_Final_dataset_4.0.xlsx")

write.csv(x = mangroves,file = "data/Mangroves/Cannicci_et_al_Final_dataset_4.0.csv")
