
library(tidyr)
library(dplyr)

#### Removing a couple of variables

tci<- read.csv('Z:/largetransfer/luc/carter/data/model_data/tci_final.csv',header = T)

to_drop<- c('occup','cqual_num','sa_days','LATITUDE','LONGITUDE')

tci1<- tci[,!(names(tci) %in% to_drop)]

#tci2<- tci %>% select(-c(occup,cqual_num,sa_days,LATITUDE,LONGITUDE))
rm(tci)

#### Adding a couple of variables


#mprop<- read.csv('Z:/largetransfer/luc/carter/data/clean_data/main_prop.csv', header=T)

# gprop<- tbl_df(mprop) %>% group_by(parcel) %>% top_n(1,taxyr) %>% subset(taxyr== 2014)
# 
# gprop<- gprop[!duplicated(gprop),]

mpropf<- read.csv('Z:/largetransfer/luc/carter/data/clean_data/main_prop_filtered.csv',header=T)

tci2<-  right_join(tci1,mpropf[,c('parcel','pclass','nluc')],by='parcel')
#tci2<-  right_join(tci1,mpropf[,c('parcel','nluc')],by='parcel')


# rm(gmprop,gprop,mpropf)

demo<- read.csv('Z:/largetransfer/luc/carter/data/clean_data/demographic.csv')

demo1<- demo %>%subset(parcel %in% tci2$parcel) %>%select(parcel,NAME10)

tci3<- merge(tci2,demo1,by.x='parcel',by.y='parcel')
tci3<- tci3 %>% select(-c(condition_value13))

#tci3<- tci3 %>% select(-c(condition_value13,condition_value14))

write.csv(tci3,'Z:/largetransfer/luc/carter/data/model_data/tci_final1_10_10_2016.csv')



