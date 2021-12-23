---
title: "Whatsapp chat sentiment analysis"
author: "Muhammad Junaid"
date: "12/24/2021"
---
library(gtrendsR)
library(ggplot2)
library(stringi)
library(dplyr)
library(rwhatsapp)
#Importing file
history <- system.file("extdata", "WhatsApp Chat - ACM TEAM GROUP CHAT", package = "rwhatsapp")
chat <- rwa_read("_Chat.txt") %>% 
  # Non Author Messages are Filtered Out
  filter(!is.na(author)) 
chat
#last 20 messages
x<-tail(chat,20)
x
#total no of messages
c<-count(chat)
c
#total number of media messages
cmc<-length(grep("image omitted", chat$text))+length(grep("audio omitted", chat$text))+length(grep("sticker omitted", chat$text))+length(grep("GIF omitted", chat$text))
cmc
# total number of emotes present in chat
cec<-c-length(grep("NULL", chat$emoji))
cec
#URLs present in this chat
urlp<-chat[grep("^https", chat$text),]
tnoup<-"Total no of URLS present are: "  
x<-as.character(count(urlp))
x<-paste(tnoup,x)
x
"List of URLS"
print(urlp$text)
"List of URLS with authers"
select(urlp, author, text)

#stat of each author
authors<-unique(chat$author)
authors
len<-length(authors)
#no of messages function
noOfMessages <- function(name){
  p<-as.character(name)
  if(!stri_cmp(substr(p,1,2),"+")){
    #name<-paste("<U+202A>",name,"<U+202C>",sep="")
    
  }
  return(length(grep(name, chat$author)))
}
avgWordsPerMinute<-function(name,nom){
  no<-0
  words<-""
  for(i in range(nom)){
    
  }
  DF <- chat[ chat$author == name , ]
  no<-no+length(strsplit(DF$text, " ")[[1]])
  
  return(no)
}
for(i in 2:len){
  #Stats For Author
  sd<-paste("Stats For Author: ",authors[i])
  print("______________________________________")
  print(sd)
  nom<-noOfMessages(authors[i])
  nom<-nom+1
  u<-paste("No of Messages Sent: ",nom)
  print(u)
  #Average Words Per Message
  awpm<-avgWordsPerMinute(authors[i],u)
  u<-paste("Average Words Per Message: ",awpm/nom)
  print(u)
  
}

