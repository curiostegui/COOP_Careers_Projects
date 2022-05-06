# Libraries---------------------------------------------------------------------
library(tidyverse)
library(janitor)
library(lubridate)
library(readxl)
library(writexl)

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
# Since there are 6 sheets within each file, save each sheet as its own table

# Ball Handler------------------------------------------------------------------
ball_handler <- read_excel_allsheets("NBA_Ball_Handler.xlsx")
ball_handler_1 <- ball_handler[[1]]
ball_handler_2 <- ball_handler[[2]]
ball_handler_3 <- ball_handler[[3]]
ball_handler_4 <- ball_handler[[4]]
ball_handler_5 <- ball_handler[[5]]
ball_handler_6 <- ball_handler[[6]]

# Cut---------------------------------------------------------------------------
cut <- read_excel_allsheets("NBA_Cut.xlsx")
cut_1 <- cut[[1]]
cut_2 <- cut[[2]]
cut_3 <- cut[[3]]
cut_4 <- cut[[4]]
cut_5 <- cut[[5]]
cut_6 <- cut[[6]]

# Handoff-----------------------------------------------------------------------
handoff <- read_excel_allsheets("NBA_Handoff.xlsx")
handoff_1 <- handoff[[1]]
handoff_2 <- handoff[[2]]
handoff_3 <- handoff[[3]]
handoff_4 <- handoff[[4]]
handoff_5 <- handoff[[5]]
handoff_6 <- handoff[[6]]

# Isolation---------------------------------------------------------------------
isolation <- read_excel_allsheets("NBA_Isolation.xlsx")
isolation_1 <- isolation[[1]]
isolation_2 <- isolation[[2]]
isolation_3 <- isolation[[3]]
isolation_4 <- isolation[[4]]
isolation_5 <- isolation[[5]]
isolation_6 <- isolation[[6]]

# Off Screen--------------------------------------------------------------------
off_screen <- read_excel_allsheets("NBA_Off_Screen.xlsx")
off_screen_1 <- off_screen[[1]]
off_screen_2 <- off_screen[[2]]
off_screen_3 <- off_screen[[3]]
off_screen_4 <- off_screen[[4]]
off_screen_5 <- off_screen[[5]]
off_screen_6 <- off_screen[[6]]

# Post Up-----------------------------------------------------------------------
post_up <- read_excel_allsheets("NBA_Post_Up.xlsx")
post_up_1 <- post_up[[1]]
post_up_2 <- post_up[[2]]
post_up_3 <- post_up[[3]]
post_up_4 <- post_up[[4]]
post_up_5 <- post_up[[5]]
post_up_6 <- post_up[[6]]

# Putbacks----------------------------------------------------------------------
putbacks <- read_excel_allsheets("NBA_Putbacks.xlsx")
putbacks_1 <- putbacks[[1]]
putbacks_2 <- putbacks[[2]]
putbacks_3 <- putbacks[[3]]
putbacks_4 <- putbacks[[4]]
putbacks_5 <- putbacks[[5]]
putbacks_6 <- putbacks[[6]]

# Roll Man----------------------------------------------------------------------
roll_man <- read_excel_allsheets("NBA_Roll_Man.xlsx")
roll_man_1 <- roll_man[[1]]
roll_man_2 <- roll_man[[2]]
roll_man_3 <- roll_man[[3]]
roll_man_4 <- roll_man[[4]]
roll_man_5 <- roll_man[[5]]
roll_man_6 <- roll_man[[6]]

# Spot Up-----------------------------------------------------------------------
spot_up <- read_excel_allsheets("NBA_Spot_UP.xlsx")
spot_up_1 <- spot_up[[1]]
spot_up_2 <- spot_up[[2]]
spot_up_3 <- spot_up[[3]]
spot_up_4 <- spot_up[[4]]
spot_up_5 <- spot_up[[5]]
spot_up_6 <- spot_up[[6]]

# Transition--------------------------------------------------------------------
transition <- read_excel_allsheets("NBA_Transition.xlsx")
transition_1 <- transition[[1]]
transition_2 <- transition[[2]]
transition_3 <- transition[[3]]
transition_4 <- transition[[4]]
transition_5 <- transition[[5]]
transition_6 <- transition[[6]]

