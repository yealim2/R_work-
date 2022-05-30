library(tidyverse)
install.packages("tidyquant")
library(tidyquant)
library(timetk)
install.packages('sweep')
library(sweep)
library(forecast)
bike_sales
bike_sales_mo <- bike_sales %>%
  mutate(month = month(order.date, label = TRUE),
         year = year(order.date)) %>%
  group_by(year, month) %>%
  summarise(total = sum(quantity))
bike_sales_mo  
month('2021-05-08' )
year('2021-05-08')
bike_sales_mo %>%
  ggplot(aes(x = month, y = total, group = year)) +
  geom_area(aes(fill = year), position = "stack") +
  labs(x = "Month", y = "Sales", title = "판매량")

# 그룹별(자전거 종류별) 연월별 판매량 예측
mo_qty_by_cat2 <- bike_sales %>%
  mutate(order.month = as_date(as.yearmon(order.date))) %>%
  group_by(category.secondary, order.month) %>%
  summarise(total = sum(quantity))
mo_qty_by_cat2  
#category.secondary 피처 값(자전거 종류)의 종류 조사
mo_qty_by_cat2 %>%
  group_by(category.secondary) %>%
  summarise() 
# 판매량 예측 단계 :1단계 ts객체로 변환
mo_qty_by_cat2_ts <- mo_qty_by_cat2_nest %>%
  mutate(data.ts = map(.x = data,
                       .f=tk_ts,
                       select= -order.month,
                       start = 2011,
                       freq = 12))
mo_qty_by_cat2_ts
# 2단계 : time series(시계열) 모델링
mo_qty_by_cat2_fit <- mo_qty_by_cat2_ts %>%
  mutate(fit.ets = map(data.ts, ets))
mo_qty_by_cat2_fit
# sw_tidy( ) 함수: 시계열 모델을 요약 tibbles로 변환
mo_qty_by_cat2_fit %>%
  mutate(tidy = map(fit.ets, sw_tidy)) %>%
  unnest(tidy) %>%
  spread(key = category.secondary, value = estimate)
# sw_glance( ) 함수: 모델을 보다 정확하게 볼 수 있다
mo_qty_by_cat2_fit %>%
  mutate(glance = map(fit.ets, sw_glance)) %>%
  unnest(glance)
# sw_augment( ) 함수: 예측값, 잔차(오차) 보여준다
augment_fit_ets <- mo_qty_by_cat2_fit %>%
  mutate(augment = map(fit.ets, sw_augment,
                       timetk_idx = TRUE,
                       rename_index = "date")) %>%
unnest(augment)
#그래프 그리기 
augment_fit_ets
augment_fit_ets %>%
  ggplot(aes(x = date, y = .resid, group = category.secondary)) +
  geom_hline(yintercept = 0, color = "grey40") +
  geom_line(color = palette_light()[[2]]) +
  geom_smooth(method = "loess") +
  labs(title = "종류별 자전거 판매양",
       subtitle = "ETS Model Residuals", x = "") +
  theme_tq() +
  facet_wrap(~ category.secondary, scale = "free_y", ncol = 3)
