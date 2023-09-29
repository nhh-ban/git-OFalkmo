library(tidyverse)

find_header_lines <- function(file_path, header_pattern = "--") {
  # Initialize a line counter
  line_count <- 0
  
  # Open the file for reading
  con <- file(file_path, "r")
  
  # Read lines until the header pattern is found
  while (TRUE) {
    line <- readLines(con, n = 1)
    if (length(line) == 0) {
      # End of file reached without finding the header
      warning("Header not found in the file.")
      break
    }
    
    line_count <- line_count + 1
    
    # Customize the condition based on your header structure
    if (grepl(header_pattern, line)) {
      # Header found, exit the loop
      break
    }
  }
  
  # Close the file
  close(con)
  
  # Return the line number of the header
  return(line_count-2)
}

data <- read.csv("../Data/suites_dw_Table1.txt", sep ="|", 
                 skip = find_header_lines("../Data/suites_dw_Table1.txt")) %>% 
  .[-1,]

