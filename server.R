source('setup.R', chdir=T)

###### SERVER SECTION OF THE APP
function(input, output) {
    #tabbed boxes in the main panel of the app where user can switch between views of the data
    output$tabsetASelected <- renderText({
        input$tabsetA
    })
    
    output$tabset3_1Selected <- renderText({
        input$tabset3_1
    })
    
    output$tabset3_4Selected <- renderText({
        input$tabset3_4
    })
    
    output$tabset3_5Selected <- renderText({
        input$tabset3_5
    })
    
    output$tabset3_6Selected <- renderText({
        input$tabset3_6
    })
    
    output$tabset3_7Selected <- renderText({
        input$tabset3_7
    })
    
    output$tabset3_12Selected <- renderText({
        input$tabset3_12
    })
    
    output$tabset3_18Selected <- renderText({
        input$tabset3_18
    })
    
    output$tabset3_20Selected <- renderText({
        input$tabset3_20
    })
    
    output$tabset3_23Selected <- renderText({
        input$tabset3_23
    })
    
    output$tabset3_24Selected <- renderText({
        input$tabset3_24
    })
    
    ### PLOTS
    
    # table A plot line plot
    output$tabAplot = renderPlotly({
        p <- plot_ly(x = tabA$Period,y=tabA$Energy, line = list(shape="linear")) %>%
            
            layout(title = "Trends and levels in GHG emissions for South Africa between 2000 and 2010",
                   xaxis = list(title = "Year"),
                   yaxis = list(title = "Gg CO<sub>2</sub> equiv"))
        
        for (item in input$tabAchkbox) {
            p <- add_trace(p, x = as.numeric(tabA$Period), y = tabA[[item]], name = item, evaluate = TRUE)
        }
        print(p)
        return(p)
    })
    
    #creating stacked graph for table A. new data frame is created from original to create stacked plot
    output$tabAstackedplot = renderPlot({
        subsettedtabA <- subset(tabA, select=c("Energy", "IPPU", "AFOLU_excl_FOLU", "AFOLU_incl_FOLU", "Waste"))
        tabAstk <- data.frame(t(subsettedtabA))
        colnames(tabAstk) <- c("CO2","a","b","c","d","e","f","g","h","i","j")
        Value <- data.frame(CO2 = unlist(tabAstk, use.names = FALSE))
        Year <- as.numeric(rep(c("2000","2001","2002","2003","2004","2005","2006","2007","2008","2009","2010"), each = 5))
        Sector <- rep(c("Energy", "IPPU", "AFOLU_excl_FOLU", "AFOLU_incl_FOLU", "Waste"), time = 11)
        tabAstk <- data.frame(Sector, Year, Value)
        
        ggplot(tabAstk, aes(x=Year, y=Value, fill=Sector)) +
            geom_area() +
            scale_fill_manual(values=c("#1f77b4", "#ff7f0e","#2ca02c","#d62728","#9467bd")) +
            theme(legend.position = "bottom", plot.title = element_text(hjust = 0.5, size = 15),
                  axis.text.x = element_text(size = 12),
                  axis.text.y = element_text(size = 12),
                  axis.title.x = element_text(size = 13),
                  axis.title.y = element_text(size = 13),
                  legend.text = element_text(size = 12),
                  panel.background = element_blank(), axis.line = element_line(colour = "#D3D3D3")) +
            scale_x_continuous(breaks = seq(0,2050,2), expand = c(0, 0)) +
            labs(x="Year", y= expression(Total~CO[2]~(Gg~CO[2]~eq))) +
            ggtitle("Trends and levels in GHG emissions for South Africa between 2000 and 2010")
    })
    
    # table A pie chart of 2010
    output$tabApie = renderPlotly({
        v <- data.frame(tabA)
        # create data frame of the 2010 data to create pie chart
        s <-data.frame(labels = c(colnames(v)[2],colnames(v)[3],colnames(v)[5],colnames(v)[6]), 
                       values = c(v[11,2],v[11,3],v[11,5],v[11,6]))
        
        plot_ly(s, labels = ~labels, values = ~values, type="pie", 
                textposition = 'inside',
                textinfo = 'label+percent',
                insidetextfont = list(color = '#FFFFFF'),
                hoverinfo = 'text',
                text = ~paste(values, "Gg CO<sub>2</sub> equiv"),
                marker = list(colors = colors, line = list(color = '#FFFFFF', width = 1)),
                showlegend = FALSE) %>%
            
            layout(title = "Pie Chart of GHG emissions for South Africa in 2010",
                   xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
                   yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
    })
    
    # table A relative difference plot
    output$tabArelplot = renderPlotly({
        datalist = list()
        for (i in 1:10) {
            # new data frame that contains percent change by year
            dat <- data.frame((((tabA[i+1,]-tabA[i,])/tabA[i+1,])*100))
            datalist[[i]] <- dat # add it to the list
        }
        
        relchangedata = do.call(rbind, datalist)
        
        p <- plot_ly()%>%
            
            layout(title = "Relative change of GHG emissions of different sectors by year",
                   xaxis = list(title = "Year"),
                   yaxis = list(title = "Percent"))
        
        for (item in input$tabAchkbox) {
            p <- add_trace(p, x = as.numeric(tabA$Period[2:nrow(tabA)]), y = relchangedata[[item]],
                           name = item, line = list(shape="linear"), evaluate = TRUE)
        }
        
        print(p)
    })
    
    #table 3.1 line plot
    output$tab3_1plot = renderPlotly({
        p <- plot_ly(x = tab3.1$Period, y = tab3.1$EG, line = list(shape="linear")) %>%
            
            layout(title = "Contribution of various sources to GHG emissions",
                   xaxis = list(title = "Year"),
                   yaxis = list(title = "Gg CO<sub>2</sub> equiv"))
        
        for (item in input$tab3_1chkbox) {
            p <- add_trace(p, x = as.numeric(tab3.1$Period), y = tab3.1[[item]], name = item, evaluate = TRUE)
        }
        print(p)
        
    })
    
    # table 3.1 relative difference plot
    output$tab3_1relplot = renderPlotly({
        datalist = list()
        for (i in 1:10) {
            # new data frame that contains percent change by year
            dat <- data.frame((((tab3.1[i+1,]-tab3.1[i,])/tab3.1[i+1,])*100))
            datalist[[i]] <- dat # add it to the list
        }
        
        relchangedata = do.call(rbind, datalist)
        
        p <- plot_ly()%>%
            
            layout(title = "Relative change of GHG emissions of different sources by year",
                   xaxis = list(title = "Year"),
                   yaxis = list(title = "Percent"))
        
        for (item in input$tab3_1chkbox) {
            p <- add_trace(p, x = as.numeric(tab3.1$Period[2:nrow(tab3.1)]), y = relchangedata[[item]],
                           name = item, line = list(shape="linear"), evaluate = TRUE)
        }
        
        print(p)
    })
    
    #table 3.4 line plot
    output$tab3_4plot = renderPlotly({
        m <- list(r=40) # l = left; r = right; t = top; b = bottom
        
        # second y-axis on the right for GHG emissions
        ay <- list(
            tickfont = list(color = "red"),
            overlaying = "y",
            side = "right",
            title = "Gg CO<sub>2</sub> equiv"
        )
        
        p <- plot_ly() %>%
            
            add_trace(x = as.numeric(tab3.4$Period), y = tab3.4$Consumption, 
                      name = "Consumption", line = list(shape="linear")) %>%
            
            layout(title = "Consumption and GHG emissions from public electricity",
                   xaxis = list(title = "Year"),
                   yaxis = list(title = "TJ"),
                   yaxis2 = ay,
                   margin = m)
        
        for (item in input$tab3_4chkbox) {
            p <- add_trace(p, x = as.numeric(tab3.4$Period), y = tab3.4[[item]], 
                           name = item, yaxis = "y2", line = list(shape="linear"), evaluate = TRUE)
        }
        
        print(p)
    })
    
    # table 3.4 relative difference plot
    output$tab3_4relplot = renderPlotly({
        datalist = list()
        for (i in 1:10) {
            # new data frame that contains percent change by year
            dat <- data.frame((((tab3.4[i+1,]-tab3.4[i,])/tab3.4[i+1,])*100))
            datalist[[i]] <- dat # add it to the list
        }
        
        relchangedata = do.call(rbind, datalist)
        
        p <- plot_ly()%>%
            
            add_trace(p, x = as.numeric(tab3.4$Period[2:nrow(tab3.4)]), y = relchangedata$Consumption, 
                      name = "Consumption", line = list(shape="linear")) %>%
            
            layout(title = "Relative change of consumption and GHG emissions by year",
                   xaxis = list(title = "Year"),
                   yaxis = list(title = "Percent"))
        
        for (item in input$tab3_4chkbox) {
            p <- add_trace(p, x = as.numeric(tab3.4$Period[2:nrow(tab3.4)]), y = relchangedata[[item]],
                           name = item, line = list(shape="linear"), evaluate = TRUE)
        }
        
        print(p)
    })
    
    #table 3.5 line plot
    output$tab3_5plot = renderPlotly({
        m <- list(r=40) # l = left; r = right; t = top; b = bottom
        
        # second y-axis on the right for GHG emissions
        ay <- list(
            tickfont = list(color = "red"),
            overlaying = "y",
            side = "right",
            title = "Gg CO<sub>2</sub> equiv"
        )
        
        p <- plot_ly() %>%
            
            add_trace(x = as.numeric(tab3.5$Period), y = tab3.5$Consumption, 
                      name = "Consumption", line = list(shape="linear")) %>%
            
            layout(title = "Consumption and GHG emissions from auto electricity",
                   xaxis = list(title = "Year"),
                   yaxis = list(title = "TJ"),
                   yaxis2 = ay,
                   margin = m)
        
        for (item in input$tab3_5chkbox) {
            p <- add_trace(p, x = as.numeric(tab3.5$Period), y = tab3.5[[item]], 
                           name = item, yaxis = "y2", line = list(shape="linear"), evaluate = TRUE)
        }
        
        print(p)
    })
    
    # table 3.5 relative difference plot
    output$tab3_5relplot = renderPlotly({
        datalist = list()
        for (i in 1:10) {
            # new data frame that contains percent change by year
            dat <- data.frame((((tab3.5[i+1,]-tab3.5[i,])/tab3.5[i+1,])*100))
            datalist[[i]] <- dat # add it to the list
        }
        
        relchangedata = do.call(rbind, datalist)
        
        p <- plot_ly()%>%
            
            add_trace(p, x = as.numeric(tab3.5$Period[2:nrow(tab3.5)]), y = relchangedata$Consumption, 
                      name = "Consumption", line = list(shape="linear")) %>%
            
            layout(title = "Relative change of consumption and GHG emissions by year",
                   xaxis = list(title = "Year"),
                   yaxis = list(title = "Percent"))
        
        for (item in input$tab3_5chkbox) {
            p <- add_trace(p, x = as.numeric(tab3.5$Period[2:nrow(tab3.5)]), y = relchangedata[[item]],
                           name = item, line = list(shape="linear"), evaluate = TRUE)
        }
        
        print(p)
    })
    
    #table 3.6 line plot 
    output$tab3_6plot = renderPlotly({
        m <- list(r=40) # l = left; r = right; t = top; b = bottom
        
        # second y-axis on the right for GHG emissions
        ay <- list(
            tickfont = list(color = "red"),
            overlaying = "y",
            side = "right",
            title = "Gg CO<sub>2</sub> equiv"
        )
        
        p <- plot_ly() %>%
            
            add_trace(x = as.numeric(tab3.6$Period), y = tab3.6$Consumption, 
                      name = "Energy", line = list(shape="linear")) %>%
            
            layout(title = "Consumption and GHG emissions from petroleum refining",
                   xaxis = list(title = "Year"),
                   yaxis = list(title = "TJ"),
                   yaxis2 = ay,
                   margin = m)
        
        for (item in input$tab3_6chkbox) {
            p <- add_trace(p, x = as.numeric(tab3.6$Period), y = tab3.6[[item]], 
                           name = item, yaxis = "y2", line = list(shape="linear"), evaluate = TRUE)
        }
        
        print(p)
    })
    
    # table 3.6 relative difference plot
    output$tab3_6relplot = renderPlotly({
        datalist = list()
        for (i in 1:10) {
            # new data frame that contains percent change by year
            dat <- data.frame((((tab3.6[i+1,]-tab3.6[i,])/tab3.6[i+1,])*100))
            datalist[[i]] <- dat # add it to the list
        }
        
        relchangedata = do.call(rbind, datalist)
        
        p <- plot_ly()%>%
            
            add_trace(p, x = as.numeric(tab3.6$Period[2:nrow(tab3.6)]), y = relchangedata$Consumption, 
                      name = "Consumption", line = list(shape="linear")) %>%
            
            layout(title = "Relative change of consumption and GHG emissions by year",
                   xaxis = list(title = "Year"),
                   yaxis = list(title = "Percent"))
        
        for (item in input$tab3_6chkbox) {
            p <- add_trace(p, x = as.numeric(tab3.6$Period[2:nrow(tab3.6)]), y = relchangedata[[item]],
                           name = item, line = list(shape="linear"), evaluate = TRUE)
        }
        
        print(p)
    })
    
    #table 3.7 line plot
    output$tab3_7plot = renderPlotly({
        p <- plot_ly() %>%
            
            layout(title = "GHG emissions from manufacturing of solid fuels",
                   xaxis = list(title = "Year"),
                   yaxis = list(title = "Gg CO<sub>2</sub> equiv"))
        
        for (item in input$tab3_7chkbox) {
            p <- add_trace(p, x = as.numeric(tab3.7$Period), y = tab3.7[[item]], 
                           name = item, line = list(shape="linear"), evaluate = TRUE)
        }
        print(p)
        
    })
    
    # table 3.7 relative difference plot
    output$tab3_7relplot = renderPlotly({
        datalist = list()
        for (i in 1:10) {
            # new data frame that contains percent change by year
            dat <- data.frame((((tab3.7[i+1,]-tab3.7[i,])/tab3.7[i+1,])*100))
            datalist[[i]] <- dat # add it to the list
        }
        
        relchangedata = do.call(rbind, datalist)
        
        p <- plot_ly()%>%
            
            layout(title = "Relative change of GHG emissions by year",
                   xaxis = list(title = "Year"),
                   yaxis = list(title = "Percent"))
        
        for (item in input$tab3_7chkbox) {
            p <- add_trace(p, x = as.numeric(tab3.7$Period[2:nrow(tab3.7)]), y = relchangedata[[item]],
                           name = item, line = list(shape="linear"), evaluate = TRUE)
        }
        
        print(p)
    })
    
    #table 3.12 line plot
    output$tab3_12plot = renderPlotly({
        p <- plot_ly() %>%
            
            layout(title = "GHG emissions from international aviation",
                   xaxis = list(title = "Year"),
                   yaxis = list(title = "Gg CO<sub>2</sub> equiv"))
        
        for (item in input$tab3_12chkbox) {
            p <- add_trace(p, x = as.numeric(tab3.12$Period), y = tab3.12[[item]], 
                           name = item, line = list(shape="linear"), evaluate = TRUE)
        }
        print(p)
        
    })
    
    # table 3.12 relative difference plot
    output$tab3_12relplot = renderPlotly({
        datalist = list()
        for (i in 1:10) {
            # new data frame that contains percent change by year
            dat <- data.frame((((tab3.12[i+1,]-tab3.12[i,])/tab3.12[i+1,])*100))
            datalist[[i]] <- dat # add it to the list
        }
        
        relchangedata = do.call(rbind, datalist)
        
        p <- plot_ly()%>%
            
            layout(title = "Relative change of GHG emissions by year",
                   xaxis = list(title = "Year"),
                   yaxis = list(title = "Percent"))
        
        for (item in input$tab3_12chkbox) {
            p <- add_trace(p, x = as.numeric(tab3.12$Period[2:nrow(tab3.12)]), y = relchangedata[[item]],
                           name = item, line = list(shape="linear"), evaluate = TRUE)
        }
        
        print(p)
    })
    
    #table 3.18 line plot
    output$tab3_18plot = renderPlotly({
        m <- list(r=40) # l = left; r = right; t = top; b = bottom
        
        # second y-axis on the right for GHG emissions
        ay <- list(
            tickfont = list(color = "red"),
            overlaying = "y",
            side = "right",
            title = "Gg CO<sub>2</sub> equiv"
        )
        
        p <- plot_ly() %>%
            
            add_trace(x = as.numeric(tab3.18$Period), y = tab3.18$Consumption, 
                      name = "Consumption", line = list(shape="linear")) %>%
            
            layout(title = "Consumption and GHG emissions from non-specified sector",
                   xaxis = list(title = "Year"),
                   yaxis = list(title = "TJ"),
                   yaxis2 = ay,
                   margin = m)
        
        for (item in input$tab3_18chkbox) {
            p <- add_trace(p, x = as.numeric(tab3.18$Period), y = tab3.18[[item]], 
                           name = item, yaxis = "y2", line = list(shape="linear"), evaluate = TRUE)
        }
        
        print(p)
    })
    
    # table 3.18 relative difference plot
    output$tab3_18relplot = renderPlotly({
        datalist = list()
        for (i in 1:10) {
            # new data frame that contains percent change by year
            dat <- data.frame((((tab3.18[i+1,]-tab3.18[i,])/tab3.18[i+1,])*100))
            datalist[[i]] <- dat # add it to the list
        }
        
        relchangedata = do.call(rbind, datalist)
        
        p <- plot_ly()%>%
            
            add_trace(p, x = as.numeric(tab3.18$Period[2:nrow(tab3.18)]), y = relchangedata$Consumption, 
                      name = "Consumption", line = list(shape="linear")) %>%
            
            layout(title = "Relative change of consumption and GHG emissions by year",
                   xaxis = list(title = "Year"),
                   yaxis = list(title = "Percent"))
        
        for (item in input$tab3_18chkbox) {
            p <- add_trace(p, x = as.numeric(tab3.18$Period[2:nrow(tab3.18)]), y = relchangedata[[item]],
                           name = item, line = list(shape="linear"), evaluate = TRUE)
        }
        
        print(p)
    })
    
    #table 3.20 line plot
    output$tab3_20plot = renderPlotly({
        p <- plot_ly() %>%
            
            layout(title = "Fugitive emissions from coal mining",
                   xaxis = list(title = "Year"),
                   yaxis = list(title = "Gg CO<sub>2</sub> equiv"))
        
        for (item in input$tab3_20chkbox) {
            p <- add_trace(p, x = as.numeric(tab3.20$Period), y = tab3.20[[item]], 
                           name = item, line = list(shape="linear"), evaluate = TRUE)
        }
        print(p)
        
    })
    
    # table 3.20 relative difference plot
    output$tab3_20relplot = renderPlotly({
        datalist = list()
        for (i in 1:10) {
            # new data frame that contains percent change by year
            dat <- data.frame((((tab3.20[i+1,]-tab3.20[i,])/tab3.20[i+1,])*100))
            datalist[[i]] <- dat # add it to the list
        }
        
        relchangedata = do.call(rbind, datalist)
        
        p <- plot_ly()%>%
            
            layout(title = "Relative change of GHG emissions by year",
                   xaxis = list(title = "Year"),
                   yaxis = list(title = "Percent"))
        
        for (item in input$tab3_20chkbox) {
            p <- add_trace(p, x = as.numeric(tab3.20$Period[2:nrow(tab3.20)]), y = relchangedata[[item]],
                           name = item, line = list(shape="linear"), evaluate = TRUE)
        }
        
        print(p)
    })
    
    #table 3.23 line plot
    output$tab3_23plot = renderPlotly({
        p <- plot_ly(x = tab3.23$Period, y = tab3.23$Total_GHG, line = list(shape="linear")) %>%
            
            layout(title = "Total GHG emissions from venting and flaring",
                   xaxis = list(title = "Year"),
                   yaxis = list(title = "Gg CO<sub>2</sub> equiv"))
    })
    
    # table 3.23 relative difference plot
    output$tab3_23relplot = renderPlotly({
        datalist = list()
        for (i in 1:10) {
            # new data frame that contains percent change by year
            dat <- data.frame((((tab3.23[i+1,]-tab3.23[i,])/tab3.23[i+1,])*100))
            datalist[[i]] <- dat # add it to the list
        }
        
        relchangedata = do.call(rbind, datalist)
        
        p <- plot_ly()%>%
            
            add_trace(p, x = as.numeric(tab3.23$Period[2:nrow(tab3.23)]), y = relchangedata$Total_GHG,
                      name = "Total GHG", line = list(shape="linear"), evaluate = TRUE) %>%
            
            layout(title = "Relative change of GHG emissions by year",
                   xaxis = list(title = "Year"),
                   yaxis = list(title = "Percent"))
        
        print(p)
    })
    
    #table 3.24 line plot
    output$tab3_24plot = renderPlotly({
        p <- plot_ly(x = tab3.24$Period, y = tab3.24$Total_GHG, line = list(shape="linear")) %>%
            
            layout(title = "Total GHG emissions from other emissions from energy production",
                   xaxis = list(title = "Year"),
                   yaxis = list(title = "Gg CO<sub>2</sub> equiv"))
    })
    
    
    # table 3.24 relative difference plot
    output$tab3_24relplot = renderPlotly({
        datalist = list()
        for (i in 1:10) {
            # new data frame that contains percent change by year
            dat <- data.frame((((tab3.24[i+1,]-tab3.24[i,])/tab3.24[i+1,])*100))
            datalist[[i]] <- dat # add it to the list
        }
        
        relchangedata = do.call(rbind, datalist)
        
        p <- plot_ly()%>%
            
            add_trace(p, x = as.numeric(tab3.24$Period[2:nrow(tab3.24)]), y = relchangedata$Total_GHG,
                      name = "Total GHG", line = list(shape="linear"), evaluate = TRUE) %>%
            
            layout(title = "Relative change of GHG emissions by year",
                   xaxis = list(title = "Year"),
                   yaxis = list(title = "Percent"))
        
        print(p)
    })
    
    ### DATA TABLE CONTENTS
    ## Creating the GHG data tables in the tabbedbox      
    output$tabAdatatable = renderDataTable({
        tabA
    })
    
    output$tab3_1datatable = renderDataTable({
        tab3.1
    })
    
    output$tab3_4datatable = renderDataTable({
        tab3.4
    })
    
    output$tab3_5datatable = renderDataTable({
        tab3.5
    })
    
    output$tab3_6datatable = renderDataTable({
        tab3.6
    })
    
    output$tab3_7datatable = renderDataTable({
        tab3.7
    })
    
    output$tab3_12datatable = renderDataTable({
        tab3.12
    })
    
    output$tab3_18datatable = renderDataTable({
        tab3.18
    })
    
    output$tab3_20datatable = renderDataTable({
        tab3.20
    })
    
    output$tab3_23datatable = renderDataTable({
        tab3.23
    })
    
    output$tab3_24datatable = renderDataTable({
        tab3.24
    })
    
    # tabbed box for GHG data tables
    output$GHGtabdatatableSelected <- renderText({
        input$GHGtabdatatable
    })
    
    ## Creating the emission factor data tables in the tabbedbox
    output$tab3_8datatable = renderDataTable({
        tab3.8
    })
    
    output$tab3_9datatable = renderDataTable({
        tab3.9
    })
    
    output$tab3_11datatable = renderDataTable({
        tab3.11
    })
    
    output$tab3_16datatable = renderDataTable({
        tab3.16
    })
    
    output$tab3_17datatable = renderDataTable({
        tab3.17
    })
    
    output$tab3_19datatable = renderDataTable({
        tab3.19
    })
    
    # tabbed box for emission factor data tables
    output$EMtabdatatableSelected <- renderText({
        input$EMtabdatatable
    })
    
    
    ## Creating the fuel consumption data tables in the tabbedbox
    output$tab3_10datatable = renderDataTable({
        tab3.10
    })
    
    output$tab3_14datatable = renderDataTable({
        tab3.14
    })
    
    output$tab3_15datatable = renderDataTable({
        tab3.15
    })    
    
    # tabbed box for fuel consumption data tables
    output$FCtabdatatableSelected <- renderText({
        input$FCtabdatatable
    })
    
    ## Creating other data tables
    output$tab3_2datatable = renderDataTable({
        tab3.2
    })
    
    output$tab3_3datatable = renderDataTable({
        tab3.3
    })
    
    output$tab3_13datatable = renderDataTable({
        tab3.13
    })
    
    output$tab3_21datatable = renderDataTable({
        tab3.21
    })
    
    output$tab3_22datatable = renderDataTable({
        tab3.22
    })
    
    # tabbed box for the other data tables
    output$OthertabdatatableSelected <- renderText({
        input$Othertabdatatable
    })
    
    ## DOWNLOADING DATA
    # For GHG data tables
    GHGdatasetInput <- reactive({
        # Fetch the appropriate data object, depending on the value of input$GHGdataset.
        switch(input$GHGdataset,
               "Table A" = tabA,
               "Table 3.1" = tab3.1,
               "Table 3.4" = tab3.4,
               "Table 3.5" = tab3.5,
               "Table 3.6" = tab3.6,
               "Table 3.7" = tab3.7,
               "Table 3.12" = tab3.12,
               "Table 3.18" = tab3.18,
               "Table 3.20" = tab3.20,
               "Table 3.23" = tab3.23,
               "Table 3.24" = tab3.24)
    })
    
    # previews the selected data table and displays it on the right 
    output$GHGpreviewtable <- renderTable({
        GHGdatasetInput()
    })
    
    # allows user to download a selected data table
    output$GHGdownloadData <- downloadHandler(
        # This function returns a string which tells the browser what name to use when saving the file.
        filename = function() {
            paste(input$GHGdataset, input$filetype, sep = ".")
        },
        
        # This function should write data to a file given to it by the argument 'file'.
        content = function(file) {
            sep <- switch(input$filetype, "csv" = ",", "tsv" = "\t")
            
            # Write to a file specified by the 'file' argument
            write.table(GHGdatasetInput(), file, sep = sep,
                        row.names = FALSE)
        }
    )
    
    # For emission factor data tables
    EFdatasetInput <- reactive({
        # Fetch the appropriate data object, depending on the value of input$EFdataset.
        switch(input$EFdataset,
               "Table 3.8" = tab3.8,
               "Table 3.9" = tab3.9,
               "Table 3.11" = tab3.11,
               "Table 3.16" = tab3.16,
               "Table 3.17" = tab3.17,
               "Table 3.19" = tab3.19
        )
    })
    
    # previews the selected data table and displays it on the right 
    output$EFpreviewtable <- renderTable({
        EFdatasetInput()
    })
    
    # allows user to download a selected data table
    output$EfdownloadData <- downloadHandler(
        # This function returns a string which tells the browser what name to use when saving the file.
        filename = function() {
            paste(input$EFdataset, input$filetype, sep = ".")
        },
        
        # This function should write data to a file given to it by the argument 'file'.
        content = function(file) {
            sep <- switch(input$filetype, "csv" = ",", "tsv" = "\t")
            
            # Write to a file specified by the 'file' argument
            write.table(EFdatasetInput(), file, sep = sep,
                        row.names = FALSE)
        }
    )
    
    # attempt at making an option for user to download multiple data tables into zip file
    #output$EFdownloadZipData <- downloadHandler(
    #    # This function returns a string which tells the browser what name to use when saving the file.
    #    filename = function() {
    #        paste("EFmultdatadownload", "zip", sep=".")
    #    },
    #   
    #    content = function(fname) {
    #        fs <- c()
    #        tmpdir <- tempdir()
    #        setwd(tempdir())
    #        for (i in length(input$EFmultdatadownload)) {
    #            path <- paste0(names(input$EFmultdatadownload[i]), ".csv")
    #            write.table(input$EFmultdatadownload[[i]], path, sep = ";", row.names = FALSE)   
    #            fs <- c(fs, path)
    #        }
    #        zip(zipfile=fname, files=fs)
    #        #if(file.exists(paste0(fname, ".zip"))) {file.rename(paste0(fname, ".zip"), fname)}
    #    },
    #    contentType = "application/zip"
    #)
    
    # For fuel consumption data tables
    FCdatasetInput <- reactive({
        # Fetch the appropriate data object, depending on the value of input$EFdataset.
        switch(input$FCdataset,
               "Table 3.10" = tab3.10,
               "Table 3.14" = tab3.14,
               "Table 3.15" = tab3.15
        )
    })
    
    # previews the selected data table and displays it on the right 
    output$FCpreviewtable <- renderTable({
        FCdatasetInput()
    })
    
    # allows user to download a selected data table
    output$FCdownloadData <- downloadHandler(
        # This function returns a string which tells the browser what name to use when saving the file.
        filename = function() {
            paste(input$FCdataset, input$filetype, sep = ".")
        },
        
        # This function should write data to a file given to it by the argument 'file'.
        content = function(file) {
            sep <- switch(input$filetype, "csv" = ",", "tsv" = "\t")
            
            # Write to a file specified by the 'file' argument
            write.table(FCdatasetInput(), file, sep = sep,
                        row.names = FALSE)
        }
    )
    
    # For other data tables
    OtherdatasetInput <- reactive({
        # Fetch the appropriate data object, depending on the value of input$EFdataset.
        switch(input$Otherdataset,
               "Table 3.2" = tab3.2,
               "Table 3.3" = tab3.3,
               "Table 3.13" = tab3.13,
               "Table 3.21" = tab3.21,
               "Table 3.22" = tab3.22
        )
    })
    
    # previews the selected data table and displays it on the right 
    output$Otherpreviewtable <- renderTable({
        OtherdatasetInput()
    })
    
    # allows user to download a selected data table
    output$OtherdownloadData <- downloadHandler(
        # This function returns a string which tells the browser what name to use when saving the file.
        filename = function() {
            paste(input$Otherdataset, input$filetype, sep = ".")
        },
        
        # This function should write data to a file given to it by the argument 'file'.
        content = function(file) {
            sep <- switch(input$filetype, "csv" = ",", "tsv" = "\t")
            
            # Write to a file specified by the 'file' argument
            write.table(OtherdatasetInput(), file, sep = sep,
                        row.names = FALSE)
        }
    )
}