# Initial manipulation and joining----------------------------------------------
# By Playtype-------------------------------------------------------------------

# Ball Handler------------------------------------------------------------------
ball_handler_1 <- ball_handler_1 %>%
  # Keep only the team name, games played, possessions, frequency)
  select(Team, GP, POSS, FREQ) %>%
  mutate(Type = "Ball_Handler",
         Season = "2015-16") %>%
  # Rename column Team to match others in the table
  rename(TEAM = Team)
ball_handler_2 <- ball_handler_2 %>%
  select(Team, GP, POSS, FREQ) %>%
  mutate(Type = "Ball_Handler",
         Season = "2016-17") %>%
  rename(TEAM = Team)
ball_handler_3 <- ball_handler_3 %>%
  select(Team, GP, POSS, FREQ) %>%
  mutate(Type = "Ball_Handler",
         Season = "2017-18") %>%
  rename(TEAM = Team)
ball_handler_4 <- ball_handler_4 %>%
  select(Team, GP, POSS, FREQ) %>%
  mutate(Type = "Ball_Handler",
         Season = "2018-19") %>%
  rename(TEAM = Team)
ball_handler_5 <- ball_handler_5 %>%
  select(Team, GP, POSS, FREQ) %>%
  mutate(Type = "Ball_Handler",
         Season = "2019-20") %>%
  rename(TEAM = Team)
ball_handler_6 <- ball_handler_6 %>%
  select(Team, GP, POSS, FREQ) %>%
  mutate(Type = "Ball_Handler",
         Season = "2020-21") %>%
  rename(TEAM = Team)

# Join it into one table
ball_handler <- ball_handler_1 %>%
  inner_join(ball_handler_2, by = "TEAM") %>%
  inner_join(ball_handler_3, by = "TEAM") %>%
  inner_join(ball_handler_4, by = "TEAM") %>%
  inner_join(ball_handler_5, by = "TEAM") %>%
  inner_join(ball_handler_6, by = "TEAM")

# Cut---------------------------------------------------------------------------
cut_1 <- cut_1 %>%
  select(TEAM, GP, POSS, FREQ) %>%
  mutate(Type = "Cut",
         Season = "2015-16")
cut_2 <- cut_2 %>%
  select(TEAM, GP, POSS, FREQ) %>%
  mutate(Type = "Cut",
         Season = "2016-17")
cut_3 <- cut_3 %>%
  select(TEAM, GP, POSS, FREQ) %>%
  mutate(Type = "Cut",
         Season = "2017-18")
cut_4 <- cut_4 %>%
  select(TEAM, GP, POSS, FREQ) %>%
  mutate(Type = "Cut",
         Season = "2018-19")
cut_5 <- cut_5 %>%
  select(TEAM, GP, POSS, FREQ) %>%
  mutate(Type = "Cut",
         Season = "2019-20")
cut_6 <- cut_6 %>%
  select(TEAM, GP, POSS, FREQ) %>%
  mutate(Type = "Cut",
         Season = "2020-21")

# Join it into one table
cut <- cut_1 %>%
  inner_join(cut_2, by = "TEAM") %>%
  inner_join(cut_3, by = "TEAM") %>%
  inner_join(cut_4, by = "TEAM") %>%
  inner_join(cut_5, by = "TEAM") %>%
  inner_join(cut_6, by = "TEAM")

# Handoff-----------------------------------------------------------------------
handoff_1 <- handoff_1 %>%
  select(TEAM, GP, POSS, FREQ) %>%
  mutate(Type = "Handoff",
         Season = "2015-16")
handoff_2 <- handoff_2 %>%
  select(TEAM, GP, POSS, FREQ) %>%
  mutate(Type = "Handoff",
         Season = "2016-17")
handoff_3 <- handoff_3 %>%
  select(TEAM, GP, POSS, FREQ) %>%
  mutate(Type = "Handoff",
         Season = "2017-18")
handoff_4 <- handoff_4 %>%
  select(TEAM, GP, POSS, FREQ) %>%
  mutate(Type = "Handoff",
         Season = "2018-19")
handoff_5 <- handoff_5 %>%
  select(TEAM, GP, POSS, FREQ) %>%
  mutate(Type = "Handoff",
         Season = "2019-20")
