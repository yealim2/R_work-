library(tidyverse)
install.packages('tidytext')
library(tidytext)
install.packages('janeaustenr')
library(janeaustenr)
install.packages('gutenbergr')
library(gutenbergr)
install.packages('scales')
library(scales)
text <-c("Because I could not stop for Death-",
         "He kindly stopped for me-",
         "The Carriage held but just Ourselves-",
         "and Immortality")
text
text_tibble <-tibble(line=1:4,text = text)
text_tibble

tidytext::unnest_tokens()
text_tibble %>% 
  unnest_tokens(word, text)
hgwells <- gutenberg_download(c(35, 36, 5230, 159))
library(gutenbergr)
hgwells <- gutenberg_download(c(35, 36, 5230, 159))
tidy_hgwells <- hgwells %>%
  unnest_tokens(word, text) %>%
  anti_join(stop_words)
tidy_hgwells %>%
  count(word, sort = TRUE)




score_inter <- lm(score ~ age * gender, data = evals_age)
get_regression_table(score_inter)