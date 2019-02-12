# Time test with st_simplify for different dTolerance

library(tidyverse)
library(sf)
library(tmap)

ca_eco <- read_sf(dsn = ".", layer = "ca_eco") %>% # Get data!
  dplyr::select(US_L3NAME) %>% # Only select column with eco-regions
  rename(Region = US_L3NAME) %>% # Rename that column to "Region"
  st_simplify(dTolerance = 100) 

plot(ca_eco) 

# Without st_simplify:

ca_eco2 <- read_sf(dsn = ".", layer = "ca_eco") %>% # Get data!
  dplyr::select(US_L3NAME) %>% # Only select column with eco-regions
  rename(Region = US_L3NAME)

plot(ca_eco2) # Elapsed 15.855 s

ca_eco2 <- read_sf(dsn = ".", layer = "ca_eco") %>% # Get data!
  dplyr::select(US_L3NAME) %>% # Only select column with eco-regions
  rename(Region = US_L3NAME) %>% # Rename that column to "Region"
  st_simplify(dTolerance = 100000) 

plot(ca_eco2)

ca_eco3 <- read_sf(dsn = ".", layer = "ca_eco") %>% # Get data!
  dplyr::select(US_L3NAME) %>% # Only select column with eco-regions
  rename(Region = US_L3NAME) %>% # Rename that column to "Region"
  st_simplify(dTolerance = 10000) 

plot(ca_eco3)



ca_eco4 <- read_sf(dsn = ".", layer = "ca_eco") %>% # Get data!
  dplyr::select(US_L3NAME) %>% # Only select column with eco-regions
  rename(Region = US_L3NAME) %>% # Rename that column to "Region"
  st_simplify(dTolerance = 1000) 

plot(ca_eco4)


ca_eco5 <- ca_eco4 <- read_sf(dsn = ".", layer = "ca_eco") %>% # Get data!
  dplyr::select(US_L3NAME) %>% # Only select column with eco-regions
  rename(Region = US_L3NAME) %>% # Rename that column to "Region"
  st_simplify(dTolerance = 100)

plot(ca_eco5)

# tmap maps: 

tm_shape(ca_eco) + 
  tm_fill("Region", legend.show = FALSE, palette = "Dark2")

tm_shape(ca_eco5) +
  tm_fill("Region", legend.show = FALSE, palette = "Dark2")

tm_shape(ca_eco4) +
  tm_fill("Region", legend.show = FALSE, palette = "Dark2")

tm_shape(ca_eco3) +
  tm_fill("Region", legend.show = FALSE, palette = "Dark2")

tm_shape(ca_eco2) +
  tm_fill("Region", legend.show = FALSE, palette = "Dark2")








