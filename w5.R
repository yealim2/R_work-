# 5주차 내용임 

library(tidyverse)
table1
table2
table3
table4a
table4b
table1%>%
  mutate(rate=cases/population*10000)
table1%>%
  count(year, wt=cases)
ggplot(table1,mapping=aes(x=year,y=cases))+
  geom_line(mapping=aes(group=country),color="grey50")+
  geom_point(mapping=aes(color=country))
#연습문제 1 번 , 3가지 코드의 차이점 파악하기 
# 카운트 함수 ,3  번/재는 인구수를 기준으로

#2 분산과 모음 
table4a
table4a%>%
  gather('1999','2000',key="year",value="cases")
table4b
table4b%>%
  gather('1999','2000',key="year",value="population")
# 관찰값이 여러 행에 분산되어 있을때 사용한다. 
spread(table2,key=type, value=count)
stocks <- tibble(
  year = c(2020, 2020, 2021, 2021),
  half = c(1, 2, 1, 2),
  return = c(1.88, 0.59, 0.92, 0.17)
 )
stocks %>%
  spread(stocks,key="year",value="half")
# 연습문제 stocks 
# 스프레드는 "" 이거 표시 없음 

#나누기와 합하기 
table3
table3%>%
  separate(rate,into=c("cases","population"))
table3%>%
  separate(rate,into=c("cases","population"),sep="/")
# 백터 정수를 문자로 나누기 
table3%>%
  separate(
    year,
    into=c("century","year"),
    sep=2
  )
# 합하기 table5의 century 와 year 피처 합치기 
table5%>%
  unite(new,century,year)
# sep 인수 사용하기 
table5%>%
  unite(new,century,year,sep="")
# 결측값 처리 
stocks <- tibble(
  year = c(2020, 2020, 2020, 2020, 2021, 2021, 2021),
  quater = c(1, 2, 3, 4, 2, 3, 4),
  return = c(1.88, 0.59, 0.35, NA, 0.92, 0.17, 2.66)
)
stocks %>%
  spread(year, return)

# gather() 함수 /명백한 결측값 함축적결측값으로 바꾸기
stocks %>%
  spread(key = year, value = return) %>%
  gather('2020':'2021', key = "year",
         value = "return", na.rm = TRUE)
# complete() 함수/ 결측값 찾기 
stocks %>%
  complete(year, quarter)
# fill() 함수 
treatment <- tribble(
  ~ person, ~ treatment, ~ response,
  "홍길동", 1, 7,
  NA, 2, 10,
  NA, 3, 9,
  "김삿갓", 1, 4
)
treatment %>%
  fill(person)

# 실제 연습 결핵 보고서 
who
# 일단 피처 역할을 못하는 변수 다 모으기 
who1 <- who %>%
  gather(
    new_sp_m014:newrel_f65,
    key = "key",
    value = "cases",
    na.rm = TRUE
  )
who1 %>%
  count(key)
# 열 이름 정리하기 
who2<- who1 %>%
  mutate(key = stringr::str_replace(key, "newrel", "new_rel"))
who2
#  key 피처를 new, type, sexage로 나누기
who3<- who2%>%
  separate(key,c("new","type","sexage"),sep="_")
who3
# new 피처 수를 확인한 후, 모든 행에 포함되어 있으면 제거한다
who3 %>%
  count(new)
# 국가의 중복적인 표현인 iso2, iso3 도 제거한다
who4<-who3 %>%
  select(-new,-iso2,-iso3)
who4
#sexage 피처를 sex와 age로 나눈다(왼쪽 첫째 문자가 성별 표시)
who5 <- who4 %>%
  separate(sexage, c("sex", "age"), sep = 1)
who5

# 정리하기  
who %>%
  gather(code, value, new_sp_m014:newrel_f65, na.rm = TRUE) %>%
  mutate(
    code=  stringr::str_replace(code, "newrel", "new_rel")
) %>%
  separate(code, c("new", "type", "sexage")) %>%
  select(-new, -iso2, -iso3) %>%
  separate(sexage, c("sex", "age"), sep = 1)
