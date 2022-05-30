# 10주차 회귀분석

library(tidyverse)
library(tidymodels)
install.packages("moderndive") #회귀분석 패키지
library(moderndive)
install.packages("knitr")
library(knitr)
library(corrr)
# ??? corrr::correlate( ) 함수: 변수간의 상관관계 확인
# ??? lm(formula=종속변수 ~ 독립변수, data= )
# ??? summary( )
women
corrr::correlate(women)
women_reg <- lm(formula = weight ~ height, data = women)
summary(women_reg)
# 결과분석
women$weight
fitted(women_reg)
residuals(women_reg)
# 예측 값을 그래프로 그리기
library(ggplot2)
ggplot(data = women_reg, mapping = aes(x = height, y = weight)) +
  geom_point() +
  labs(x = "Height(in inches)", y = "Weight(in pounds)",
       title = "키를 통한 몸무게 예측") +
  geom_smooth(method = "lm", se = FALSE)

cars
corrr::correlate(cars)
cars_reg <- lm(formula = dist ~ speed, data = cars)
summary(cars_reg)
# 결과분석
cars$dist
fitted(cars_reg)
residuals(cars_reg)
# ??? 예측값을 그래프로 그리기
ggplot(data = cars_reg, mapping = aes(x = dist, y = speed)) +
  geom_point() +
  labs(x = "speed", y = "dist",
       title = "자동차 속도와 멈춤 거리") +
  geom_smooth(method = "lm", se = FALSE)

# 실습 3
library(dplyr)
evals_bty <- evals %>%
  select(ID, score, bty_avg, age)
glimpse(evals_bty)

evals_bty %>%
  sample_n(size = 5)

evals_bty %>%
  summarize(mean_bty_avg = mean(bty_avg), mean_score = mean(score),
            median_bty_avg = median(bty_avg), median_score = median(score))

install.packages("skimr")
library(skimr)
evals_bty %>% select(score, bty_avg) %>% skim()

correlate(evals_bty)

ggplot(evals_bty) +
  geom_point(aes(x = bty_avg, y = score)) +
  labs(x = "Beauty Score", y = "Teaching Score",
       title = "강의평가와 외모평가 관계의 산점도")

score_model <- lm(score ~ bty_avg, data = evals_bty)
summary(score_model)
# 회귀 결과 테이블
get_regression_table(score_model)
# 회귀 결과 반응변수 값
get_regression_points(score_model)
#38 결과 분석 
evals$score[1:10]
fitted(score_model)[1:10]
residuals(score_model)[1:10]
# 40 예측값 그래프 그리기 
ggplot(evals_bty, aes(x = bty_avg, y = score)) +
  geom_point() +
  labs(x = "Beauty Score",
       y = "Teaching Score",
       title = "강의평가와 외모평가 관계의 산점도") +
  geom_smooth(method = "lm", se = FALSE)
