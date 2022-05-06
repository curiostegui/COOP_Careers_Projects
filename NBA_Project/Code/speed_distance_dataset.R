# Libraries---------------------------------------------------------------------
library(tidyverse)
library(janitor)
library(lubridate)
library(readxl)
library(writexl)
library(DataCombine)

# Functions---------------------------------------------------------------------
# Make a function that imports all the sheets from the Excel file
read_excel_allsheets <- function(filename, tibble = FALSE) {
  sheets <- readxl::excel_sheets(filename)
  x <- lapply(sheets, function(X) readxl::read_excel(filename, sheet = X))
  if(!tibble) x <- lapply(x, as.data.frame)
  names(x) <- sheets
  x
}

# Get the data------------------------------------------------------------------
# Since there are 5 sheets within each file, save each sheet as its own table
speed <- read_excel_allsheets("NBA_Player_Speed.xlsx")
speed2013 <- speed[[1]]
speed2014 <- speed[[2]]
speed2015 <- speed[[3]]
speed2016 <- speed[[4]]
speed2017 <- speed[[5]]
speed2018 <- speed[[6]]
speed2019 <- speed[[7]]
speed2020 <- speed[[8]]

# Initial manipulation and joining----------------------------------------------
# Find and replace abbreviated team name to full team name
Replaces <- data.frame(from = c("ATL", "BKN", "BOS", "CHA", "CHI", "CLE", "DAL", 
                                "DEN", "DET", "GSW", "HOU", "IND", "LAC", "LAL", 
                                "MEM", "MIA", "MIL", "MIN", "NOP", "NYK", "OKC", 
                                "ORL", "PHI", "PHX", "POR", "SAC", "SAS", "TOR", 
                                "UTA", "WAS"),
                       to = c("Atlanta Hawks", "Brooklyn Nets", "Boston Celtics", 
                              "Charlotte Hornets", "Chicago Bulls", "Cleveland Cavaliers", 
                              "Dallas Mavericks", "Denver Nuggets", "Detroit Pistons", 
                              "Golden State Warriors", "Houston Rockets", "Indiana Pacers", 
                              "Los Angeles Clippers", "Los Angeles Lakers", "Memphis Grizzlies", 
                              "Miami Heat", "Milwaukee Bucks", "Minnesota Timberwolves", 
                              "New Orleans Pelicans", "New York Knicks", "Oklahoma City Thunder", 
                              "Orlando Magic", "Philadephia 76ers", "Phoenix Suns", 
                              "Portland Trail Blazers", "Sacramento Kings", 
                              "San Antonio Spurs", "Toronto Raptors", "Utah Jazz", 
                              "Washington Wizards"))

speed2013 <- FindReplace(data = speed2013, Var = "Team", replaceData = Replaces, 
                         from = "from", to = "to")
speed2014 <- FindReplace(data = speed2014, Var = "TEAM", replaceData = Replaces, 
                         from = "from", to = "to")
speed2015 <- FindReplace(data = speed2015, Var = "TEAM", replaceData = Replaces, 
                         from = "from", to = "to")
speed2016 <- FindReplace(data = speed2016, Var = "TEAM", replaceData = Replaces, 
                         from = "from", to = "to")
speed2017 <- FindReplace(data = speed2017, Var = "TEAM", replaceData = Replaces, 
                         from = "from", to = "to")
speed2018 <- FindReplace(data = speed2018, Var = "TEAM", replaceData = Replaces, 
                         from = "from", to = "to")
speed2019 <- FindReplace(data = speed2019, Var = "TEAM", replaceData = Replaces, 
                         from = "from", to = "to")
speed2020 <- FindReplace(data = speed2020, Var = "TEAM", replaceData = Replaces, 
                         from = "from", to = "to")

# Add Season column to the data frames
speed2013 <- speed2013 %>%
  rename("Dist_Feet" = "Dist. Feet",
         "Dist_Miles" = "Dist. Miles",
         "Dist_Miles_Off" = "Dist. Miles Off",
         "Dist_Miles_Def" = "Dist. Miles Def",
         "Avg_Speed" = "Avg Speed",
         "Avg_Speed_Off" = "Avg Speed Off",
         "Avg_Speed_Def" = "Avg Speed Def") %>%
  arrange(Team) %>%
  mutate(Season = rep(2013,482))

speed2014 <- speed2014 %>%
  # Rename the columns to be the same as the other data frames
  rename("Player" = "PLAYER",
         "Team" = "TEAM",
         "Min" = "MIN",
         "Dist_Feet" = "DIST. FEET",
         "Dist_Miles" = "DIST. MILES",
         "Dist_Miles_Off" = "DIST. MILES OFF",
         "Dist_Miles_Def" = "DIST. MILES DEF",
         "Avg_Speed" = "AVG SPEED",
         "Avg_Speed_Off" = "AVG SPEED OFF",
         "Avg_Speed_Def" = "AVG SPEED DEF") %>%
  arrange(Team) %>%
  mutate(Season = rep(2014,492))

