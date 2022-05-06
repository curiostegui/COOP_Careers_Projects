# Libraries---------------------------------------------------------------------
library(tidyverse)
library(janitor)
library(lubridate)
library(readxl)

# Get the data------------------------------------------------------------------
# Speed data set
speed_long <- read_excel("speed_long.xlsx")

speed_long1 <- speed_long %>%
  select(Team, Avg_Speed, Season)

speed_team2013 <- speed_long1 %>%
  filter(Season == 2013) %>%
  group_by(Team) %>%
  summarize(Team_Avg_Speed = mean(Avg_Speed, na.rm = TRUE)) %>%
  ungroup() %>%
  mutate(Season = "2013")

speed_team2014 <- speed_long1 %>%
  filter(Season == 2014) %>%
  group_by(Team) %>%
  summarize(Team_Avg_Speed = mean(Avg_Speed, na.rm = TRUE)) %>%
  ungroup() %>%
  mutate(Season = "2014")

speed_team2015 <- speed_long1 %>%
  filter(Season == 2015) %>%
  group_by(Team) %>%
  summarize(Team_Avg_Speed = mean(Avg_Speed, na.rm = TRUE)) %>%
  ungroup() %>%
  mutate(Season = "2015")

speed_team2016 <- speed_long1 %>%
  filter(Season == 2016) %>%
  group_by(Team) %>%
  summarize(Team_Avg_Speed = mean(Avg_Speed, na.rm = TRUE)) %>%
  ungroup() %>%
  mutate(Season = "2016")

speed_team2017 <- speed_long1 %>%
  filter(Season == 2017) %>%
  group_by(Team) %>%
  summarize(Team_Avg_Speed = mean(Avg_Speed, na.rm = TRUE)) %>%
  ungroup() %>%
  mutate(Season = "2017")

speed_team2018 <- speed_long1 %>%
  filter(Season == 2018) %>%
  group_by(Team) %>%
  summarize(Team_Avg_Speed = mean(Avg_Speed, na.rm = TRUE)) %>%
  ungroup() %>%
  mutate(Season = "2018")

speed_team2019 <- speed_long1 %>%
  filter(Season == 2019) %>%
  group_by(Team) %>%
  summarize(Team_Avg_Speed = mean(Avg_Speed, na.rm = TRUE)) %>%
  ungroup() %>%
  mutate(Season = "2019")

speed_team2020 <- speed_long1 %>%
  filter(Season == 2020) %>%
  group_by(Team) %>%
  summarize(Team_Avg_Speed = mean(Avg_Speed, na.rm = TRUE)) %>%
  ungroup() %>%
  mutate(Season = "2020")

speed_long2 <- rbind(speed_team2013, speed_team2014, speed_team2015, speed_team2016, speed_team2017, speed_team2018, speed_team2019, speed_team2020)

speed_long2$Season <- as.integer(speed_long2$Season)

speed_long3 <- speed_long1 %>%
  group_by(Season) %>%
  summarize(Season_Avg_Speed = mean(Avg_Speed, na.rm = TRUE)) %>%
  ungroup() %>%
  mutate(Team = "Season Average")

# Create data frame to print season average on each facet
average_speed <- data.frame(
  variable = unique(speed_long3$Season),
  value = speed_long3$Season_Avg_Speed,
  Team = rep(unique(speed_long2$Team), each = 8))

ggplot(speed_long2, aes(x = Season, y = Team_Avg_Speed, group = Team, color = Team)) + 
  geom_line(linetype = "dashed") + 
  geom_line(data = speed_long3, aes(x = Season, y = Season_Avg_Speed), color = "black") + 
  geom_point(data = speed_long3, aes(x = Season, y = Season_Avg_Speed), color = "black") +
  theme_light() + 
  labs(title = "NBA Seasons 2016-17 to 2020-21 Average Speed By Teams",
       x = "Season",
       y = "Speed") +
  theme(legend.position = "bottom")