handoff_6 <- handoff_6 %>%
  select(TEAM, GP, POSS, FREQ) %>%
  mutate(Type = "Handoff",
         Season = "2020-21")

# Join it into one table
handoff <- handoff_1 %>%
  inner_join(handoff_2, by = "TEAM") %>%
  inner_join(handoff_3, by = "TEAM") %>%
  inner_join(handoff_4, by = "TEAM") %>%
  inner_join(handoff_5, by = "TEAM") %>%
  inner_join(handoff_6, by = "TEAM")

# Isolation---------------------------------------------------------------------
isolation_1 <- isolation_1 %>%
  select(Team, GP, POSS, FREQ) %>%
  mutate(Type = "Isolation",
         Season = "2015-16") %>%
  # Rename column Team to match others in the table
  rename(TEAM = Team)
isolation_2 <- isolation_2 %>%
  select(Team, GP, POSS, FREQ) %>%
  mutate(Type = "Isolation",
         Season = "2016-17") %>%
  rename(TEAM = Team)
isolation_3 <- isolation_3 %>%
  select(TEAM, GP, POSS, FREQ) %>%
  mutate(Type = "Isolation",
         Season = "2017-18")
isolation_4 <- isolation_4 %>%
  select(TEAM, GP, POSS, FREQ) %>%
  mutate(Type = "Isolation",
         Season = "2018-19")
isolation_5 <- isolation_5 %>%
  select(TEAM, GP, POSS, FREQ) %>%
  mutate(Type = "Isolation",
         Season = "2019-20")
isolation_6 <- isolation_6 %>%
  select(TEAM, GP, POSS, FREQ) %>%
  mutate(Type = "Isolation",
         Season = "2020-21")

# Join it into one table
isolation <- isolation_1 %>%
  inner_join(isolation_2, by = "TEAM") %>%
  inner_join(isolation_3, by = "TEAM") %>%
  inner_join(isolation_4, by = "TEAM") %>%
  inner_join(isolation_5, by = "TEAM") %>%
  inner_join(isolation_6, by = "TEAM")

# Off Screen--------------------------------------------------------------------
off_screen_1 <- off_screen_1 %>%
  select(TEAM, GP, POSS, FREQ) %>%
  mutate(Type = "Off_Screen",
         Season = "2015-16")
off_screen_2 <- off_screen_2 %>%
  select(TEAM, GP, POSS, FREQ) %>%
  mutate(Type = "Off_Screen",
         Season = "2016-17")
off_screen_3 <- off_screen_3 %>%
  select(TEAM, GP, POSS, FREQ) %>%
  mutate(Type = "Off_Screen",
         Season = "2017-18")
off_screen_4 <- off_screen_4 %>%
  select(TEAM, GP, POSS, FREQ) %>%
  mutate(Type = "Off_Screen",
         Season = "2018-19")
off_screen_5 <- off_screen_5 %>%
  select(TEAM, GP, POSS, FREQ) %>%
  mutate(Type = "Off_Screen",
         Season = "2019-20")
off_screen_6 <- off_screen_6 %>%
  select(TEAM, GP, POSS, FREQ) %>%
  mutate(Type = "Off_Screen",
         Season = "2020-21")

# Join it into one table
off_screen <- off_screen_1 %>%
  inner_join(off_screen_2, by = "TEAM") %>%
  inner_join(off_screen_3, by = "TEAM") %>%
  inner_join(off_screen_4, by = "TEAM") %>%
  inner_join(off_screen_5, by = "TEAM") %>%
  inner_join(off_screen_6, by = "TEAM")

# Post Up-----------------------------------------------------------------------
post_up_1 <- post_up_1 %>%
  select(Team, GP, POSS, FREQ) %>%
  mutate(Type = "Post_Up",
         Season = "2015-16") %>%
  # Rename column Team to match others in the table
  rename(TEAM = Team)
post_up_2 <- post_up_2 %>%
  select(Team, GP, POSS, FREQ) %>%
  mutate(Type = "Post_Up",
         Season = "2016-17") %>%
  rename(TEAM = Team)
post_up_3 <- post_up_3 %>%
  select(Team, GP, POSS, FREQ) %>%
  mutate(Type = "Post_Up",
         Season = "2017-18") %>%
  rename(TEAM = Team)
