#Lecture 27 reproducibility 

library(renv)

# set up renv for a project

  renv::init()

# Save the current state of the library  
  renv::snapshot()
  
# If you wanted to alter your installed functions to match the ones storedm
  # Use restore:
  
  ?renv::restore
  