# 9주차 

install.packages("cli")
install.packages("tidymodels")
library(tidymodels)
library(janitor)
infer::gss
# gss 데이터 세트 내용 
gss
options(tibble.width=Inf)
gss
# 표로 표시하기 
table_1 <- gss %>%
  tabyl(finrela, college)
table_1
table_2
table_2 <- table_1 %>%
  adorn_totals(where = c("row", "col")) %>%
  adorn_percentages("row") %>%
  adorn_pct_formatting(digits = 1) %>%
  adorn_ns(position = "front")
# chisq_test() 명목 데이터에 대한 독립성 검증에 사용함 
chisq_test(gss, finrela ~ college)
#chisq_test() 는 동일 변수내에 값들의 분포가 동일한지 
#측정할수 있다-> 6가지 값이 동일한 분포인지 확인
chisq_test(gss,
           response = finrela,
           p = c("far below average" = 1/6,
                 "below average" = 1/6,
                 "average" = 1/6,
                 "above average" = 1/6,
                 "far above average" = 1/6,
                 "DK" = 1/6))
# 주당 40시간을 기준으로 통계적으로 유의미한 차이가 있는지 여부를 조사
t_test(gss, response = hours, mu = 40)
ggplot(data = gss, mapping = aes(x = college, y = hours)) +
  geom_boxplot()
#  t_test( ) 함수
t_test(x = gss, 
       formula = hours ~ college, 
       order = c("degree", "no degree"),
       alternative = "two-sided")
# 연습문제1
mtcars
str(mtcars)
t_test(x=mtcars,
       formula=mpg~am,
       order=c(0,1),
       alternative = ("two-sided"))

install.packages("corrr")
library(corrr)
state.x77
state <- state.x77[, -8]
correlate(state)
# 하 삼각 행렬 표시 
correlate(state) %>%
  shave()
# 상관계수가 큰 값순으로 표시
correlate(state) %>%
  rearrange()
# 특정한 변수만 선택
correlate(state) %>%
  focus(Illiteracy, Murder, Population, mirror = TRUE)
#특정 변수만 제외하려면 ??? 를 사용한다
correlate(state) %>%
  focus(- Murder, -Population, mirror = TRUE)
# filter 함수를 이용, 특정 상관계수 값을 선택 가능 
correlate(state) %>% 
  filter(Murder > .3)
# 시각화 방법: 상관계수를 보기 좋게 표시할 수 있다
correlate(state) %>%
  shave()%>%
  fashion()
x <- correlate(state) %>%
  shave()
fashion(x)
# 상관계수를 그래프로 표시할 수 있다
correlate(state) %>%
  shave() %>%
  rplot()
# 변수 관계를 그래프로 표시할 수 있다. 
correlate(state) %>%
  network_plot(min_cor = .2)
# 사용 데이터 세트: airquality / 데이터조사
str(airquality)
#결측값이 들어있는 행 제거
#??? sum(is.na( )) 함수: 결측값 수 확인
#??? na.omit( ) 함수 사용
sum(is.na(airquality))
air_rev <- na.omit(airquality)
sum(is.na(air_rev)
    correlate(air_rev)
    correlate(air_rev) %>%
      network_plot(min_cor = .2)
# 연습문제 2: airquality 데이터 세트를 이용하시오
# (1) Solar.R 변수를 제외한 airquality 데이터 세트의 상관계수를 찾아라
# (2) 결측값이 제거된 데이터 세트를 이용, 상 삼각 행렬로 표시
# (3). (2)의 상 삼각 행렬을 NA 를 제거한 형태로 표시
airquality
# (1)
airquality_rm<-airquality[,-2]
airquality_rm

correlate(airquality_rm)

airquality_rev<-na.omit(airquality_rm)
correlate(airquality_rev)
# (2)
correlate(airquality_rev)%>%
  shave(FALSE)
#(3)
correlate(airquality_rev)%>%
  shave(FALSE)%>%
  fashion()
