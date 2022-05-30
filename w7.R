# 7주차 내용임 

player <- c("Kim", "Park", "Choi", "Yi")
ba <- c(1.63, 2.91, 2.34, 1.98) #ba: 타율

typeof(player)
typeof(ba)
# 벡터는 2가지 속성을 가지고 있음 자료형(type) 아래길이 
length(player)
length(ba)

# 논리형벡터는 3가지 값만 가짐  FALSE, TRUE, NA
a<- 1:10 %%3 ==0
b<- 1:10 %%3 ==0
a       
b

# 정수형(integer) 실수형(double)
# R 에서는 실수형이 기본이다 
# 실수형> 정수형으로 만들기 ba:앞에서 만든 '타율' 벡터
ba_i <- as.integer(ba)
typeof(ba_i)
ba_i

# 정수형과 실수형 벡터 차이
x <- sqrt(2)^2
x
x-2
c(-1,0,1)/0

# 문자형(character),개별요소는 문자열(string)
# pryr::object_size( ) 함수: 메모리 사용 양을 출력한다

x <- "이 과목은 머신러닝 기초 과목입니다"
object_size(x)

# 결측값 : 기본형 벡터 자료형은 고유의 결측값 가짐 
NA # 논리형
NA_integer_ # 정수형
NA_real_ # 실수형
NA_character_ # 문자형
# 벡터의 자료변환 / 명백한 변환은 함수 사용 
# 내재적 변환 : 특수한 문맥 
# 정수형 벡터를 비교하면 결과는 논리형 값으로 표시되지만
# 합계 (sum( ) 함수), 평균(mean( ) 함수) 값을 구할 경우
# TRUE 는 1, FALSE 는 0 으로 변환 됨 

x <- sample(1:20, 100, replace = TRUE) # 1에서 20까지 숫자를
# 이용하여 100개 샘플을 작성하며, 반복 사용이 가능하다
x
y <- x>10
y
sum(y)
mean(y)

# 여러 자료형을 포함한 벡터는 복잡한 자료형이 우선
# 우선순위: 문자형 > 실수형 > 정수형 > 논리형

typeof(c(TRUE, 1L)) # 벡터에서는 실수가 디폴트
typeof(c(1L, 1.5))  # 실수 > 정수 위해서 뒤에 L첨부 
typeof(c(1.5, "a"))

# 스칼라는 하나의 숫자임 R에는 스칼라가 없으므로, 하나의 숫자는 숫자의 벡터로 취급
sample(10) + 100
1:2 + 1:2
# 순환 규칙이 적용되기 위해서는 짧은 길이 벡터가 긴 길이
# 벡터와 length 가 같거나
# 긴 길이 벡터가 짧은 길이 벡터의 정수 곱이 되어야 한다
1:10+1:2
1:10+1:3
# 벡터에 이름 정하기 
c(x = 1, y = 2, z = 3)
# purr::set_names( ) 함수를 이용하여 값 입력 후에 이름을 정함
set_names (1:3, c("a", "b", "c"))
# 하위 벡터 만들기 

# 연습문제 1 
x <- c (10, 3, NA, 5 ,8, 1, NA)
x[is.na(x)]
 x <-sample(10)
 x
 x[10]
 x[x%%2==0]
x[!is.na(x)]
# 행렬 
m <- matrix(1:12, nrow=4, ncol=3)
m
x <- c(2011:2016, 262, 342, 281, 332, 261, 262, 1765, 1642, 1278,
       1193, 990, 921, 209, 213, 264, 230, 206, 234)
a <- matrix(x, nrow=6, ncol=4)
a
a[1,2]
a1 <- a[c(1,3,5),1:2]
a1
a2 <- a[a[,2] > 300, 1:2]
a2
a3 <- a[a[,2] > 300 & a[,3] > 1500, 1]
a3
#연습문제 2
x <- c(2011:2016, 262, 342, 281, 332, 261, 262, 1765, 1642, 1278,
       1193, 990, 921, 209, 213, 264, 230, 206, 234)
a <- matrix(x, nrow=6, ncol=4)
a
a4 <- a[a[,2] < 300 & a[,3]> 1000, 1]
a4
#  APPLY( ) 함수
y <- c(262, 342, 281, 332, 261, 262, 1765, 1642, 1278,
       1193, 990, 921, 209, 213, 264, 230, 206, 234)
y1 <- matrix(y, 6, 3)
y1
y2 <- apply(y1, 1, sum)
y2
y3 <- apply(y1, 2, sum)
y3
# 행에 이름 넣기 rownames( )/ 열에 이름 넣기 colnames( ) 
rownames(y1) <- 2011:2016
colnames(y1) <- c("Japan", "China", "USA")
y1
# 리스트 
x <- list(1, 2, 3)
x
# str( ) 함수를 이용하여 리스트 구조(structure) 파악
str(x)
# 리스트를 만들 때, 벡터처럼 이름을 정할 수 있다
x_named <- list(a = 1, b = 2, c = 3)
str(x_named)
# 리스트는 벡터와 달리, 여러 자료형을 함께 포함할 수 있다
y <- list("a", 1L, 1.5, TRUE)
str(y)
# 다른 리스트도 포함 가능 
z <- list(list(1, 2), list(3, 4))
str(z)
# 리스트 유형 
x1 <- list(c(1, 2), c(3, 4))
x2 <- list(list(1, 2), list(3, 4))
x3 <- list(1, list(2, list(3)))
# 하위 리스트(Subsetting)  찾는 3가지 방법 
a <- list(a = 1:3, b = "a string", c = pi, d = list(-1, -5))
str(a[1:2])
str(a[4])
# 리스트에서 요소 하나 찾기 
str(y[[1]]) 
str(y[[4]])
a$a
a[["a"]]
