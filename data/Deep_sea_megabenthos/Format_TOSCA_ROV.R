# Function to read in poorly formatted data

read_pangaea_tab <- function(file){
  
  # find end of comments
  
  end_of_comment_block <- grep(pattern = "*/",
                               x = readLines(file, warn = FALSE),
                               fixed = TRUE)
  
  # read in file
  
  read.delim(file = file,
             sep = "\t",
             skip = end_of_comment_block)
  
  
}

tosca <- read_pangaea_tab("data/Deep_sea_megabenthos/TOSCA_ROV.tab")

write.csv(x = tosca,file = "data/Deep_sea_megabenthos/TOSCA_ROV.csv")
