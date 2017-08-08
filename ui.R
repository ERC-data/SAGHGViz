source('setup.R', chdir=T)

###### UI SECTION OF APP WITH GREEN THEME
dashboardPage(
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
        p("Abbreviations:"),
        p("AFOLU: Agriculture, Forestry, and Other Land Use"),
        p("FOLU: Forestry, and Other Land Use"),
        p("GHG: Greenhouse gas"),
        p("Gg: Gigagram"),
        p("IPPU: Industrial Processes and Product Use"),
        p("SA: South Africa"),
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
