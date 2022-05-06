# Libraries---------------------------------------------------------------------
library(tidyverse)
library(janitor)
library(lubridate)
library(readxl)
library(GGally)
library(psych)

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
# Speed data set
speed_long <- read_excel("speed_long.xlsx")

# Pace data set
pace <- read_excel("pace.xlsx")
pace_long <- read_excel("pace_long.xlsx")

# Possessions data set
poss <- read_excel("poss.xlsx")
poss_long <- read_excel("poss_long.xlsx")

# Change column names of Teams because they contain spaces
colnames(pace) <- c("Season", "Atlanta_Hawks", "Boston_Celtics", "Brooklyn_Nets", 
                    "Charlotte_Hornets", "Chicago_Bulls", "Cleveland_Cavaliers", 
                    "Dallas_Mavericks", "Denver_Nuggets", "Detroit_Pistons", 
                    "Golden_State_Warriors", "Houston_Rockets", "Indiana_Pacers", 
                    "Los_Angeles_Clippers", "Los_Angeles_Lakers", "Memphis_Grizzlies", 
                    "Miami_Heat", "Milwaukee_Bucks", "Minnesota_Timberwolves", 
                    "New_Orleans_Pelicans", "New_York_Knicks", "Oklahoma_City_Thunder", 
                    "Orlando_Magic", "Philadephia_76ers", "Phoenix_Suns", 
                    "Portland_Trail_Blazers", "Sacramento_Kings", 
                    "San_Antonio_Spurs", "Toronto_Raptors", "Utah_Jazz", 
                    "Washington_Wizards", "Season_Average")
colnames(poss) <- c("Season", "Atlanta_Hawks", "Boston_Celtics", "Brooklyn_Nets", 
                    "Charlotte_Hornets", "Chicago_Bulls", "Cleveland_Cavaliers", 
                    "Dallas_Mavericks", "Denver_Nuggets", "Detroit_Pistons", 
                    "Golden_State_Warriors", "Houston_Rockets", "Indiana_Pacers", 
                    "Los_Angeles_Clippers", "Los_Angeles_Lakers", "Memphis_Grizzlies", 
                    "Miami_Heat", "Milwaukee_Bucks", "Minnesota_Timberwolves", 
                    "New_Orleans_Pelicans", "New_York_Knicks", "Oklahoma_City_Thunder", 
                    "Orlando_Magic", "Philadephia_76ers", "Phoenix_Suns", 
                    "Portland_Trail_Blazers", "Sacramento_Kings", 
                    "San_Antonio_Spurs", "Toronto_Raptors", "Utah_Jazz", 
                    "Washington_Wizards", "Season_Average")

# Since there are 5 sheets within each file, save each sheet as its own table
injuries <- read_excel_allsheets("NBA_Injuries_Team.xlsx")
injury2016 <- injuries[[1]]
injury2017 <- injuries[[2]]
injury2018 <- injuries[[3]]
injury2019 <- injuries[[4]]
injury2020 <- injuries[[5]]

# Initial manipulation and joining----------------------------------------------
# Change Season from pace_long to character
pace_long$Season <- as.character(pace_long$Season)
poss_long$Season <- as.character(poss_long$Season)

# Save pace data without season average
pace_long1 <- pace_long %>%
  filter(Team != "Season Average")

# Save possession data without season average
poss_long1 <- poss_long %>%
  filter(Team != "Season Average")

# Sort each of the tables by Team
injury2016 <- injury2016 %>%
  arrange(Team) %>%
  mutate(Season = rep(2016,30))
injury2017 <- injury2017 %>%
  arrange(Team) %>%
  mutate(Season = rep(2017,30))
injury2018 <- injury2018 %>%
  arrange(Team) %>%
  mutate(Season = rep(2018,30))
injury2019 <- injury2019 %>%
  arrange(Team) %>%
  mutate(Season = rep(2019,30))
injury2020 <- injury2020 %>%
  arrange(Team) %>%
  mutate(Season = rep(2020,30))

# Join all the data tables together to make it into long data
injury_long1 <- rbind(injury2016, injury2017, injury2018, injury2019, injury2020)

# Convert Season into integer
injury_long1$Season <- as.integer(injury_long1$Season)
pace_long1$Season <- as.integer(pace_long1$Season)
poss_long1$Season <- as.integer(poss_long1$Season)

# Convert Dist_Feet into numeric
speed_long$Dist_Feet <- as.numeric(speed_long$Dist_Feet)

# Filter out the years for speed
speed_long1 <- speed_long %>%
  filter(Season > 2015) %>%
  group_by(Team, Season) %>%
  summarize(Team_Avg_Speed = mean(Avg_Speed, na.rm = TRUE),
            Team_Avg_Dist_Feet = mean(Dist_Feet, na.rm = TRUE)) %>%
  ungroup()