post_up_4 <- post_up_4 %>%
  select(Team, GP, POSS, FREQ) %>%
  mutate(Type = "Post_Up",
         Season = "2018-19") %>%
  rename(TEAM = Team)
post_up_5 <- post_up_5 %>%
  select(Team, GP, POSS, FREQ) %>%
  mutate(Type = "Post_Up",
         Season = "2019-20") %>%
  rename(TEAM = Team)
post_up_6 <- post_up_6 %>%
  select(Team, GP, POSS, FREQ) %>%
  mutate(Type = "Post_Up",
         Season = "2020-21") %>%
  rename(TEAM = Team)

# Join it into one table
post_up <- post_up_1 %>%
  inner_join(post_up_2, by = "TEAM") %>%
  inner_join(post_up_3, by = "TEAM") %>%
  inner_join(post_up_4, by = "TEAM") %>%
  inner_join(post_up_5, by = "TEAM") %>%
  inner_join(post_up_6, by = "TEAM")

# Putbacks----------------------------------------------------------------------
putbacks_1 <- putbacks_1 %>%
  select(TEAM, GP, POSS, FREQ) %>%
  mutate(Type = "Putbacks",
         Season = "2015-16")
putbacks_2 <- putbacks_2 %>%
  select(TEAM, GP, POSS, FREQ) %>%
  mutate(Type = "Putbacks",
         Season = "2016-17")
putbacks_3 <- putbacks_3 %>%
  select(TEAM, GP, POSS, FREQ) %>%
  mutate(Type = "Putbacks",
         Season = "2017-18")
putbacks_4 <- putbacks_4 %>%
  select(TEAM, GP, POSS, FREQ) %>%
  mutate(Type = "Putbacks",
         Season = "2018-19")
putbacks_5 <- putbacks_5 %>%
  select(TEAM, GP, POSS, FREQ) %>%
  mutate(Type = "Putbacks",
         Season = "2019-20")
putbacks_6 <- putbacks_6 %>%
  select(TEAM, GP, POSS, FREQ) %>%
  mutate(Type = "Putbacks",
         Season = "2020-21")

# Join it into one table
putbacks <- putbacks_1 %>%
  inner_join(putbacks_2, by = "TEAM") %>%
  inner_join(putbacks_3, by = "TEAM") %>%
  inner_join(putbacks_4, by = "TEAM") %>%
  inner_join(putbacks_5, by = "TEAM") %>%
  inner_join(putbacks_6, by = "TEAM")

# Roll Man----------------------------------------------------------------------
roll_man_1 <- roll_man_1 %>%
  select(Team, GP, POSS, FREQ) %>%
  mutate(Type = "Roll_Man",
         Season = "2015-16") %>%
  # Rename column Team to match others in the table
  rename(TEAM = Team)
roll_man_2 <- roll_man_2 %>%
  select(Team, GP, POSS, FREQ) %>%
  mutate(Type = "Roll_Man",
         Season = "2016-17") %>%
  rename(TEAM = Team)
roll_man_3 <- roll_man_3 %>%
  select(Team, GP, POSS, FREQ) %>%
  mutate(Type = "Roll_Man",
         Season = "2017-18") %>%
  rename(TEAM = Team)
roll_man_4 <- roll_man_4 %>%
  select(Team, GP, POSS, FREQ) %>%
  mutate(Type = "Roll_Man",
         Season = "2018-19") %>%
  rename(TEAM = Team)
roll_man_5 <- roll_man_5 %>%
  select(Team, GP, POSS, FREQ) %>%
  mutate(Type = "Roll_Man",
         Season = "2019-20") %>%
  rename(TEAM = Team)
roll_man_6 <- roll_man_6 %>%
  select(Team, GP, POSS, FREQ) %>%
  mutate(Type = "Roll_Man",
         Season = "2020-21") %>%
  rename(TEAM = Team)

# Join it into one table
roll_man <- roll_man_1 %>%
  inner_join(roll_man_2, by = "TEAM") %>%
  inner_join(roll_man_3, by = "TEAM") %>%
  inner_join(roll_man_4, by = "TEAM") %>%
  inner_join(roll_man_5, by = "TEAM") %>%
  inner_join(roll_man_6, by = "TEAM")

