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

#Read the datafile and skip lines determinded by the function above
data <- read.csv("../Data/suites_dw_Table1.txt", sep ="|", 
                 skip = find_header_lines("../Data/suites_dw_Table1.txt")) %>% 
  .[-1,]

#Make a plot of galaxy size in regards to distance from Earth. 
data %>% 
  ggplot(aes(x = D, y = log_lk)) + 
  geom_point()+ 
  geom_smooth() +
  xlab("Distance to galaxy in Mpc (D)") + 
  ylab("logarithm of the stellar mass (log_lk)") + 
  theme_classic()
 
#From the plot we observe that the observation of small galaxies 
#diminishes as the distance become grater.
#From distance of close to 0 we have several observations below 5.0, but
#these completely disperse when the distance become greater. Under the assumption
#that there would be a equal distribution of galaxy of all sizes throughout the
#universe we would belive there to be small galaxies further away from earth, 
#not only close to Earth. These observation could be caused by our 
#technology not being sufficient to see smaller galaxies from a greater distance. 
