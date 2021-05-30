# Load packages
library(shiny)
library(gmapsdistance)
library(ggmap)
library(data.table)


load("data/source")



# Define UI ----

ui <- fluidPage(
  titlePanel("Tourism Map & Transport Fee"),
  sidebarLayout(
    sidebarPanel(
      
      fluidPage(
        selectInput("province",
                    label="Select province", 
                    choices = list("Chungcheongbuk-do" = 1, "Geongsang buk-do" = 2,
                                   "Jeolla buk-do" = 3)),
        checkboxGroupInput("options",
                           h3("options"),
                           choices = list("show train_stations" = 1, 
                                          "switch on"=2),selected =2),
        
        checkboxInput("distance", "calculate fee between sites", value = FALSE),
      
      
      sliderInput("sites", h3("Number of sites"),
                  min = 0, max = 80, value = 20))
      ),
    mainPanel(
      strong("Using this app will help you to decide whether to rent a car or not."),
      br(),
      em("Turning off fee will speed up. Otherwise wait 10sec"),
      p("Data is from ",
        span("datalab.visitkorea", style = "color:blue"),
        "and calculated by using gmapsdistance package."),
      
      conditionalPanel('output.show == TRUE',textOutput('distance')),
      
      plotOutput("map")

    )
  )
)
# Define server logic ----


server <- function(input, output) {
  
  sitesInput <- reactive({
    if (input$province==1) {return (cb_latlon[1:input$sites,])}
    else if (input$province==2) {return (geongbuk_latlon[1:input$sites,])}
    else if (input$province==3) {return (geonbuk_latlon[1:input$sites,])}
    
  })
  
  stationInput <- reactive({
    if(input$options==1){
      if (input$province==1)  {return (cb_station_latlon)} 
      else if (input$province==2) {return (geongbuk_station_latlon)} 
      else if (input$province==3) {return (geonbuk_station_latlon)}
    }
    else {return(cb_station_latlon[78,])}
  })
  
  distanceInput <- reactive({
    if (input$distance==TRUE){
      if (input$province==1){return (mean(gmapsdistance(cb_origin[1:input$sites,], cb_destination, mode="transit", key="AIzaSyCYEVJ01CZ-tJU75ZA-TII97dpuk44J2W8")$Distance[,2], na.rm=T))}
      else if (input$province==2){return(mean(gmapsdistance(geong_origin[1:input$sites,], geong_destination, mode="transit", key="AIzaSyCYEVJ01CZ-tJU75ZA-TII97dpuk44J2W8")$Distance[,2],na.rm=T))}
      else if (input$province==3){return (mean(gmapsdistance(geon_origin[1:input$sites,], geon_destination, mode="transit", key="AIzaSyCYEVJ01CZ-tJU75ZA-TII97dpuk44J2W8")$Distance[,2],na.rm=T))}
    }
  })
  
  output$show <- reactive({
    return(values$distance)
  }) 
  
  output$distance <- renderText({
    if (input$distance ==TRUE){paste0('the mean fee between sites is ',trunc(as.numeric(distanceInput())*1.32, prec = 1),' won')}
    else {print(" ")}
  })
  
  provinceInput <- reactive({
    if (input$province==1) {return (c)
    } else if (input$province==2) {return (g)
    } else if (input$province==3) {return (j)}
  })
  
  output$map <- renderPlot({
    provinceInput()+
      geom_point(data = stationInput(), aes(lon, lat), size = 2.5, color='blue')+
      geom_point(data = sitesInput(), aes(lon, lat), size = 2.5, color='red')
  })
}

shinyApp(ui = ui, server = server)