speed2015 <- speed2015 %>%
  # Rename the columns to be the same as the other data frames
  rename("Player" = "PLAYER",
         "Team" = "TEAM",
         "Min" = "MIN",
         "Dist_Feet" = "DIST. FEET",
         "Dist_Miles" = "DIST. MILES",
         "Dist_Miles_Off" = "DIST. MILES OFF",
         "Dist_Miles_Def" = "DIST. MILES DEF",
         "Avg_Speed" = "AVG SPEED",
         "Avg_Speed_Off" = "AVG SPEED OFF",
         "Avg_Speed_Def" = "AVG SPEED DEF") %>%
  arrange(Team) %>%
  mutate(Season = rep(2015,476))

speed2016 <- speed2016 %>%
  # Rename the columns to be the same as the other data frames
  rename("Player" = "PLAYER",
         "Team" = "TEAM",
         "Min" = "MIN",
         "Dist_Feet" = "DIST. FEET",
         "Dist_Miles" = "DIST. MILES",
         "Dist_Miles_Off" = "DIST. MILES OFF",
         "Dist_Miles_Def" = "DIST. MILES DEF",
         "Avg_Speed" = "AVG SPEED",
         "Avg_Speed_Off" = "AVG SPEED OFF",
         "Avg_Speed_Def" = "AVG SPEED DEF") %>%
  arrange(Team) %>%
  mutate(Season = rep(2016,486))

speed2017 <- speed2017 %>%
  # Rename the columns to be the same as the other data frames
  rename("Player" = "PLAYER",
         "Team" = "TEAM",
         "Min" = "MIN",
         "Dist_Feet" = "DIST. FEET",
         "Dist_Miles" = "DIST. MILES",
         "Dist_Miles_Off" = "DIST. MILES OFF",
         "Dist_Miles_Def" = "DIST. MILES DEF",
         "Avg_Speed" = "AVG SPEED",
         "Avg_Speed_Off" = "AVG SPEED OFF",
         "Avg_Speed_Def" = "AVG SPEED DEF") %>%
  arrange(Team) %>%
  mutate(Season = rep(2017,540))

speed2018 <- speed2018 %>%
  # Rename the columns to be the same as the other data frames
  rename("Player" = "PLAYER",
         "Team" = "TEAM",
         "Min" = "MIN",
         "Dist_Feet" = "DIST. FEET",
         "Dist_Miles" = "DIST. MILES",
         "Dist_Miles_Off" = "DIST. MILES OFF",
         "Dist_Miles_Def" = "DIST. MILES DEF",
         "Avg_Speed" = "AVG SPEED",
         "Avg_Speed_Off" = "AVG SPEED OFF",
         "Avg_Speed_Def" = "AVG SPEED DEF") %>%
  arrange(Team) %>%
  mutate(Season = rep(2018,530))

speed2019 <- speed2019 %>%
  # Rename the columns to be the same as the other data frames
  rename("Player" = "PLAYER",
         "Team" = "TEAM",
         "Min" = "MIN",
         "Dist_Feet" = "DIST. FEET",
         "Dist_Miles" = "DIST. MILES",
         "Dist_Miles_Off" = "DIST. MILES OFF",
         "Dist_Miles_Def" = "DIST. MILES DEF",
         "Avg_Speed" = "AVG SPEED",
         "Avg_Speed_Off" = "AVG SPEED OFF",
         "Avg_Speed_Def" = "AVG SPEED DEF") %>%
  arrange(Team) %>%
  mutate(Season = rep(2019,529))

speed2020 <- speed2020 %>%
  # Rename the columns to be the same as the other data frames
  rename("Player" = "PLAYER",
         "Team" = "TEAM",
         "Min" = "MIN",
         "Dist_Feet" = "DIST. FEET",
         "Dist_Miles" = "DIST. MILES",
         "Dist_Miles_Off" = "DIST. MILES OFF",
         "Dist_Miles_Def" = "DIST. MILES DEF",
         "Avg_Speed" = "AVG SPEED",
         "Avg_Speed_Off" = "AVG SPEED OFF",
         "Avg_Speed_Def" = "AVG SPEED DEF") %>%
  arrange(Team) %>%
  mutate(Season = rep(2020,540))

# Join all the data tables together to make it into long data
speed_long <- rbind(speed2013, speed2014, speed2015, speed2016, speed2017, 
                    speed2018, speed2019, speed2020)

# Save the tables to the computer as Excel files--------------------------------
write_xlsx(speed_long, "speed_long.xlsx")