# Join the pace, possessions, speed, and injury data frames
df <- pace_long1 %>%
  left_join(poss_long1, by = c("Season" = "Season", "Team" = "Team")) %>%
  filter(Season > 2015) %>%
  left_join(injury_long1, by = c("Season" = "Season", "Team" = "Team")) %>%
  rename(Number_of_Injured_Players = Players,
         Number_of_Games_Missed = Games,
         Cash_Earned_While_Injured = Earned_While_Injured) %>%
  left_join(speed_long1, by = c("Season" = "Season", "Team" = "Team"))

# Create data frames for each of the years
df2016 <- df %>%
  filter(Season == 2016)
df2017 <- df %>%
  filter(Season == 2017)
df2018 <- df %>%
  filter(Season == 2018)
df2019 <- df %>%
  filter(Season == 2019)
df2020 <- df %>%
  filter(Season == 2020)

# Remove unused data in environment
rm('injuries', 'injury2016', 'injury2017', 'injury2018', 'injury2019', 'injury2020', 
   'pace', 'pace_long', 'poss', 'poss_long', 'read_excel_allsheets', 'injury_long1', 
   'pace_long1', 'poss_long1', 'speed_long', 'speed_long1')

ggpairs(df, columns = 3:9,
        columnLabels = c('Pace', 'Possessions', 'No. of Injured Players', 
                         'No. Games Missed', 'Earned While Injured', 
                         'Avg Speed', 'Avg Distance (ft)'),
        title = "NBA Seasons 2016-17 to 2020-21",
        lower = list(continuous = "smooth"))

ggpairs(df2016,
        columns = 3:9,
        columnLabels = c('Pace', 'Possessions', 'No. of Injured Players', 
                         'No. Games Missed', 'Earned While Injured', 
                         'Avg Speed', 'Avg Distance (ft)'),
        title = "NBA Season 2016-17",
        lower = list(continuous = "smooth"))

ggpairs(df2017,
        columns = 3:9,
        columnLabels = c('Pace', 'Possessions', 'No. of Injured Players', 
                         'No. Games Missed', 'Earned While Injured', 
                         'Avg Speed', 'Avg Distance (ft)'),
        title = "NBA Season 2017-18",
        lower = list(continuous = "smooth"))

ggpairs(df2018,
        columns = 3:9,
        columnLabels = c('Pace', 'Possessions', 'No. of Injured Players', 
                         'No. Games Missed', 'Earned While Injured', 
                         'Avg Speed', 'Avg Distance (ft)'),
        title = "NBA Season 2018-19",
        lower = list(continuous = "smooth"))

ggpairs(df2019,
        columns = 3:9,
        columnLabels = c('Pace', 'Possessions', 'No. of Injured Players', 
                         'No. Games Missed', 'Earned While Injured', 
                         'Avg Speed', 'Avg Distance (ft)'),
        title = "NBA Season 2019-20",
        lower = list(continuous = "smooth"))

ggpairs(df2020,
        columns = 3:9,
        columnLabels = c('Pace', 'Possessions', 'No. of Injured Players', 
                         'No. Games Missed', 'Earned While Injured', 
                         'Avg Speed', 'Avg Distance (ft)'),
        title = "NBA Season 2020-21",
        lower = list(continuous = "smooth"))

corPlot(df[,3:9],
        scale = FALSE,
        stars = TRUE,
        upper = FALSE,
        labels = c('Pace', 'Possessions', 'No. of Injured Players', 
                   'No. Games Missed', 'Earned While Injured', 
                   'Avg Speed', 'Avg Distance (ft)'),
        main = "NBA Seasons 2016-17 to 2020-21")

corPlot(df2016[,3:9],
        scale = FALSE,
        stars = TRUE,
        upper = FALSE,
        labels = c('Pace', 'Possessions', 'No. of Injured Players', 
                   'No. Games Missed', 'Earned While Injured', 
                   'Avg Speed', 'Avg Distance (ft)'),
        main = "NBA Season 2016-17")

corPlot(df2017[,3:9],
        scale = FALSE,
        stars = TRUE,
        upper = FALSE,
        labels = c('Pace', 'Possessions', 'No. of Injured Players', 
                   'No. Games Missed', 'Earned While Injured', 
                   'Avg Speed', 'Avg Distance (ft)'),
        main = "NBA Season 2017-18")

corPlot(df2018[,3:9],
        scale = FALSE,
        stars = TRUE,
        upper = FALSE,
        labels = c('Pace', 'Possessions', 'No. of Injured Players', 
                   'No. Games Missed', 'Earned While Injured', 
                   'Avg Speed', 'Avg Distance (ft)'),
        main = "NBA Season 2018-19")

corPlot(df2019[,3:9],
        scale = FALSE,
        stars = TRUE,
        upper = FALSE,
        labels = c('Pace', 'Possessions', 'No. of Injured Players', 
                   'No. Games Missed', 'Earned While Injured', 
                   'Avg Speed', 'Avg Distance (ft)'),
        main = "NBA Season 2019-20")

corPlot(df2020[,3:9],
        scale = FALSE,
        stars = TRUE,
        upper = FALSE,
        labels = c('Pace', 'Possessions', 'No. of Injured Players', 
                   'No. Games Missed', 'Earned While Injured', 
                   'Avg Speed', 'Avg Distance (ft)'),
        main = "NBA Season 2020-21")