# Spot Up-----------------------------------------------------------------------
spot_up_1 <- spot_up_1 %>%
  select(TEAM, GP, POSS, FREQ) %>%
  mutate(Type = "Spot_Up",
         Season = "2015-16")
spot_up_2 <- spot_up_2 %>%
  select(TEAM, GP, POSS, FREQ) %>%
  mutate(Type = "Spot_Up",
         Season = "2016-17")
spot_up_3 <- spot_up_3 %>%
  select(TEAM, GP, POSS, FREQ) %>%
  mutate(Type = "Spot_Up",
         Season = "2017-18")
spot_up_4 <- spot_up_4 %>%
  select(TEAM, GP, POSS, FREQ) %>%
  mutate(Type = "Spot_Up",
         Season = "2018-19")
spot_up_5 <- spot_up_5 %>%
  select(TEAM, GP, POSS, FREQ) %>%
  mutate(Type = "Spot_Up",
         Season = "2019-20")
spot_up_6 <- spot_up_6 %>%
  select(TEAM, GP, POSS, FREQ) %>%
  mutate(Type = "Spot_Up",
         Season = "2020-21")

# Join it into one table
spot_up <- spot_up_1 %>%
  inner_join(spot_up_2, by = "TEAM") %>%
  inner_join(spot_up_3, by = "TEAM") %>%
  inner_join(spot_up_4, by = "TEAM") %>%
  inner_join(spot_up_5, by = "TEAM") %>%
  inner_join(spot_up_6, by = "TEAM")

# Transition--------------------------------------------------------------------
transition_1 <- transition_1 %>%
  select(Team, GP, Poss, Freq) %>%
  mutate(Type = "Transition",
         Season = "2015-16") %>%
  # Rename column Team, Poss, and Freq to match others in the table
  rename(TEAM = Team,
         POSS = Poss,
         FREQ = Freq)
transition_2 <- transition_2 %>%
  select(Team, GP, POSS, FREQ) %>%
  mutate(Type = "Transition",
         Season = "2016-17") %>%
  rename(TEAM = Team)
transition_3 <- transition_3 %>%
  select(TEAM, GP, POSS, FREQ) %>%
  mutate(Type = "Transition",
         Season = "2017-18")
transition_4 <- transition_4 %>%
  select(TEAM, GP, POSS, FREQ) %>%
  mutate(Type = "Transition",
         Season = "2018-19")
transition_5 <- transition_5 %>%
  select(TEAM, GP, POSS, FREQ) %>%
  mutate(Type = "Transition",
         Season = "2019-20")
transition_6 <- transition_6 %>%
  select(TEAM, GP, POSS, FREQ) %>%
  mutate(Type = "Transition",
         Season = "2020-21")

# Join it into one table
transition <- transition_1 %>%
  inner_join(transition_2, by = "TEAM") %>%
  inner_join(transition_3, by = "TEAM") %>%
  inner_join(transition_4, by = "TEAM") %>%
  inner_join(transition_5, by = "TEAM") %>%
  inner_join(transition_6, by = "TEAM")

# By Year-----------------------------------------------------------------------
# 2015-16-----------------------------------------------------------------------
season2015_16 <- ball_handler_1 %>%
  # remove the season columns because it is a little redundant
  select(-Season) %>%
  inner_join(cut_1, by = "TEAM") %>%
  select(-Season) %>%
  inner_join(handoff_1, by = "TEAM") %>%
  select(-Season) %>%
  inner_join(isolation_1, by = "TEAM") %>%
  select(-Season) %>%
  inner_join(off_screen_1, by = "TEAM") %>%
  select(-Season) %>%
  inner_join(post_up_1, by = "TEAM") %>%
  select(-Season) %>%
  inner_join(putbacks_1, by = "TEAM") %>%
  select(-Season) %>%
  inner_join(roll_man_1, by = "TEAM") %>%
  select(-Season) %>%
  inner_join(spot_up_1, by = "TEAM") %>%
  select(-Season) %>%
  inner_join(transition_1, by = "TEAM")

