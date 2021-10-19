library(tidytext)
library(tidyverse)
library(janeaustenr)

install.packages("textdata")
library(textdata)


#load text
tidy_books<-austen_books()%>%
  group_by(book)%>%
  mutate(
    linenumber=row_number(),
    chapter=cumsum(
      str_detect(text,
                 regex("^chapter [\\divxlc]",
                       ignore_case = TRUE))
    )
  )%>%
  ungroup()%>%
  unnest_tokens(word, text)

nrc<-get_sentiments("nrc")

nrc_joy<-get_sentiments("nrc")%>%
  filter(sentiment=="joy")

tidy_books%>%
  filter(book=="Emma")%>%
  inner_join(nrc)%>%
  count(sentiment, sort=TRUE)


bing<-get_sentiments("bing")
