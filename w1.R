install.packages("tidyverse")
library(tidyverse)

c(3.5,4.5,4.0,3.5,4.0,4.0)
score <-c(3.5,4.5,4.0,3.5,4.0,4.0)
score
class <-( "철학","R프로그램","영어","대학수학","데통2","데이터베이스" )
gpa <-sum(score)/6
gpa

install.packages("tidyverse")
library(tidyverse)
mpg
#ggplot 함수에 mapping=aes 들어가면 전체의 영행을 미침 
ggplot(data=mpg)+
  geom_point(mapping=aes(x=displ,y=hwy))
ggplot(data=<DATA>)+
  <GEOM_FUNCTION>(mapping=ase(<MAPPINGS>))
ggplot(data=mpg)
ggplot(data=mpg)+
  geom_point(mapping=aes(x=displ,y=hwy,color=class))
ggplot(data=mpg)+
  geom_point(mapping=aes(x=displ,y=hwy,size=class))
ggplot(data=mpg)+
  geom_point(mapping=aes(x=displ,y=hwy,alpha=class))
ggplot(data=mpg)+
  geom_point(mapping=aes(x=displ,y=hwy,shape=class))

# 점의 모양,색깔,크기 를 바꾸려면 ase()함수 밖에 써야지 적용가능 
ggplot(data=mpg)+
  geom_point(mapping=aes(x=displ,y=hwy),color="blue")
ggplot(data=mpg)+
  geom_point(mapping=aes(x=displ,y=hwy),color="red")
ggplot(data=mpg)+
  geom_point(mapping=aes(x=displ,y=hwy),color="blue",shape=21,size=3)

# 패싯은 비교할때 유용함 ,+ 는 무조건 첫줄에 사용 
ggplot(data=mpg)+
  geom_point(mapping=aes(x=displ,y=hwy))+
  facet_wrap(~class,nrow=2)
ggplot(data=mpg)+
  geom_point(mapping=aes(x=displ,y=hwy))+
  facet_grid(drv~cyl)
ggplot(data=diamonds)+
  geom_bar(mapping=aes(x=cut))
ggplot(data=diamonds)+
  stat_summary(
    mapping=aes(x=cut,y=depth),
    fun.ymin=min,
    fun.ymax=max,
    fun.y=median
    )
ggplot(data=diamonds)+
  geom_bar(mapping=aes(x=cut,color=cut))
ggplot(data=diamonds)+
  geom_bar(mapping=aes(x=cut,fill=cut))
ggplot(data=diamonds,mapping=aes(x=cut,fill=cut))+

ggplot(data=diamonds)+
  geom_bar(mapping=aes(x=cut,fill=cut),
           show.legend=FALSE,width=1)+
  labs(x=NULL,y=NULL)+
  coord_polar()
ggplot(data=diamonds,aes(x=cut))+
  geom_bar(mapping=aes(x='"',fill=cut))+
  labs(x=NULL,y=NULL)+
  coord_polar("y",start=0)

install.packages("maps")
library(maps)

library(tidyverse)
# 아래의 실행결과 셀이 비어있는 이유는 aes함수에서 사용한 피쳐는 다시 사용 안됨 
ggplot(data=mpg)+
  geom_point(mapping=aes(x=displ,y=hwy))+
  facet_grid(drv~cyl)
ggplot(data=mpg)+
  geom_point(mapping=aes(x=drv,y=cyl))+
  facet_grid(drv~cyl)

# 3주차 데이터 변환 
install.packages("nycflights13")
library(nycflights13)
library(tidyverse)
nycflights13::flights
view(flights)
filter(flights,month==1,day==1)
jan1<-filter(flights,month==1,day==1)
(dec25<-filter(flights,month==12,day==25))
# 퍼센트 사용 11월12월 모두 뽑아내기
nov_dec<-filter(flights,month%in%c(11,12))
head(nov_dec) #앞 일부분만
tail(nov_dec) # 뒤 일부분만 
#2시간이상 늦게 도착하거나 출발하지않은 모든 항공편 찾기
filter(flights,!(arr_delay>120|dep_delay>120))
filter(flights,arr_delay<=120,dep_delay<=120)
##첫번째 연습문제 
##2시간 이상 출발이지연된 항공편 찾기 
filter(flights,!(dep_delay>120))
##휴스톤으로 출발한 항공편 찾기 , dest=="iah"
##United, American, or Delta에서 운항한 항공편 찾기
##여름철(July, August, and September)에 출발한항공편 찾기
jul_sep<-filter(flights,month%in%c(7,8,9))
head(jul_sep)
tail(jul_sep)
# arrange()함수
arrange(flights,year,month,day)
arrange(flights,desc(dep_delay)) #출발시간이 지연된 순서로 배열 
##2번째 연습문제 
##가장 빨리 출발(sched_dep_time)하는 항공편 순으로 정렬
arrange(flights,desc(sched_dep_time))
##운항거리(distance)가 먼 항공편 순으로 정렬하시오
arrange(flights,desc(distance))
# 셀렉트 함수
select(flights,year,month,day)
select(flights,year:day) #year와 day사이의 모든피쳐
select(flights,-(year:day)) # year하고 day제외 모든 피쳐 
select(flights,starts_with("f")) # f로 시작하는 모든 피쳐
select(flights,ends_with("e")) #e로 끝나는 모든 피쳐 
# 뮤태이트 함수 
flights_sml<-select(flights,year:day,ends_with("delay"),distance,air_time)#필요한데이터초함된 객체 만들기 
mutate(flights_sml,gain=arr_delay-dep_delay,speed=distance/air_time*60)#새로운 객체 필요한 피처 삽입하기
#transmute()함수
transmute(flights_sml,gain=arr_delay-dep_delay,hours=air_time/60,gain_per_hour=gain/hours)
##3번쨰 연습문제 
#summarize() 함수 
by_day <- group_by(flights, year, month, day)
summarize(by_day, delay = mean(dep_delay, na.rm = TRUE))
#pipe 연산자 (%>%) 적용,26페이지
by_dest <- group_by(flights, dest)
delay <- summarize(by_dest,
                   count = n(),
                   dist=mean(distance, na.rm = TRUE),
                   delay=mean(arr_delay, na.rm = TRUE))
filter(delay, count > 1000)
# 27 페이지
delay <- flights %>%
  group_by(dest) %>%
  summarize(
    count = n(),
    dist = mean(distance, na.rm = TRUE),
    delay = mean(arr_delay, na.rm = TRUE)
  ) %>%
  filter(count > 1000)
delay
#결측값 ,28페이지
flights %>%
  group_by(year, month, day) %>%
  summarize(mean = mean(dep_delay))
#결측값 활용 사례 입력해보셈 