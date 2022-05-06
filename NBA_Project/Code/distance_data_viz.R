# Libraries---------------------------------------------------------------------
library(tidyverse)
library(janitor)
library(lubridate)
library(readxl)

# Get the data------------------------------------------------------------------
# Speed data set
dist_long <- read_excel("speed_long.xlsx")

dist_long1 <- dist_long %>%
  select(Team, Dist_Miles, Season)

dist_team2013 <- dist_long1 %>%
  filter(Season == 2013) %>%
  group_by(Team) %>%
  summarize(Team_Avg_Dist = mean(Dist_Miles, na.rm = TRUE)) %>%
  ungroup() %>%
  mutate(Season = "2013")

dist_team2014 <- dist_long1 %>%
  filter(Season == 2014) %>%
  group_by(Team) %>%
  summarize(Team_Avg_Dist = mean(Dist_Miles, na.rm = TRUE)) %>%
  ungroup() %>%
  mutate(Season = "2014")

dist_team2015 <- dist_long1 %>%
  filter(Season == 2015) %>%
  group_by(Team) %>%
  summarize(Team_Avg_Dist = mean(Dist_Miles, na.rm = TRUE)) %>%
  ungroup() %>%
  mutate(Season = "2015")

dist_team2016 <- dist_long1 %>%
  filter(Season == 2016) %>%
  group_by(Team) %>%
  summarize(Team_Avg_Dist = mean(Dist_Miles, na.rm = TRUE)) %>%
  ungroup() %>%
  mutate(Season = "2016")

dist_team2017 <- dist_long1 %>%
  filter(Season == 2017) %>%
  group_by(Team) %>%
  summarize(Team_Avg_Dist = mean(Dist_Miles, na.rm = TRUE)) %>%
  ungroup() %>%
  mutate(Season = "2017")

dist_team2018 <- dist_long1 %>%
  filter(Season == 2018) %>%
  group_by(Team) %>%
  summarize(Team_Avg_Dist = mean(Dist_Miles, na.rm = TRUE)) %>%
  ungroup() %>%
  mutate(Season = "2018")

dist_team2019 <- dist_long1 %>%
  filter(Season == 2019) %>%
  group_by(Team) %>%
  summarize(Team_Avg_Dist = mean(Dist_Miles, na.rm = TRUE)) %>%
  ungroup() %>%
  mutate(Season = "2019")

dist_team2020 <- dist_long1 %>%
  filter(Season == 2020) %>%
  group_by(Team) %>%
  summarize(Team_Avg_Dist = mean(Dist_Miles, na.rm = TRUE)) %>%
  ungroup() %>%
  mutate(Season = "2020")

dist_long2 <- rbind(dist_team2013, dist_team2014, dist_team2015, dist_team2016, dist_team2017, dist_team2018, dist_team2019, dist_team2020)

dist_long2$Season <- as.integer(dist_long2$Season)

dist_long3 <-dist_long1 %>%
  group_by(Season) %>%
  summarize(Season_Avg_Dist = mean(Dist_Miles, na.rm = TRUE)) %>%
  ungroup() %>%
  mutate(Team = "Season Average")

# Create data frame to print season average on each facet
average_dist <- data.frame(
  variable = unique(dist_long3$Season),
  value = dist_long3$Season_Avg_Dist,
  Team = rep(unique(dist_long2$Team), each = 8))

ggplot(dist_long2, aes(x = Season, y = Team_Avg_Dist, group = Team, color = Team)) + 
  geom_line(linetype = "dashed") + 
  geom_line(data = dist_long3, aes(x = Season, y = Season_Avg_Dist), color = "black") + 
  geom_point(data = dist_long3, aes(x = Season, y = Season_Avg_Dist), color = "black") +
  theme_light() + 
  labs(title = "NBA Seasons 2016-17 to 2020-21 Average Distance By Teams",
       x = "Season",
       y = "Distance (miles)") +
  theme(legend.position = "bottom")