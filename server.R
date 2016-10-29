library(shiny)
library(plotly)
library(ggplot2)

function(input, output, session) {
        life_exp<-read.csv("life_exp.csv")
        fertility<-read.csv("fertility.csv")
        GDP<-read.csv("GDP.csv")
        names(life_exp) <- gsub("X", "Year_", names(life_exp))
        names(fertility) <- gsub("X", "Year_", names(fertility))
        names(GDP) <- gsub("X", "Year_", names(GDP))






output$plot <- renderPlotly({
        YEAR<-paste("Year_", input$year, sep="")
        YEAR<-as.character(YEAR)
        df<-data.frame(life_exp[1:4], life_exp[YEAR], fertility[YEAR], GDP[YEAR])
        colnames(df) <- c("Code", "Region", "Income", "Country_Name","life_exp","fertility", "GDP" )

        plot_ly(data=df, x=~life_exp, y=~fertility, color=df$Region,
                 type = 'scatter', mode = 'markers',size = ~GDP,
                 marker = list(opacity = 0.7, sizemode = 'diameter',
                               sizeref = 1.3),
                 text = ~paste('Country:', Country_Name, '<br>Life Expectancy:', life_exp,
                               '<br>Fertility:', fertility, '<br>GDP per capita:', GDP))%>%
                layout(title = paste('Fertility vs. Life Expectancy in', input$year),
                       xaxis = list(title = 'Life Expectancy (years)'),
                       yaxis = list(title = 'Fertility (number of children born to a woman)'))
})



        output$plot_f <- renderPlotly({

                YEAR<-paste("Year_", input$year, sep="")
                df<-data.frame(life_exp[1:4], life_exp[YEAR], fertility[YEAR], GDP[YEAR])
                colnames(df) <- c("Code", "Region", "Income", "Country_Name","life_exp","fertility", "GDP" )

                l <- list(color = toRGB("grey"), width = 0.5)

                g <- list(
                        showframe = FALSE,
                        showcoastlines = FALSE,
                        projection = list(type = 'Mercator')
                )

                plot_geo(df) %>%
                        add_trace(
                                z = ~fertility, color = ~fertility, colors = 'Blues',
                                text = ~Country_Name, locations = ~Code, marker = list(line = l)) %>%
                        colorbar(title = '# of children')%>%
                        layout(title = paste('Number of Children Born to One Woman in',input$year))%>%
                           
                        layout(geo=g)
        })


        output$plot_lf <- renderPlotly({

                YEAR<-paste("Year_", input$year, sep="")
                df<-data.frame(life_exp[1:4], life_exp[YEAR], fertility[YEAR], GDP[YEAR])
                colnames(df) <- c("Code", "Region", "Income", "Country_Name","life_exp","fertility", "GDP" )

                l <- list(color = toRGB("grey"), width = 0.5)

                g <- list(
                        showframe = FALSE,
                        showcoastlines = FALSE,
                        projection = list(type = 'Mercator')
                )

                plot_geo(df) %>%
                        add_trace(
                                z = ~life_exp, color = ~life_exp, colors = 'Greens',
                                text = ~Country_Name, locations = ~Code, marker = list(line = l)) %>%
                        colorbar(title = 'Years')%>%
                        layout(title = paste('Life Expectancy in',input$year))%>%
                        layout(geo=g)
        })


        output$plot_gdp <- renderPlotly({

                YEAR<-paste("Year_", input$year, sep="")
                df<-data.frame(life_exp[1:4], life_exp[YEAR], fertility[YEAR], GDP[YEAR])
                colnames(df) <- c("Code", "Region", "Income", "Country_Name","life_exp","fertility", "GDP" )

                l <- list(color = toRGB("grey"), width = 0.5)

                g <- list(
                        showframe = FALSE,
                        showcoastlines = FALSE,
                        projection = list(type = 'Mercator')
                )

                plot_geo(df) %>%
                        add_trace(
                                z = ~GDP, color = ~GDP, colors = 'Greys',
                                text = ~Country_Name, locations = ~Code, marker = list(line = l)) %>%
                        colorbar(title = 'GDP (USD)')%>%
                        layout(title = paste('GDP per Capita in',input$year))%>%
                        layout(geo=g)
        })




        output$txtout <- renderText({

                   YEAR<-paste("YEAR_", input$year, sep="")
                paste(YEAR)
        })






        output$txt_f <- renderText({
                a<-as.character(input$year)
                YEAR<-paste("Year_", a, sep="")
                df<-data.frame(life_exp[1:4], life_exp[YEAR], fertility[YEAR], GDP[YEAR])
                colnames(df) <- c("Code", "Region", "Income", "Country_Name","life_exp","fertility", "GDP" )

                paste(signif(mean(df$fertility, na.rm=TRUE, digits=3)))
        })



        output$txt_lf <- renderText({
                a<-as.character(input$year)
                YEAR<-paste("Year_", a, sep="")
                df<-data.frame(life_exp[1:4], life_exp[YEAR], fertility[YEAR], GDP[YEAR])
                colnames(df) <- c("Code", "Region", "Income", "Country_Name","life_exp","fertility", "GDP" )

                paste( signif(mean(df$life_exp, na.rm=TRUE, digits=3)))
        })



        output$txt_gdp <- renderText({
                a<-as.character(input$year)
                YEAR<-paste("Year_", a, sep="")
                df<-data.frame(life_exp[1:4], life_exp[YEAR], fertility[YEAR], GDP[YEAR])
                colnames(df) <- c("Code", "Region", "Income", "Country_Name","life_exp","fertility", "GDP" )


                paste("$", signif(mean(df$GDP, na.rm=TRUE, digits=3)))
        })


}
