#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)
library(sf)
library(shinythemes)
library(tmap)
library(leaflet)

ca_counties <- read_sf(dsn = ".", layer = "california_county_shape_file") # Read data
st_crs(ca_counties) = 4326 

ca_dams <- read_sf(dsn = ".", layer = "California_Jurisdictional_Dams") %>% # Read data
  rename(Condition = Condition_)

# Define UI for application that draws a histogram
ui <- fluidPage(
  theme = shinytheme("slate"),
   # Application title
   titlePanel("California State Jurisdiction Dams"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
         sliderInput("height",
                     "Minimum dam height (ft):",
                     min = 0,
                     max = 770,
                     value = 0)
        
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
         leafletOutput("map")
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
   
  # Creating the reactive output ('map')
   output$map <- renderLeaflet({
     
     dams_inc <- ca_dams %>% 
     filter(Dam_Height >= input$height) # Filter based on input selection from height widget

     # Creating map
     dam_map <- 
       tm_basemap("CartoDB.DarkMatter") +
       tm_shape(ca_counties) +
       tm_borders(col = "gray50") +
       tm_shape(dams_inc) +
       tm_dots(size = "Capacity_a", col = "Capacity_a")
     
     # Leaflet 
     tmap_leaflet(dam_map)
     
   })
}

# Run the application 
shinyApp(ui = ui, server = server)

