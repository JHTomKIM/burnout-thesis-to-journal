# Robustness for Overtime Participation (Logistics with FE)

library(haven)
library(tidyverse)
library(fixest)

final_data_lsr <- read_dta("final_data_lsr.dta")

logit_4.1 <- feglm(worktime_40 ~ labor_shortage_rate + wage_h + age + 
                     edu_scale + number_household + spouse_exist + nonlaborinc_mon + 
                     foe11 + foe13 + paid_vac + pub_soc + tenured_years 
                   | pid + job + industry + fsize + address, 
                   data = final_data_lsr,
                   family = binomial(link = "logit"))

summary(logit_4.1, vcov = ~pid)