library(readr)
library(lubridate)
library(tidyverse)

covid_raw <- read_csv("time_series_covid19_confirmed_US.csv")
View(covid_raw)
dim(covid_raw)

covid <- covid_raw |> 
  select(Province_State, Admin2, '1/22/20':'3/9/23') |> 
  rename(state = Province_State,
         county = Admin2) 
dim(covid)


covid_minnesota <- covid |> 
  filter(state == 'Minnesota')


covid_long <- covid_minnesota |> 
  pivot_longer(
    cols = !(state:county),
    names_to = 'dates',
    values_to = 'c_cases'
    ) |> 
  mutate(dates = mdy(dates))


dim(covid_long)
glimpse(covid_long)


covid_long <- covid_long |> 
  filter(dates <= "2023-02-15")

covid_long <- covid_long |> 
  group_by(county)

covid_long <- covid_long |> 
  arrange(dates)
View(covid_long)  
glimpse(covid_long)

covid_long <- covid_long |> 
  mutate(cases = c_cases - lag(c_cases, default = 0))

View(covid_long)
covid_long[10000,]
covid_long[10001,]


# first check for Hennepin county then make new data fram covid_minnesota 
covid_long |> 
  summarise(sum(cases)) |> 
  filter(county == 'Hennepin')

covid_minnesota <- covid_long |> 
  summarise(cases = sum(cases)) 
dim(covid_minnesota)  

load("mnpops.RData")

dim(mnpops)
View(mnpops)

covid_last <- inner_join(covid_minnesota, mnpops, by = 'county')

covid_last <- covid_last |> 
  mutate(
    per100k = round((cases/pop2020)*100000, 2)
    )
glimpse(covid_last)
View(covid_last)

covid_top10 <- covid_last |> 
  slice_max(per100k, n=10)
View(covid_top10)
