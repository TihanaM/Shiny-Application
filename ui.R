library(shiny)
library(plotly)

life_exp<-read.csv("life_exp.csv")
fertility<-read.csv("fertility.csv")
GDP<-read.csv("GDP.csv")
names(life_exp) <- gsub("X", "Year_", names(life_exp))
names(fertility) <- gsub("X", "Year_", names(fertility))
names(GDP) <- gsub("X", "Year_", names(GDP))

shinyUI(fluidPage(
        titlePanel("Fertility, Life Expectancy and GDP Around the World: 1960-2014"),
        sidebarLayout(
                sidebarPanel(
                        helpText("Pick a year between 1960 and 2014 to explore the global Fertility, Life Expectancy and GDP trends.
                           Below you can find the global averages (by country) of the three factors in a given year. On the right,
                           they can be visualized in a multiparameter plot, as well as individually on World Maps under the different tabs."),
                        tags$hr(),
                        selectInput('year', 'Pick a Year', c(1960:2014), selected=2014),
                        tags$hr(),
                        tags$b("Fertility (number of children)"),
                        verbatimTextOutput("txt_f"),
                        tags$hr(),
                        tags$b("Life Expectancy (years)"),
                        verbatimTextOutput("txt_lf"),
                        tags$hr(),
                        tags$b("GDP per capita (USD)"),
                        verbatimTextOutput("txt_gdp"),
                        tags$hr(),
                        helpText("Data has been obtained from the Data Worldbank: http://data.worldbank.org.
                                        Note that some values for some years are missing.")
                ),


                mainPanel(
                        tabsetPanel(type = "tabs",
                                   tabPanel("Graph", br(), plotlyOutput("plot")),
                                   tabPanel("Fertility Map", br(), plotlyOutput("plot_f")),
                                   tabPanel("Life Expectancy Map", br(), plotlyOutput("plot_lf")),
                                   tabPanel("GDP per capita Map", br(), plotlyOutput("plot_gdp"))
                        )



                )
)
))




