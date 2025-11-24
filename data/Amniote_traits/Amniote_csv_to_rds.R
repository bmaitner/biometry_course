traits <- read.csv("data/Amniote_traits/Amniote_Database_Aug_2015.csv",
                   na.strings = -999)

saveRDS(object = traits,file = "data/Amniote_traits/Amniote_Database_Aug_2015.rds")
