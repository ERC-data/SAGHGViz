# This creates a web app with Shiny. It's a dashboard with graphs created from the SA GHG inventory excel sheet, 
# including downloadable data tables.

library(shiny)
library(shinydashboard)
library(plyr)
library(ggplot2)
library(plotly)
library(ckanr)

### FETCHING DATA FROM DATA PORTAL (separated by type of data table)
ckanr_setup(url = 'http://energydata.uct.ac.za')

## GHG data tables
resA <- resource_show(id = "c3a6dea5-e4c1-43cc-82ce-4c2d531ae19b", as = "table")
tabA <- fetch(resA$url)

res3.1 <- resource_show(id = "9a01d868-cdc2-4c19-a049-06851058a01e", as = "table")
tab3.1 <- fetch(res3.1$url)

res3.4 <- resource_show(id = "181eb49f-210f-44a5-8be3-22968965deca", as = "table")
tab3.4 <- fetch(res3.4$url)

res3.5 <- resource_show(id = "1b680898-df65-440a-aaad-4e96f6b3a73a", as = "table")
tab3.5 <- fetch(res3.5$url)

res3.6 <- resource_show(id = "f1dcf941-bb22-4591-a3d6-b007d6f1b5ed", as = "table")
tab3.6 <- fetch(res3.6$url)

res3.7 <- resource_show(id = "32b6efae-2a42-482e-8fa7-da92f918b75d", as = "table")
tab3.7 <- fetch(res3.7$url)

res3.12 <- resource_show(id = "46955a50-0e20-4356-adde-8e942a2ee131", as = "table")
tab3.12 <- fetch(res3.12$url)

res3.18 <- resource_show(id = "e5d23aca-f341-42d6-9312-cc1ced454125", as = "table")
tab3.18 <- fetch(res3.18$url)

res3.20 <- resource_show(id = "6b8dcb2a-26d2-4ccf-966c-d390e94b574e", as = "table")
tab3.20 <- fetch(res3.20$url)

res3.23 <- resource_show(id = "38d6d876-6a13-48fa-863c-de4d48c7d7f9", as = "table")
tab3.23 <- fetch(res3.23$url)

res3.24 <- resource_show(id = "fdc5a1a2-ea90-4a72-b791-173f2f6faa2d", as = "table")
tab3.24 <- fetch(res3.24$url)

## Emission factor data tables
res3.8 <- resource_show(id = "b31dd27c-9b76-4f5f-a56d-6680655f7370", as = "table")
tab3.8 <- fetch(res3.8$url)

res3.9 <- resource_show(id = "1ef46431-18a5-4eeb-a882-56c370662b11", as = "table")
tab3.9 <- fetch(res3.9$url)

res3.11 <- resource_show(id = "2ec49e63-7ad2-4f74-9b2d-8be5d9efd5e3", as = "table")
tab3.11 <- fetch(res3.11$url)

res3.16 <- resource_show(id = "78b8bca7-3966-420f-981a-ee51a92a2f6c", as = "table")
tab3.16 <- fetch(res3.16$url)

res3.17 <- resource_show(id = "83ad715e-302f-4727-be32-7148add6787e", as = "table")
tab3.17 <- fetch(res3.17$url)

res3.19 <- resource_show(id = "a7a107d5-82b5-42bc-98a4-4cd1bec9e298", as = "table")
tab3.19 <- fetch(res3.19$url)

## Fuel consumption data tables
res3.10 <- resource_show(id = "4c115051-158f-4525-8957-c0d7af5e9c65", as = "table")
tab3.10 <- fetch(res3.10$url)

res3.14 <- resource_show(id = "7cb190a7-a63e-4059-93d8-a5c975f528ee", as = "table")
tab3.14 <- fetch(res3.14$url)

res3.15 <- resource_show(id = "6c738c0e-b676-4bc0-a2cc-6349f5a61a27", as = "table")
tab3.15 <- fetch(res3.15$url)

## Other data tables
res3.2 <- resource_show(id = "1fa37ce8-02aa-4850-94ae-5930ffd24821", as = "table")
tab3.2 <- fetch(res3.2$url)

res3.3 <- resource_show(id = "fba0710c-afd5-4c6d-933d-498ef6f184ff", as = "table")
tab3.3 <- fetch(res3.3$url)

res3.13 <- resource_show(id = "c56b568b-fc35-4433-9c42-c4894b259b6c", as = "table")
tab3.13 <- fetch(res3.13$url)

res3.21 <- resource_show(id = "5a7b871c-b151-4670-b649-059396dac95a", as = "table")
tab3.21 <- fetch(res3.21$url)

