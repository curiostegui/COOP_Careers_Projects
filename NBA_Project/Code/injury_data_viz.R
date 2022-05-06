# Libraries---------------------------------------------------------------------
library(tidyverse)
library(janitor)
library(lubridate)
library(readxl)
library(scales)

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
injuries <- read_excel_allsheets("NBA_Injuries_Team.xlsx")
injury2016 <- injuries[[1]]
injury2017 <- injuries[[2]]
injury2018 <- injuries[[3]]
injury2019 <- injuries[[4]]
injury2020 <- injuries[[5]]

# Initial manipulation and joining----------------------------------------------
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

# Save injury cash earned data with only season average
injury_long2 <- injury_long1 %>%
  group_by(Season) %>%
  summarize(Team = Team,
            Players = Players,
            Games = Games,
            Earned_While_Injured = Earned_While_Injured,
            Season = Season,
            Season_Average_Earnings = mean(Earned_While_Injured)) %>%
  ungroup()
injury_long3 <- injury_long1 %>%
  group_by(Season) %>%
  summarize(Season_Average_Earnings = mean(Earned_While_Injured)) %>%
  ungroup()

# Create data frame to print season average on each facet
average_cash <- data.frame(
  variable = unique(injury_long3$Season),
  value = injury_long3$Season_Average_Earnings,
  Team = rep(unique(injury_long1$Team), each = 5))
average_cash_teams <- injury_long1 %>%
  group_by(Team) %>%
  arrange(Team) %>%
  mutate(team_avg = mean(Earned_While_Injured, na.rm = TRUE)) %>%
  ungroup()

# Convert Season into integer
injury_long1$Season <- as.integer(injury_long1$Season)
injury_long2$Season <- as.integer(injury_long2$Season)
injury_long3$Season <- as.integer(injury_long3$Season)

ggplot(injury_long1, aes(x = Earned_While_Injured, y = Team, color = Team)) + 
  geom_boxplot() + 
  labs(title = 'NBA Seasons 2016-17 to 2020-21 Cash Earned While Injured By Teams',
       x = "Cash Earned While Injured (US$)",
       y = "Team") + 
  #theme_light() + 
  theme(legend.position = "none") + 
  scale_x_continuous(breaks = c(0, 25000000, 50000000, 75000000),
                     labels = c(dollar(0), dollar(25000000), dollar(50000000), dollar(75000000)))

ggplot(injury_long1, aes(x = Season, y = Earned_While_Injured, group = Team, color = Team)) + 
  geom_line(linetype = "dashed") + 
  geom_line(data = injury_long2, aes(x = Season, y = Season_Average_Earnings), color = "black") + 
  geom_point(data = injury_long2, aes(x = Season, y = Season_Average_Earnings), color = "black") +
  theme_light() + 
  labs(title = "NBA Seasons 2016-17 to 2020-21 Cash Earned While Injured By Teams",
       x = "Season",
       y = "Cash Earned While Injured (US$)") +
  scale_y_continuous(breaks = c(0, 25000000, 50000000, 75000000),
                     labels = c(dollar(0), dollar(25000000), dollar(50000000), dollar(75000000))) + 
  theme(legend.position = "bottom")

ggplot(injury_long1, aes(x = Season, y = Earned_While_Injured, group = Team, color = Team)) + 
  geom_line() + 
  facet_wrap(~Team) + 
  geom_line(data = average_cash, aes(x = variable, y = value), color = "black", linetype = "dashed") + 
  geom_line(data = average_cash_teams, aes(x = Season, y = team_avg), color = "black") + 
  theme_light() + 
  labs(title = "NBA Seasons 2016-17 to 2020-21 Cash Earned While Injured By Teams",
       x = "Season",
       y = "Cash Earned While Injured (US$)") + 
  scale_y_continuous(breaks = c(0, 25000000, 50000000, 75000000),
                     labels = c(dollar(0), dollar(25000000), dollar(50000000), dollar(75000000))) + 
  theme(legend.position = "none")

injury_long4 <- injury_long1 %>%
  group_by(Team) %>%
  summarise(Injured_Players = sum(Players))

avg_injured_players <- mean(injury_long4$Injured_Players)

ggplot(injury_long4, aes(x = Injured_Players, y = Team, color = Team)) +
  geom_bar(stat = "identity", fill = "white") + 
  labs(title = 'NBA Seasons 2016-17 to 2020-21 Number of Injured Players By Teams',
       x = "Number of Injured Players",
       y = "Team") +
  geom_vline(xintercept = avg_injured_players, linetype = "dashed") +
  geom_text(aes(label = Injured_Players), hjust = -0.3, color = "black") + 
  geom_text(aes(label = Team), hjust = 1.1) + 
  theme(legend.position = "none")