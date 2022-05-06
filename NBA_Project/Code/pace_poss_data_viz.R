# Libraries---------------------------------------------------------------------
library(tidyverse)
library(janitor)
library(lubridate)
library(readxl)
library(CGPfunctions)
library(directlabels)

# Get the data------------------------------------------------------------------
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

# Change Season from pace_long to character
pace_long$Season <- as.character(pace_long$Season)
poss_long$Season <- as.character(poss_long$Season)

# Initial manipulation
pace_long_change <- pace_long %>%
  filter(Season == 1996 | Season == 2020)

poss_long_change <- poss_long %>%
  filter(Season == 1996 | Season == 2020)

# Save pace data without season average
pace_long1 <- pace_long %>%
  filter(Team != "Season Average")

# Save pace data with only season average
pace_long2 <- pace_long %>%
  filter(Team == "Season Average")

# Create data frame to print season average on each facet
average_Pace <- data.frame(
  variable = unique(pace_long2$Season),
  value = pace_long2$Pace,
  Team = rep(unique(pace_long1$Team), each = 25))
average_pace_teams <- pace_long1 %>%
  group_by(Team) %>%
  arrange(Team) %>%
  mutate(team_avg = mean(Pace, na.rm = TRUE)) %>%
  ungroup()

# Save possession data without season average
poss_long1 <- poss_long %>%
  filter(Team != "Season Average")

# Save possession data with only season average
poss_long2 <- poss_long %>%
  filter(Team == "Season Average")

# Create data frame to print season average on each facet
average_Poss <- data.frame(
  variable = unique(poss_long2$Season),
  value = poss_long2$Possessions,
  Team = rep(unique(poss_long1$Team), each = 25))
average_poss_teams <- poss_long1 %>%
  group_by(Team) %>%
  arrange(Team) %>%
  mutate(team_avg = mean(Possessions, na.rm = TRUE)) %>%
  ungroup()

ggplot(pace_long1, aes(x = Season, y = Pace, group = Team, color = Team)) + 
  geom_line(linetype = "dashed") + 
  geom_line(data = pace_long2, color = "black") + 
  geom_point(data = pace_long2, color = "black") + 
  theme_light() + 
  labs(title = "NBA Seasons 1996-97 to 2020-21 Pace By Teams",
       x = "Season",
       y = "Pace") +
  theme(legend.position = "bottom")

ggplot(pace_long1, aes(x = Season, y = Pace, group = Team, color = Team)) + 
  geom_line() + 
  #geom_line(data = pace_long2, color = "black") + 
  #geom_point(data = pace_long2, color = "black") + 
  facet_wrap(~Team) + 
  geom_line(data = average_Pace, aes(x = variable, y = value), color = "black", linetype = "dashed") + 
  geom_line(data = average_pace_teams, aes(x = Season, y = team_avg), color = "black") + 
  theme_light() + 
  labs(title = "NBA Seasons 1996-97 to 2020-21 Pace By Teams",
       x = "Season",
       y = "Pace") + 
  theme(legend.position = "none")

newggslopegraph(dataframe = pace_long_change,
                Times = Season,
                Measurement = Pace,
                Grouping = Team,
                Title = "NBA Team Pace Evolution",
                SubTitle = "Seasons 1996-97 to 2020-21",
                Caption = NULL)

ggplot(poss_long1, aes(x = Season, y = Possessions, group = Team, color = Team)) + 
  geom_line(linetype = "dashed") + 
  geom_line(data = poss_long2, color = "black") + 
  geom_point(data = poss_long2, color = "black") + 
  theme_light() + 
  labs(title = "NBA Seasons 1996-97 to 2020-21 Possessions By Teams",
       x = "Season",
       y = "Possessions") +
  theme(legend.position = "bottom")

ggplot(poss_long1, aes(x = Season, y = Possessions, group = Team, color = Team)) + 
  geom_line() + 
  facet_wrap(~Team) + 
  geom_line(data = average_Poss, aes(x = variable, y = value), color = "black", linetype = "dashed") + 
  geom_line(data = average_poss_teams, aes(x = Season, y = team_avg), color = "black") + 
  theme_light() + 
  labs(title = "NBA Seasons 1996-97 to 2020-21 Possessions By Teams",
       x = "Season",
       y = "Possessions") + 
  theme(legend.position = "none")

newggslopegraph(dataframe = poss_long_change,
                Times = Season,
                Measurement = Possessions,
                Grouping = Team,
                Title = "NBA Team Possessions Evolution",
                SubTitle = "Seasons 1996-97 to 2020-21",
                Caption = NULL)

poss_long_2018 <- poss_long %>%
  filter(Season == 1996 | Season == 2018)

newggslopegraph(dataframe = poss_long_2018,
                Times = Season,
                Measurement = Possessions,
                Grouping = Team,
                Title = "NBA Team Possessions Evolution",
                SubTitle = "Seasons 1996-97 to 2020-21",
                Caption = NULL)