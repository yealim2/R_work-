# 6주차 연습문제 모음 

#연습문제 1  suvey에서 가장 많은 사람이 가지고 있는 종교(relig)는? 
#그리고 가장 많은 partyid는? (참고) count( ) 함수: 빈도수 계산, 
#arrange( ) 함수: 행으로 정렬, desc( ) 함수: 내림차순 정렬, head( ) 함수: 첫번째 행만 제시
library(tidyverse)
gss_cat
gss_cat %>%
  count(relig) %>%
  arrange(desc(n)) %>%
  head()  

gss_cat %>%
  count(partyid)%>%
  arrange(desc(n)) %>% 
  head()  
gss_cat %>%
  mutate(rincome_rev= fct_collapse(rincome,
                                   "이백 만이상" = c("$25000 or more", "$20000-24999"),
                                   "백만이상_이백만미만" = c("$15000-19999", "$10000-14999"),
                                   "백만미만"= c("$8000 to 9999", "$7000 to 7999", "$6000 to 6999",
                                             "$5000 to 5999", "$4000 to 4999", "$3000 to 3999", "$1000 to 2999","Lt $1000"),
                                   "기타" = c ("No answer", "Don't know", "Refused"),
                                   "적용불가능"= c ("Not applicable")
  ))%>%
  mutate(rincome_rev= fct_collapse(rincome,
                                   "이백 만이상" = c("$25000 or more", "$20000-24999"),
                                   "백만이상_이백만미만" = c("$15000-19999", "$10000-14999"),
                                   "백만미만"= c("$8000 to 9999", "$7000 to 7999", "$6000 to 6999",
                                             "$5000 to 5999", "$4000 to 4999", "$3000 to 3999", "$1000 to 2999","Lt $1000"),
                                   "기타" = c ("No answer", "Don't know", "Refused"),
                                   "적용불가능"= c ("Not applicable")
  ))%>%
  count(rincome_rev) 

gss_cat %>%
  mutate(rincome_rev= fct_collapse(rincome,
                                   "이백 만이상" = c("$25000 or more", "$20000-24999"),
                                   "백만이상_이백만미만" = c("$15000-19999", "$10000-14999"),
                                   "백만미만"= c("$8000 to 9999", "$7000 to 7999", "$6000 to 6999",
                                             "$5000 to 5999", "$4000 to 4999", "$3000 to 3999", "$1000 to 2999","Lt $1000"),
                                   "기타" = c ("No answer", "Don't know", "Refused"),
                                   "적용불가능"= c ("Not applicable")
  ))%>%
count(rincome_rev)
