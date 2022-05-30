# 4주차 내용임 

library(tidyverse)
class(iris)
as_tibble(iris)
tibble(
  x= 1:5,
  y= 1,
  z= x^2+y
 )
iris
iris_tb <-as_tibble(iris)
iris_tb
nycflights13::flights %>%
  print(n=10, width = Inf)
# width=inf 모든 열 다보여주는거임 
# read_file() 하나의 문자열로 반환 
# read_line() 줄 단위의 배열로 반환 
options(tibble.print_min = m) 
# 특정 피쳐 번수값 추출 
#임의의 tibbles 객체 만들기(runif( )함수: 균일분포, 
#rnorm( )함수: 정규분포)
df<-tibble(
  x = runif(5),
  y = rnorm(5)
)
df$x
df[["x"]]
df[[1]]
df %>%
  .[["x"]]
# 연습문제 
test<- tibble(
  a = 1:10,
  b = a*2+rnorm(5)
)
#1)변수 a추출하기 
test $a
ggplot(data=test)+ 
  geom_point(mapping=aes(x=a,y=b))
#mutate () 써서 c 구하기 

getwd()
setwd("c:/workspace")
# 파일을 tibble 형식으로 불러오기 
heights <- read_csv("heights.csv")

# 인종별(race) 소득(earn) 요약하기 
by_race <- group_by(heights, race)
earn_by_race <- summarize(by_race, mean_earn = mean(earn))
earn_by_race
acs_or <- read_csv(url("http://stat511.cwick.co.nz/homeworks/acs_or.csv"))
acs_or
View(acs_or)
#침실이 2~4 개인 가구만 보이게 ( 행은 5행 열은 모두 보이게 )
filter(acs_or,bedrooms%in% c(2:4))%>%
  print(n=5, width = inf)
# 비정형 텍스트 파일 불러오기 
# read_file( ) :  하나의 문자열로 반환
#read_line( ) : 줄 단위의 배열로 반환


