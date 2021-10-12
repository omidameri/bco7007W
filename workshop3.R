install.packages("janeaustenr")

library(tidyverse)
library(tidytext)
library(janeaustenr)

data<-austen_books()


data_2_tokens<-data%>%unnest_tokens(word,text)

book_word<-data_2_tokens%>%count(book, word, sort=TRUE)

total_words<-book_word%>%
  group_by(book)%>%
  summarise(total=sum(n))

data_joint<-left_join(book_word, total_words)

data_joint2<-right_join(book_word, total_words)

