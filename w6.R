# 6주차 내용임 
# factor 란 ? 데이터를 미리범주로 구분할떄 사용 
library(tidyverse)
# 아래 경우로 입력 비추천 
x1 <- c("Dec", "Apr", "Jan", "Mar")

#개체에 포함될 level 리스트 생성하기 
month_levels <- c(
  "Jan", "Feb", "Mar", "Apr", "May", "Jun",
  "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
)
# 이후 factor 개체 생성 
y1 <- factor(x1, levels = month_levels) 
y1
# sort 함수 이용 시 월별순서대로 구분된다
sort(y1)
factor(x1)
sort(x1)
# 값의 배열 순서를 처음 입력한 순서로 원할 때 levels = unique( ) 를 사용한다
f1 <- factor(x1, levels = unique(x1))
f1
f2 <- x1 %>% factor() %>% fct_inorder()
f2
#사회조사 데이터 분석 사례 count()사용 
gss_cat
gss_cat %>%
  count(race)
ggplot(data = gss_cat, mapping = aes(race)) +
  geom_bar()
# 만약 값이 없는 레벨도 보여주고 싶을 떄 
ggplot(data = gss_cat, mapping = aes(race)) +
  geom_bar() +
  scale_x_discrete(drop = FALSE)
# count() 사용 2
levels(gss_cat$denom)
gss_cat %>%
  filter(!denom %in% c(
    "No answer", "Other", "Don't know", "Not applicable",
    "No denomination"
  )) %>%
count(relig)
##연습문제 1  suvey에서 가장 많은 사람이 가지고 있는 종교(relig)는? 
#그리고 가장 많은 partyid는? (참고) count( ) 함수: 빈도수 계산, 
#arrange( ) 함수: 행으로 정렬, desc( ) 함수: 내림차순 정렬, head( ) 함수: 첫번째 행만 제시

# factor 순서 변경, 종교 집단 별로 TV 시청 일일 평균 시간 구하기
religions_tv <- gss_cat %>%
  group_by(relig) %>%
  summarize(
    age = mean(age, na.rm = TRUE),
    tvhours = mean(tvhours, na.rm = TRUE),
    n = n()
)
religions_tv
# fct_reorder( ) 함수를 이용하여, relig 레벨의 순서를 바꾼다
ggplot(data = religions_tv, mapping = aes(tvhours, 
                                          fct_reorder(relig, tvhours))) + 
  geom_point()
# aes( ) 함수를 사용하지 않고, mutate( ) 함수를 이용하여 한 단계 더 진행하는 방법
religions_tv %>%
  mutate(relig = fct_reorder(relig, tvhours)) %>%
  ggplot(aes(tvhours, relig)) +
  geom_point()
#  보고된 소득(reported income)을 연령별로 구분하기
rincome_age <- gss_cat %>%
  group_by(rincome) %>%
  summarize(
    age = mean(age, na.rm = TRUE),
    tvhours = mean(tvhours, na.rm = TRUE),
    n = n()
  )
ggplot(data = rincome_age, 
       mapping = aes(age, fct_reorder(rincome, age))) +
  geom_point() #여기서는 fct_reorder( ) 함수가 효과가 없다. 이미 순서가 정해져 있음
#fct_relevel( ) 함수 적용: 특정 값을 첫 줄로 가져오기
ggplot(data = rincome_age,
       mapping = aes(age, fct_relevel(rincome, "Not applicable"))) +
geom_point()
# fct_relevel(f, n)에서 f는 레벨 순서를 바꾸고자 하는 변수이며, n 값이 맨 앞줄에 오도록 한다
# fct_infreq( ) 함수 적용: 빈도 수가 감소하도록 레벨을 배열(내림차순)
# fct_rev( ) 함수: 순서를 역으로 변경
gss_cat %>%
  mutate(marital = marital %>% fct_infreq() %>% fct_rev()) %>%
ggplot(aes(marital)) +
  geom_bar()
# fct_recode( ) 함수를 사용하여 레벨 값을 변경한다
gss_cat %>%
  count(partyid)
gss_cat %>%
  mutate(partyid_rev = fct_recode(partyid, 
                                  "Republican, strong" = "Strong republican",
                                  "Republican, weak" = "Not str republican",
                                  "Independent, near rep" = "Ind,near rep",
                                  "Independent, near dem" = "Ind,near dem",
                                  "Democrat, weak" = "Not str democrat",
                                  "Democrat, strong" = "Strong democrat"
  )) %>%
  count(partyid_rev)
# 레벨값 모아서 변경 가능
gss_cat %>%
  mutate(partyid_rev = fct_recode(partyid, 
                                  "Republican, strong" = "Strong republican",
                                  "Republican, weak" = "Not str republican",
                                  "Independent, near rep" = "Ind,near rep",
                                  "Independent, near dem" = "Ind,near dem",
                                  "Democrat, weak" = "Not str democrat",
                                  "Democrat, strong" = "Strong democrat",
                                  "Other" = "No answer",
                                  "Other" = "Don't know",
                                  "Other" = "Other party"
  )) %>%
  count(partyid_rev)
# fct_lump( ) 함수: 소규모 그룹을 하나로 묶어 줄때
gss_cat %>%
  mutate(relig_rev = fct_lump(relig)) %>%
count(relig_rev)
## 연습문제 2
## rincome 변수를 몇 개의 범주로 묶어주려고 한다. 범주는 ‘이백만이상’, ‘백만이상_이백만미만‘, ‘백만미만’, 
##‘기타‘, ‘적용불가능'으로 구분하려 한다. 적합한 코드를 작성하시오.

install.packages("janitor")
library(janitor)
party <- gss_cat %>%
  mutate(partyid_rev = fct_collapse(partyid,
                                    기타 = c("No answer", "Don't know", "Other party"),
                                    공화당 = c("Strong republican", "Not str republican"),
                                    독립당 = c("Ind,near rep", "Ind,near dem", "Independent"),
                                    민주당 = c("Not str democrat", "Strong democrat")
  ))
whites <- party %>%
  filter(race == "White")
t1 <- whites %>%
  tabyl(rincome)
t1
# adorn_totals( ) 함수 : 셀의 합 계산 
# adorn_pct_formatting( ) 함수 : 퍼센트 표시 

###6 주차 수업내용 
library(tidyverse)
forcats::gss_cat
gss_cat%>%
  count(race)
gss_cat%>%
  count(marital)
ggplot(gss_cat, aes(marital))+
  geom_bar()+
  scale_x_discrete(drop = FALSE)
levels(gss_cat$denom)
gss_cat%>%
  filter(!denom%in% c ("No answer","Other","Don't know",
                       "Not applicable","No denomination"))%>%
  count(relig)
levels(gss_cat$relig)

gss_cat %>%
  count(partyid)
mutate(partyid_rev = fct_collapse(partyid,
                                  기타 = c("No answer", "Don't know", "Other party"),
                                  공화당 = c("Strong republican", "Not str republican"),
                                  독립당 = c("Ind,near rep", "Ind,near dem", "Independent"),
                                  민주당 = c("Not str democrat", "Strong democrat")
))
count(partyid_rev) # 연습문제2,,??
 today()
library(tidyverse)
library(tidyverse)