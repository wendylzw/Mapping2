library(shiny)
library(shinydashboard)
library(ggplot2)


ui <- dashboardPage(
  dashboardHeader(title = "Public Assistance Funded Projects",titleWidth = 220),
  dashboardSidebar(
    selectInput(
      "myyear",
      "choose a year:",
      unique(df_map_new$declarationYear)),
    
    selectInput(
      "mystate",
      "choose a state:",
      c("Whole",unique(df_map_new$state)),
      selected= "Whole"),
    
    radioButtons(
      "mytype",
      "choose a incidentType:",
      c("Hurricane","Coastal Storm")),
    
    helpText("Note: The Public Assistance Funded",
    "Projects Details dataset is",
    "from OpenFEMA website",
    "https://www.fema.gov/openfema-data-page/public-assistance-funded-projects-details-v1")
    ),
  
  dashboardBody(
    fluidRow(
    box(plotOutput("map"),width = 12,solidHeader = T,collapsible = T,title = "Obligated Mapping"),
    box(plotOutput("barplot"),width = 12,solidHeader = T,collapsible = T,title = "Damage Category Count Barplot")
    )
))

server <- function(input, output) {
  output$map <- renderPlot({
    if(input$mystate == "Whole"){
      country_obligate_map(input$myyear,input$mytype)}
    else{
      obligate_map(input$myyear,input$mystate,input$mytype)}
  })
  
  output$barplot <- renderPlot({
    if(input$mystate == "Whole"){
      country_dcc_bar(input$myyear,input$mytype)}
    else{
      dcc_bar(input$myyear,input$mystate,input$mytype)}
  })
}
shinyApp(ui, server)