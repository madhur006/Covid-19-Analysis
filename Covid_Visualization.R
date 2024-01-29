# load the data 
load('HINF5531_HW4_data.RData')
library(tidyverse)

glimpse(covid_cumulative_s)
glimpse(covid_s)
glimpse(covid_us)

# problem 1
ggplot(covid_cumulative_s, aes(x = per100k, y = reorder(state, per100k) )) +
  geom_point() +
  labs(title = "Cumulative Cases per 100,000 People by February 24, 2023",
       x = "Cases per 100,000 People by February 24, 2023,",
       y = "State")

# problem2
ggplot(covid_us, aes(x = date, y = cases)) +
  geom_bar(stat = 'identity', fill = "steelblue") +
  labs(x = "Date", y = "Daily New Cases of COVID-19 in US",
       title = "Daily New Cases of COVID-19 in the United States")



# problem 3 
glimpse(covid_s)

covid_mn <- covid_s |> 
  filter(state == 'Minnesota') 

ggplot(covid_mn, aes(x = date, y = cases)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  geom_line(aes(x = date, y = smoothed_cases), color = "red") +
  labs(x = "Date", y = "Number of New Cases in Minnesota",
       title = "Daily New Cases of COVID-19 in Minnesota")



# problem 4 
# save it as 17 by 11

ggplot(covid_s, aes(x = date, y = cases)) +
  geom_bar(stat = 'identity', fill = 'steelblue', alpha = 0.8)+
  geom_line(aes(x = date, y = smoothed_cases), color = 'red', alpha = 0.4)+
  facet_wrap(~state, scales = 'free_y')+
  labs(x = "Date", y = "Daily cases")
  
  




           