# 2016-17-----------------------------------------------------------------------
season2016_17 <- ball_handler_2 %>%
  select(-Season) %>%
  inner_join(cut_2, by = "TEAM") %>%
  select(-Season) %>%
  inner_join(handoff_2, by = "TEAM") %>%
  select(-Season) %>%
  inner_join(isolation_2, by = "TEAM") %>%
  select(-Season) %>%
  inner_join(off_screen_2, by = "TEAM") %>%
  select(-Season) %>%
  inner_join(post_up_2, by = "TEAM") %>%
  select(-Season) %>%
  inner_join(putbacks_2, by = "TEAM") %>%
  select(-Season) %>%
  inner_join(roll_man_2, by = "TEAM") %>%
  select(-Season) %>%
  inner_join(spot_up_2, by = "TEAM") %>%
  select(-Season) %>%
  inner_join(transition_2, by = "TEAM")

# 2017-18-----------------------------------------------------------------------
season2017_18 <- ball_handler_3 %>%
  select(-Season) %>%
  inner_join(cut_3, by = "TEAM") %>%
  select(-Season) %>%
  inner_join(handoff_3, by = "TEAM") %>%
  select(-Season) %>%
  inner_join(isolation_3, by = "TEAM") %>%
  select(-Season) %>%
  inner_join(off_screen_3, by = "TEAM") %>%
  select(-Season) %>%
  inner_join(post_up_3, by = "TEAM") %>%
  select(-Season) %>%
  inner_join(putbacks_3, by = "TEAM") %>%
  select(-Season) %>%
  inner_join(roll_man_3, by = "TEAM") %>%
  select(-Season) %>%
  inner_join(spot_up_3, by = "TEAM") %>%
  select(-Season) %>%
  inner_join(transition_3, by = "TEAM")

# 2018-19-----------------------------------------------------------------------
season2018_19 <- ball_handler_4 %>%
  select(-Season) %>%
  inner_join(cut_4, by = "TEAM") %>%
  select(-Season) %>%
  inner_join(handoff_4, by = "TEAM") %>%
  select(-Season) %>%
  inner_join(isolation_4, by = "TEAM") %>%
  select(-Season) %>%
  inner_join(off_screen_4, by = "TEAM") %>%
  select(-Season) %>%
  inner_join(post_up_4, by = "TEAM") %>%
  select(-Season) %>%
  inner_join(putbacks_4, by = "TEAM") %>%
  select(-Season) %>%
  inner_join(roll_man_4, by = "TEAM") %>%
  select(-Season) %>%
  inner_join(spot_up_4, by = "TEAM") %>%
  select(-Season) %>%
  inner_join(transition_4, by = "TEAM")

# 2019-20-----------------------------------------------------------------------
season2019_20 <- ball_handler_5 %>%
  select(-Season) %>%
  inner_join(cut_5, by = "TEAM") %>%
  select(-Season) %>%
  inner_join(handoff_5, by = "TEAM") %>%
  select(-Season) %>%
  inner_join(isolation_5, by = "TEAM") %>%
  select(-Season) %>%
  inner_join(off_screen_5, by = "TEAM") %>%
  select(-Season) %>%
  inner_join(post_up_5, by = "TEAM") %>%
  select(-Season) %>%
  inner_join(putbacks_5, by = "TEAM") %>%
  select(-Season) %>%
  inner_join(roll_man_5, by = "TEAM") %>%
  select(-Season) %>%
  inner_join(spot_up_5, by = "TEAM") %>%
  select(-Season) %>%
  inner_join(transition_5, by = "TEAM")

# 2020-21-----------------------------------------------------------------------
season2020_21 <- ball_handler_6 %>%
  select(-Season) %>%
  inner_join(cut_6, by = "TEAM") %>%
  select(-Season) %>%
  inner_join(handoff_6, by = "TEAM") %>%
  select(-Season) %>%
  inner_join(isolation_6, by = "TEAM") %>%
  select(-Season) %>%
  inner_join(off_screen_6, by = "TEAM") %>%
  select(-Season) %>%
  inner_join(post_up_6, by = "TEAM") %>%
  select(-Season) %>%
  inner_join(putbacks_6, by = "TEAM") %>%
  select(-Season) %>%
  inner_join(roll_man_6, by = "TEAM") %>%
  select(-Season) %>%
  inner_join(spot_up_6, by = "TEAM") %>%
  select(-Season) %>%
  inner_join(transition_6, by = "TEAM")

# Join all tables into one------------------------------------------------------
nba_playtype_year <- rbind(season2015_16, season2016_17, season2017_18, season2018_19, season2019_20, season2020_21)
