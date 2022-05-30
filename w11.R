library(tidyverse)
library(moderndive)
library(skimr)
install.packages("ISLR")
library(ISLR)
evals_age <- evals %>%
  select(ID, score, age, gender)
glimpse(evals_age)
evals_age %>% sample_n(size = 5)
evals_age %>%
  select(score, age, gender) %>%
  skim()
evals_age %>%
  get_correlation(formula = score ~ age)
ggplot(evals_age, aes(x = age, y = score, color = 
                        gender)) +
  geom_point() +
  labs(x = "나이", y = "강의 평가점수", color = "성별") +
  geom_smooth(method = "lm", se = FALSE)
score_inter <- lm(score ~ age * gender, data = evals_age)
get_regression_table(score_inter)

ISLR::Credit
credit_reg <- Credit %>%
  as_tibble() %>%
  select(ID, debt = Balance, credit_limit = Limit,
         income = Income, credit_rating = Rating, age = Age)
glimpse(credit_reg)

debt_model <- lm(debt ~ credit_limit + income, 
                data = credit_reg)
get_regression_table(debt_model)