res3.22 <- resource_show(id = "9c3a8177-c0ed-470b-b717-66adf4a2ddfd", as = "table")
tab3.22 <- fetch(res3.22$url)

###### UI SECTION OF APP WITH GREEN THEME
ui <- dashboardPage(
    skin = "green",
    
    dashboardHeader(title = "South Africa's Energy Sector and GHG Emissions",
                    titleWidth = 460
                    ),
    
### SIDEBAR MENU TO NAVIGATE PLOTS, DATA TABLES, AND SECTION ABOUT THE APP
    dashboardSidebar(
        sidebarMenu(
            menuItem("Introduction", tabName = "Introduction", icon = icon("info-circle")),
            menuItem("GHG Plots", tabName = "GHG", icon = icon("line-chart"),
                     menuSubItem("Table A Overview", tabName = "tabAsubitem"),
                     menuSubItem("Table 3.1 Sectors", tabName = "tab3_1subitem"),
                     menuSubItem("Table 3.4 Public Electricity", tabName = "tab3_4subitem"),
                     menuSubItem("Table 3.5 Auto Electricity", tabName = "tab3_5subitem"),
                     menuSubItem("Table 3.6 Petroleum Refining", tabName = "tab3_6subitem"),
                     menuSubItem("Table 3.7 Solid Fuels & Other", tabName = "tab3_7subitem"),
                     menuSubItem("Table 3.12 Intl. Aviation", tabName = "tab3_12subitem"),
                     menuSubItem("Table 3.18 Nonspecified", tabName = "tab3_18subitem"),
                     menuSubItem("Table 3.20 Fugitive Emissions", tabName = "tab3_20subitem"),
                     menuSubItem("Table 3.23 Venting and Flaring", tabName = "tab3_23subitem"),
                     menuSubItem("Table 3.24 Other Emissions", tabName = "tab3_24subitem")),
            menuItem("GHG Data Tables", tabName = "GHGdatatables", icon = icon("table")),
            menuItem("Emission Factors Data Tables", tabName = "EFdatatables", icon = icon("table")),
            menuItem("Fuel Consumption Data Tables", tabName = "FCdatatables", icon = icon("table")),
            menuItem("Other Data Tables", tabName = "Otherdatatables", icon = icon("table")),
            menuItem("About", tabName = "about", icon = icon("question"))
        )
    ),

### CONTENTS FOR BODY OF APP
    dashboardBody(
        tags$head(
            # Green Africa continent browser icon  
            tags$link(rel="shortcut icon", href="https://maxcdn.icons8.com/Share/icon/Maps//africa1600.png"),
            
            # maintain header color with longer title
            tags$style(
                HTML('.skin-blue .main-header .logo {
                        background-color: #3c8dbc;
                    }
                    .skin-blue .main-header .logo:hover {
                        background-color: #3c8dbc;
                    }')
                )
            ),
        
        ## content in each tab in the sidebar       
        tabItems(
            # introduction tab
            tabItem(tabName = "Introduction",
                    h2("Welcome!"),
                    p("Thank you for using South Africa's Energy Sector and Greenhouse Gas data visualization!
                       This data viz provides plots of data tables from Greenhouse Gas Inventory for South Africa report. 
                       More details in the",
                        strong("About"),
                        "section."),
                    
                    h3("How to Navigate this App"),
                    p("Under the", 
                      strong("GHG Plots"),
                      "section, there are plots of GHG emission data of fuel combustion activities and fugitive emissions from 
                      the energy sector (Section 3 of the GHG Inventory report) in addition to an overview of GHG emissions from 
                      all sectors in South Africa (Table A)."),
                    p("Each plot contains two views: "),
                    p(" * Line graph: plots absolute values from the data table plotted"),
                    p(" * Relative plot: plots percent change from one year to another"),
                    
                    h3("How to Navigate the Plots"),
                    p("* Users can select the check boxes located on the right to plot multiple traces."),
                    p("* Click on the trace in the legend to deselect a trace."),
                    p("* Double click on a trace in the legend to isolate it."),
                    p("* Hover over points to see value."),
                    p("* Hover over the top right corner of the plot to view more functions."),
                    
                    h3("How to Navigate the Data Tables"),
                    p("All data used to create the plots is under",
                      strong("GHG Data Tables"),
                      "tab. Other data tables for the energy sector is found in the ",
                      strong("Emission Factors Data Table, Fuel Consumption Data Table, "),
                      "and",
                      strong("Other Data Table"),
                      "section."),
                    p("Data tables can be viewed in their respective tabs and downloaded in the last tab under each of these sections.")
            ),
            
            # tab content- plots
            tabItem(tabName = "tabAsubitem",
                    h2("SA GHG Inventory 2010 Overview"),
                    
                    # code for plots in the tabbed box
                    fluidRow(
                        column(8, 
                            tabBox(
                                width = 12,
                                id = "tabsetA", height = "500px", 
                                title = h6("*Default plot is of the energy sector for line graph"),
                                tabPanel("Line graph",
                                         plotlyOutput("tabAplot")),
                                tabPanel("Stacked graph", 
                                         plotOutput("tabAstackedplot")),
                                tabPanel("Pie Chart",
                                         plotlyOutput("tabApie")),
                                tabPanel("Relative plot",
                                         plotlyOutput("tabArelplot"))
                            )
                        ), 
                        
                        column(4,
                               fluidRow(    
                                   column(12, offset = 0.5, 
                                          h5("*Default plot is the Energy Sector."),
                                          h5("Select a check box to view a plot and 
                                             compare plots. Click on the legend to
                                             deselect a trace.")
                                          )
                                ), 
                               
                               # code to create the check box
                               fluidRow(
                                    box(
                                        width = 10,
                                        checkboxGroupInput("tabAchkbox", label = h3("Sector"), 
                                            choices = list("Energy" = "Energy", 
                                                           "IPPU" = "IPPU", 
                                                           "AFOLU excluding FOLU" = "AFOLU_excl_FOLU",
                                                           "AFOLU including FOLU" = "AFOLU_incl_FOLU", 
                                                           "Waste" = "Waste", 
                                                           "Total excluding FOLU" = "Total_excl_FOLU", 
                                                           "Total including FOLU" = "Total_incl_FOLU")
                                        )
                                    )
                               )
                        ) 
                    )
            ), 
            
            # tab content- Table 3.1
            tabItem(tabName = "tab3_1subitem", 
                    h2("Contribution of the Various Sources to the Total Energy GHG Emissions"),
                    fluidRow(
                        column(8, 
                            tabBox(
                                   width = 12,
                                   id = "tabset3_1", height = "400px", 
                                   tabPanel("Line graph",
                                            plotlyOutput("tab3_1plot")),
                                   tabPanel("Relative plot",
                                            plotlyOutput("tab3_1relplot"))
                            )
                        ),
                        
                        column(4,
                               fluidRow(
                                   column(12, offset = 0.5,
                                          h5("*Default plot is the electricity generation."),
                                          h5("Select a check box to view a plot and 
                                             compare plots. Click on the legend to
                                             deselect a trace.")
                                   )
                               ),
                               
                               # code to create the check box
                               fluidRow(
                                   box(
                                       width = 11,
                                       checkboxGroupInput("tab3_1chkbox", label = h3("Sources"), 
                                                          choices = list("Electricity generation" = "EG", 
                                                                         "Petroleum Refining" = "PR", 
                                                                         "Manufacture of Solid Fuels and Other Energy Industries" = "MSF",
                                                                         "Manufacturing Industries and Construction" = "MIC", 
                                                                         "Domestic Aviation" = "DA",
                                                                         "Road Transportation" = "RT", "Railway" = "RW", 
                                                                         "Commercial/ Institutional" = "CI",
                                                                         "Residential" = "Res", 
                                                                         "Agriculture/forestry/fishing/fish farms" = "Ag",
                                                                         "Non Specified" = "NS", 
                                                                         "Fugitive emissions from Coal Mining" = "FECM",
                                                                         "Fugitive emissions from Natural Gas – Venting" = "FENG",
                                                                         "Fugitive emissions - Other Emissions from energy production" = "FEO"))
                                   )
                               )
                               
                        )
                    )
            ), 
            
            #tab content for table 3.4
            tabItem(tabName = "tab3_4subitem", 
                    h2("Summary of GHG Emissions from the Public Electricity Producer"),
                    fluidRow(
                        column(8, 
                               tabBox(
                                   width = 12,
                                   id = "tabset3_4", height = "500px", 
                                   tabPanel("Line graph",
                                            plotlyOutput("tab3_4plot")),
                                   tabPanel("Relative plot",
                                            plotlyOutput("tab3_4relplot"))
                               )
                        ),
                        
                        column(4,
                               fluidRow(
                                   column(12, offset = 0.5, 
                                          h5("*Default plot is of consumption and uses the axis on the left."),
                                          h5("The boxes selected on the right creates lines that uses the axis on 
                                             the right."),
                                          h5("Click a check box to view a plot and compare plots. Click 
                                             on the legend to deselect a trace.")
                                          )
                                ),
                               
                               # code to create the check box 
                               fluidRow(
                                   box(
                                       width = 11,
                                       checkboxGroupInput("tab3_4chkbox", label = h3("GHG"),
                                                          choices = list("CO2 (Gg)" = "CO2", 
                                                                         "CH4 (Gg CO2 Equiv.)" = "CH4", 
                                                                         "N2O (Gg CO2 Equiv.)" = "N2O", 
                                                                         "Total GHG (Gg CO2 Equiv.)" = "Total_GHG")
                                                          )
                                   )
                               )
                        )
                    )
            ), 
            
            #tab content for table 3.5
            tabItem(tabName = "tab3_5subitem", 
                    h2("Summary of GHG Emissions from the Auto Electricity Producer"),
                    fluidRow(
                        column(8, 
                               tabBox(
                                   width = 12,
                                   id = "tabset3_5", height = "500px",
                                   tabPanel("Line graph",
                                        plotlyOutput("tab3_5plot")),
                                   tabPanel("Relative plot",
                                        plotlyOutput("tab3_5relplot"))
                               )
                        ),
                        
                        column(4,
                               fluidRow(
                                   column(12, offset = 0.5, 
                                          h5("*Blue line is consumption and uses the axis on the left."), 
                                          h5("The boxes selected on the right creates lines that uses 
                                            the axis on the right."),
                                          h5("Click a check box to view a plot 
                                            and compare plots. Click on the legend to
                                            deselect a trace.")
                                   )
                               ),
                               
                               # code to create the check box  
                               fluidRow(
                                   box(
                                       width = 11,
                                       checkboxGroupInput("tab3_5chkbox", label = h3("GHG"),
                                                          choices = list("CO2 (Gg)" = "CO2", 
                                                                         "CH4 (Gg CO2 Equiv.)" = "CH4", 
                                                                         "N2O (Gg CO2 Equiv.)" = "N2O", 
                                                                         "Total GHG (Gg CO2 Equiv.)" = "Total_GHG")
                                                          )
                                   )
                               )
                        )
                    )
            ), 
            
            #tab content for table 3.6
            tabItem(tabName = "tab3_6subitem", 
                    h2("Summary of GHG Emissions from the Petroleum Refining"),
                    fluidRow(
                        column(8, 
                               tabBox(
                                   width = 12,
                                   id = "tabset3_6", height = "500px",
                                   tabPanel("Line graph",
                                            plotlyOutput("tab3_6plot")),
                                   tabPanel("Relative plot",
                                            plotlyOutput("tab3_6relplot"))
                               )
                        ),
                            
                        column(4,
                               fluidRow(
                                   column(12, offset = 0.5, 
                                          h5("*Default plot is of consumption."),
                                          h5("Click a check box to view a plot and compare plots. Click on the legend to
                                    deselect a trace.")
                                   )
                               ),
                               
                               # code to create the check box
                               fluidRow(
                                   box(
                                       width = 11,
                                       checkboxGroupInput("tab3_6chkbox", label = h3("GHG"),
                                                          choices = list("CO2 (Gg)" = "CO2", 
                                                                         "CH4 (Gg CO2 Equiv.)" = "CH4", 
                                                                         "N2O (Gg CO2 Equiv.)" = "N2O", 
                                                                         "Total GHG (Gg CO2 Equiv.)" = "Total_GHG"))
                                   )
                               )
                        )
                    )
            ),
            
            #tab content for table 3.7
            tabItem(tabName = "tab3_7subitem", 
                    h2("Summary of GHG Emissions from the Manufacture of Solid Fuels and 
                       Other Energy Industries"),
                    fluidRow(
                        column(8, 
                               tabBox(
                                   width = 12,
                                   id = "tabset3_7", height = "500px",
                                   tabPanel("Line graph",
                                            plotlyOutput("tab3_7plot")),
                                   tabPanel("Relative plot",
                                            plotlyOutput("tab3_7relplot"))
                               )
                        ),
                        
                            
                        column(4,
                               fluidRow(
                                   column(12, offset = 0.5, 
                                          h5("*Click a check box to view a plot and compare plots. 
                                             Click on the legend to deselect a trace.")
                                          )
                                   ),
                               
                               # code to create the check box
                               fluidRow(
                                   box(
                                       width = 11,
                                       checkboxGroupInput("tab3_7chkbox", label = h3("GHG"),
                                                          choices = list("CO2 (Gg)" = "CO2", 
                                                                         "CH4 (Gg CO2 Equiv.)" = "CH4", 
                                                                         "N2O (Gg CO2 Equiv.)" = "N2O", 
                                                                         "Total GHG (Gg CO2 Equiv.)" = "Total_GHG"))
                                   )
                               )
                        )
                    )
            ),
            
            #tab content for table 3.12
            tabItem(tabName = "tab3_12subitem", 
                    h2("Summary of GHG Emissions from International Aviation"),
                    fluidRow(
                        column(8, 
                               tabBox(
                                   width = 12,
                                   id = "tabset3_12", height = "500px",
                                   tabPanel("Line graph",
                                            plotlyOutput("tab3_12plot")),
                                   tabPanel("Relative plot",
                                            plotlyOutput("tab3_12relplot"))
                               )
                        ),
                        
                        column(4,
                               fluidRow(
                                   column(12, offset = 0.5, 
                                          h5("*Click a check box to view a plot and compare plots. 
                                            Click on the legend to deselect a trace.")
                                   )
                               ),
                               
                               # code to create the check box
                               fluidRow(
                                   box(
                                       width = 11,
                                       checkboxGroupInput("tab3_12chkbox", label = h3("GHG"),
                                                          choices = list("CO2 (Gg)" = "CO2", 
                                                                         "CH4 (Gg CO2 Equiv.)" = "CH4", 
                                                                         "N2O (Gg CO2 Equiv.)" = "N2O", 
                                                                         "Total GHG (Gg CO2 Equiv.)" = "Total_GHG"))
                                   )
                               )
                        )
                    )
            ),
            
            #tab content for table 3.18
            tabItem(tabName = "tab3_18subitem", 
                    h2("Summary of GHG Emissions from the Non-Specified Sector"),
                    fluidRow(
                        column(8, 
                               tabBox(
                                   width = 12,
                                   id = "tabset3_18", height = "500px",
                                   tabPanel("Line graph",
                                            plotlyOutput("tab3_18plot")),
                                   tabPanel("Relative plot",
                                            plotlyOutput("tab3_18relplot"))
                               )
                        ),
                        
                        # code to create the check box    
                        column(4,
                               fluidRow(
                                   column(12, offset = 0.5, 
                                          h5("*Default plot is of consumption."),
                                          h5("Click on the legend to deselect a trace. 
                                             Click a check box to view a plot and compare plots.")
                                          )
                                   ),
                               fluidRow(
                                   box(
                                       width = 11,
                                       checkboxGroupInput("tab3_18chkbox", label = h3("GHG"),
                                                          choices = list("CO2 (Gg)" = "CO2", 
                                                                         "CH4 (Gg CO2 Equiv.)" = "CH4", 
                                                                         "N2O (Gg CO2 Equiv.)" = "N2O", 
                                                                         "Total GHG (Gg CO2 Equiv.)" = "Total_GHG"))
                                   )
                               )
                        )
                    )
            ),
            
            #tab content for table 3.20
            tabItem(tabName = "tab3_20subitem", 
                    h2("Fugitive Emissions from Coal Mining for the Period 2000 to 2010"),
                    fluidRow(
                        column(8, 
                               tabBox(
                                   width = 12,
                                   id = "tabset3_20", height = "500px",
                                   tabPanel("Line graph",
                                            plotlyOutput("tab3_20plot")),
                                   tabPanel("Relative plot",
                                            plotlyOutput("tab3_20relplot"))
                               )
                        ),
                        
                        column(4,
                               fluidRow(
                                   column(12, offset = 0.5, 
                                          h5("*Click a check box to view a plot and compare plots. 
                                    Click on the legend to deselect a trace.")
                                   )
                               ),
                               
                               # code to create the check box
                               fluidRow(
                                   box(
                                       width = 11,
                                       checkboxGroupInput("tab3_20chkbox", label = h3("GHG"),
                                                          choices = list("CO2 (Gg)" = "CO2", 
                                                                         "CH4 (Gg CO2 Equiv.)" = "CH4", 
                                                                         "Total GHG (Gg CO2 Equiv.)" = "Total_GHG"))
                                   )
                               )
                        )
                    )
            ),
            
            #tab content for table 3.23
            tabItem(tabName = "tab3_23subitem", 
                    h2("Total GHG Emissions from Venting and Flaring for the Period 2000 – 2010"),
                    fluidRow(
                        column(8, 
                               tabBox(
                                   width = 12,
                                   id = "tabset3_23", height = "500px",
                                   tabPanel("Line graph",
                                            plotlyOutput("tab3_23plot")),
                                   tabPanel("Relative plot",
                                            plotlyOutput("tab3_23relplot"))
                               )
                        )
                    )
            ),
            
            #tab content for table 3.24
            tabItem(tabName = "tab3_24subitem", 
                    h2("Total GHG Emissions from the Category Other Emissions 
                       from Energy Production (1B3), 2000 – 2010"),
                    fluidRow(
                        column(8, 
                               tabBox(
                                   width = 12,
                                   id = "tabset3_24", height = "500px",
                                   tabPanel("Line graph",
                                            plotlyOutput("tab3_24plot")),
                                   tabPanel("Relative plot",
                                            plotlyOutput("tab3_24relplot"))
                               )
                        )
                    )
            ),
            
            # tab content- GHG data tables used and has the option of letting the user download the data tables
            tabItem(tabName = "GHGdatatables",
                    h2("Data tables from SA GHG Inventory 2010"),
                    h5("Click on the last tab to download data"),
                    br(),
                    tabBox(
                        id = "GHGtabdatatable", width = "800px",
                        tabPanel("Table A", 
                                 h4("Table A: Trends and levels in GHG emissions for South Africa between 2000 and 2010"),
                                 dataTableOutput("tabAdatatable")),
                        tabPanel("Table 3.1", 
                                 h4("Table 3.1:  Sector 1 Energy: Contribution of the various sources to the total energy GHG emissions"),
                                 dataTableOutput("tab3_1datatable")),
                        tabPanel("Table 3.4", 
                                 h4("Table 3.4: Summary of GHG emissions from the public electricity producer"),
                                 dataTableOutput("tab3_4datatable")),
                        tabPanel("Table 3.5", 
                                 h4("Table 3.5: Summary of GHG emissions from the auto electricity producer"),
                                 dataTableOutput("tab3_5datatable")),
                        tabPanel("Table 3.6", 
                                 h4("Table 3.6: Summary of consumption and GHG emissions in the petroleum refining category (1A1b)"),
                                 dataTableOutput("tab3_6datatable")),
                        tabPanel("Table 3.7", 
                                 h4("Table 3.7: Contribution of CO2, CH4 and N2O to the total emissions from the manufacture of solid fuels and other energy industries category (1A1c)"),
                                 dataTableOutput("tab3_7datatable")),
                        tabPanel("Table 3.12", 
                                 h4("Table 12: Summary of GHG emissions from International aviation (International bunkers), 2000 – 2010"),
                                 dataTableOutput("tab3_12datatable")),
                        tabPanel("Table 3.18", 
                                 h4("Table 18: Trend in consumption and GHG emissions from the non-Specified sector, 2000 – 2010"),
                                 dataTableOutput("tab3_18datatable")),
                        tabPanel("Table 3.20", 
                                 h4("Table 20: Fugitive emissions from coal mining for the period 2000 to 2010"),
                                 dataTableOutput("tab3_20datatable")),
                        tabPanel("Table 3.23", 
                                 h4("Table 23: Total GHG emissions from venting and flaring for the period 2000 – 2010"),
                                 dataTableOutput("tab3_23datatable")),
                        tabPanel("Table 3.24", 
                                 h4("Table 24: Total GHG emissions from the category other emissions from energy production (1B3), 2000 – 2010"),
                                 dataTableOutput("tab3_24datatable")),
                        tabPanel("Download a Dataset", 
                                column(2,
                                    box(width ="500px",
                                        selectInput("GHGdataset", "Choose a dataset:", 
                                            choices = c("Table A", "Table 3.1", 
                                                        "Table 3.4", "Table 3.5", 
                                                        "Table 3.6","Table 3.7",
                                                        "Table 3.12", "Table 3.18", 
                                                        "Table 3.20", "Table 3.23", 
                                                        "Table 3.24")),
                                        radioButtons("filetype", "File type:",
                                              choices = c("csv", "tsv")),
                                        downloadButton('GHGdownloadData', 'Download'))),
                                column(10, 
                                    box(width = "700px", tableOutput("GHGpreviewtable")))
                        )
                    )
            ),
            
            # tab content- Emission factors data tables used and has the option of letting the user download the data tables
            tabItem(tabName = "EFdatatables",
                    h2("Emission Factor Data tables from SA GHG Inventory 2010"),
                    h5("Click on the last tab to download data"),
                    br(),
                    tabBox(
                        id = "EFtabdatatable", width = "800px",
                        tabPanel("Table 3.8", 
                                 h4("Table 3.8: Emission factors for GHG emissions (Source: 2006 IPCC Guidelines, Vol 2 and Zhou et al., 2009)"),
                                 dataTableOutput("tab3_8datatable")),
                        tabPanel("Table 3.9", 
                                 h4("Table 3.9: Emission factor for the calculation of GHG emissions from petroleum refining (Source: 2006 IPCC Guidelines)"),
                                 dataTableOutput("tab3_9datatable")),
                        tabPanel("Table 3.11", 
                                 h4("Table 3.11: Emission factors used in the manufacturing industries and construction category (Source: 2006 IPCC Guidelines)"),
                                 dataTableOutput("tab3_11datatable")),
                        tabPanel("Table 3.16", 
                                 h4("Table 3.16: Emission factors used for the transport sector emission calculations (Source: 2006 IPCC Guidelines)"),
                                 dataTableOutput("tab3_16datatable")),
                        tabPanel("Table 3.17", 
                                 h4("Table 3.17: Emission factors used for all other sectors (Source: 2006 IPCC Guidelines)"),
                                 dataTableOutput("tab3_17datatable")),
                        tabPanel("Table 3.19", 
                                 h4("Table 3.19: Emission factors for calculating emissions from the Non-Specified sector (Source: 2006 IPCC Guidelines)"),
                                 dataTableOutput("tab3_19datatable")),
                        tabPanel("Download a Dataset", 
                                 column(2,
                                        box(width ="500px",
                                            selectInput("EFdataset", "Choose a dataset:", 
                                                        choices = c("Table 3.8", "Table 3.9", 
                                                                    "Table 3.11", "Table 3.16", 
                                                                    "Table 3.17","Table 3.19")),
                                            radioButtons("filetype", "File type:",
                                                         choices = c("csv", "tsv")),
                                            downloadButton('EFdownloadData', 'Download')#,
                                         
                                         # attempt at making an option for user to download multiple data tables into zip file (download button)    
                                        #    checkboxGroupInput("EFmultdatadownload", 
                                        #                       "Or download multiple in a zip file:",
                                        #                       choices = list("Table 3.8" = tab3.8, 
                                        #                                      "Table 3.9" = tab3.9, 
                                        #                                       "Table 3.11" = tab3.11, 
                                        #                                       "Table 3.16" = tab3.16, 
                                        #                                       "Table 3.17" = tab3.17,
                                        #                                       "Table 3.19" = tab3.19)
                                        #    ),
                                        #    downloadButton('EFdownloadZipData', 'Download')
                                        )
                                ),
                                column(10, 
                                        box(width = "700px", tableOutput("EFpreviewtable")))
                        )
                    )
            ),
            
            # tab content- Fuel consumption data tables used and has the option of letting the user download the data tables
            tabItem(tabName = "FCdatatables",
                    h2("Fuel Consumption Data tables from SA GHG Inventory 2010"),
                    h5("Click on the last tab to download data"),
                    br(),
                    tabBox(
                        id = "FCtabdatatable", width = "800px",
                        tabPanel("Table 3.10", 
                                 h4("Table 3.10: Fuel consumption (TJ) in the manufacturing industries and construction category, 2000 – 2010"),
                                 dataTableOutput("tab3_10datatable")),
                        tabPanel("Table 3.14", 
                                 h4("Table 3.14: Fuel consumption (TJ) in the transport sector, 2000 – 2010"),
                                 dataTableOutput("tab3_14datatable")),
                        tabPanel("Table 3.15", 
                                 h4("Table 3.15: Fuel consumption (TJ) in the international aviation category, 2000 – 2010"),
                                 dataTableOutput("tab3_15datatable")),
                        tabPanel("Download a Dataset", 
                                 column(2,
                                        box(width ="500px",
                                            selectInput("FCdataset", "Choose a dataset:", 
                                                        choices = c("Table 3.10", 
                                                                    "Table 3.14", 
                                                                    "Table 3.15")),
                                            radioButtons("filetype", "File type:",
                                                         choices = c("csv", "tsv")),
                                            downloadButton('FCdownloadData', 'Download'))),
                                 column(10, 
                                        box(width = "700px", tableOutput("FCpreviewtable")))
                        )
                    )
            ),
            
            # tab content- Other data tables used and has the option of letting the user download the data tables
            tabItem(tabName = "Otherdatatables",
                    h2("Other Data tables from SA GHG Inventory 2010"),
                    h5("Click on the last tab to download data"),
                    br(),
                    tabBox(
                        id = "Othertabdatatable", width = "800px",
                        tabPanel("Table 3.2", 
                                 h4("Table 3.2: Summary of electricity users in South Africa (Source: DoE, 2009a)"),
                                 dataTableOutput("tab3_2datatable")),
                        tabPanel("Table 3.3", 
                                 h4("Table 3.3: Net electricity generation capacity and associated consumption (Source: ESKOM, 2005, 2007, 2011)"),
                                 dataTableOutput("tab3_3datatable")),
                        tabPanel("Table 3.13", 
                                 h4("Table 3.13: Net Calorific Values for the transport Sector (Source: DoE 2009a)"),
                                 dataTableOutput("tab3_13datatable")),
                        tabPanel("Table 3.21", 
                                 h4("Table 3.21: Coal mining activity data for the period 2000 to 2010"),
                                 dataTableOutput("tab3_21datatable")),
                        tabPanel("Table 3.22", 
                                 h4("Table 3.22: Comparison of country-specific and IPCC 2006 default emission factors for coal mining"),
                                 dataTableOutput("tab3_22datatable")),
                        tabPanel("Download a Dataset", 
                                 column(2,
                                        box(width ="500px",
                                            selectInput("Otherdataset", "Choose a dataset:", 
                                                        choices = c("Table 3.2", "Table 3.3", 
                                                                    "Table 3.13", "Table 3.21", 
                                                                    "Table 3.22")),
                                            radioButtons("filetype", "File type:",
                                                         choices = c("csv", "tsv")),
                                            downloadButton('OtherdownloadData', 'Download'))),
                                 column(10, 
                                        box(width = "700px", tableOutput("Otherpreviewtable")))
                        )
                    )
            ),
            
            # tab content- About this app
            tabItem(tabName = "about",
                    h2("About this app"),
                    p("This is a data visualization for the  Greenhouse Gas Inventory South Africa report,
                       focusing on greenhouse gas emissions of the energy sector. Other data tables including
                       emission factors, fuel consumption, and others can be downloaded. View the report", 
                       a("here.", 
                         href = "https://www.environment.gov.za/sites/default/files/docs/greenhousegas_invetorysouthafrica.pdf",
                         target = "_blank")
                    ),
                    br(),
                    p("Units for greenhouse gas (GHG) emissions: Gg CO2 equivalent"),
                    p("Units for emission factors: kg/TJ"),
                    p("Units for fuel consumption: TJ"),
                    br(),
                    p("Titles of the data tables from the report:"),
                    p("Table A: Trends and levels in GHG emissions for South Africa between 2000 and 2010"),
                    p("Table 3.1: Contribution of the various sources to the total energy GHG emissions"),
                    p("Table 3.2: Summary of electricity users in South Africa (Source: DoE, 2009a)"),
                    p("Table 3.3: Net electricity generation capacity and associated consumption (Source: ESKOM, 2005, 2007, 2011)"),
                    p("Table 3.4: Summary of GHG emissions from the public electricity producer"),
                    p("Table 3.5: Summary of GHG emissions from the auto electricity producer"),
                    p("Table 3.6: Summary of consumption and GHG emissions in the petroleum refining category (1A1b)"),
                    p("Table 3.7: Contribution of CO2, CH4 and N2O to the total emissions from the manufacture of solid fuels and other energy industries category (1A1c)"),
                    p("Table 3.8: Emission factors for GHG emissions (Source: 2006 IPCC Guidelines, Vol 2 and Zhou et al., 2009)"),
                    p("Table 3.9: Emission factor for the calculation of GHG emissions from petroleum refining (Source: 2006 IPCC Guidelines)"),
                    p("Table 3.10: Fuel consumption (TJ) in the manufacturing industries and construction category, 2000 – 2010"),
                    p("Table 3.11: Emission factors used in the manufacturing industries and construction category (Source: 2006 IPCC Guidelines)"),
                    p("Table 3.12: Summary of GHG emissions from International aviation (International bunkers), 2000 – 2010"),
                    p("Table 3.13: Net Calorific Values for the transport Sector (Source: DoE 2009a)"),
                    p("Table 3.14: Fuel consumption (TJ) in the transport sector, 2000 – 2010"),
                    p("Table 3.15: Fuel consumption (TJ) in the international aviation category, 2000 – 2010"),
                    p("Table 3.16: Emission factors used for the transport sector emission calculations (Source: 2006 IPCC Guidelines)"),
                    p("Table 3.17: Emission factors used for all other sectors (Source: 2006 IPCC Guidelines)"),
                    p("Table 3.18: Trend in consumption and GHG emissions from the non-Specified sector, 2000 – 2010"),
                    p("Table 3.19: Emission factors for calculating emissions from the Non-Specified sector (Source: 2006 IPCC Guidelines)"),
                    p("Table 3.20: Fugitive emissions from coal mining for the period 2000 to 2010"),
                    p("Table 3.21: Coal mining activity data for the period 2000 to 2010"),
                    p("Table 3.22: Comparison of country-specific and IPCC 2006 default emission factors for coal mining"),
                    p("Table 3.23: Total GHG emissions from venting and flaring for the period 2000 – 2010"),
                    p("Table 3.24: Total GHG emissions from the category other emissions from energy production (1B3), 2000 – 2010"),
                    br(),
                    br(),
                    p("Created by Lisa Au; August 3, 2017")
            )
        )
    )
)


###### SERVER SECTION OF THE APP
server <- function(input, output) {
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

shinyApp(ui, server)
