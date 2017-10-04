# If you've cloned the applicaiton from github to run it locally, unhash the code below to install and load required packages

#packages <- c('ckanr','plyr','shiny','shinydashboard','ggplot2','plotly')
#for (p in packages){
#    if (p %in% rownames(installed.packages())){
#        next
#    } else {
#        install.packages(p)
#    }
#}

library(shiny)
library(shinydashboard)
library(plyr)
library(ggplot2)
library(plotly)
library(ckanr)

#-----------------------------------------------------------------

# Local variables
path <- getwd()
projhome <- dirname(dirname(path))

# CKAN variables
ckanr_setup(url = 'http://energydata.uct.ac.za') # set the url to the CKAN data portal
ghgdata <- package_search('ghg inventory')$results # get a list of all projects with model outputs
#projects <- sapply(projectlist, '[[', 'organization')['title',]

# Source requried files
#source(paste(path, 'functions.R', sep='/')) # load the functions.R

## Get GHG data tables
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

