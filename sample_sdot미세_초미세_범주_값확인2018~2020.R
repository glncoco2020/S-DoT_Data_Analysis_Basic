library(colorRamps)
library(RColorBrewer)
palette222 <- brewer.pal(5, "YlGnBu")

set<-stat_sdot %>% filter(month =="12") %>% group_by(address) %>% summarise(dust = mean(dust), super_dust = mean(super_dust))

a<-set %>% filter(dust >=0, dust <=30.999999) %>% nrow()
b<-set %>% filter(dust >=31, dust <=80.999999) %>% nrow()
c<-set %>% filter(dust >=81, dust <=150.99999) %>% nrow()
d<-set %>% filter(dust >=151) %>% nrow()

e<-set %>%  filter(super_dust >=0, super_dust <=15.99999999) %>% nrow()
f<-set %>%  filter(super_dust >=16, super_dust <=35.999999999) %>% nrow()
g<-set %>%  filter(super_dust >=36, super_dust <=75.999999999) %>% nrow()
h<-set %>%  filter(super_dust >=76) %>% nrow()

#2019년 12월 트래픽 보정 미세먼지 히트맵 버전 
tr12<- traffic_mean %>% filter(month =="12")
content <- paste0(
                 "나쁨 : ",c,"개, 매우나쁨 : ",d,"개"
)

a+b+c+d
e+f+g+h
#히트맵 있는 버전
leaflet(data_polys) %>%
  setView(lng=125.9784, lat=37.566, zoom=11) %>%
  addPolygons(fillColor = "white",weight ="2",color = "black", opacity = 0.8  ) %>% 
  addProviderTiles('CartoDB.Positron') %>% 
  addCircleMarkers(data = stat_sdot %>% group_by(address) %>% filter(dust >=81, month ==12), lat = ~lat, lng = ~long,
                   fillColor = ~beatCol_dust(BeatHomeLvl_dust), popup = stat_sdot$dust,
                   radius = ~sqrt(dust/2),  stroke = TRUE, fillOpacity = 0.8, color = "black", weight =1.2) %>% 
  
  addCircleMarkers(data = stat_sdot  %>% group_by(address) %>% filter(dust >=0, dust <=30, month ==12), lat = ~lat, lng = ~long,
                   fillColor = ~beatCol_dust(BeatHomeLvl_dust), popup = stat_sdot$dust,
                   radius = ~sqrt(dust/3),  stroke = FALSE, fillOpacity = 0.1, color = "black", weight =0.3) %>% 
  
  addCircleMarkers(data = stat_sdot  %>% group_by(address) %>% filter(dust >=31, dust <=80, month ==12), lat = ~lat, lng = ~long,
                   fillColor = ~beatCol_dust(BeatHomeLvl_dust), popup = stat_sdot$dust,
                   radius = ~sqrt(dust/3),  stroke = FALSE, fillOpacity = 0.1, color = "black", weight =0.3) %>% 
  
  addHeatmap(tr12, lng = tr12$long, lat = tr12$lat, intensity = tr12$mean, blur=40, radius =33, max= 5000)  %>% 
  addPopups(126.8695, 37.649, content,
            options = popupOptions(closeButton = FALSE)) %>% 
  addLegendCustom("bottomright", 
                  colors =c("#3982BA", "#66B74F", "#FAE284", "#E93A30"),
                  labels= c("좋음 : 0 ~ 30㎍/㎥", "보통 : 31 ~ 80㎍/㎥","나쁨 : 81 ~ 150㎍/㎥","매우나쁨 : 151㎍/㎥ 이상"),
                  sizes = c(10, 12, 13,15), 
                  opacity = 1,
                  title= "미세먼지(PM10) 기준 등급") %>% 
  
  addLegend("bottomright", 
            colors =c("#3982BA","#1CFF77", "#66B74F", "#FAE284", "#E93A30"),
            labels= c("0 ~ 2000대", "2000 ~ 3000대","3000 ~ 4000대","4000 ~ 5000대","5000대 이상"),
            title= "주요지점 교통량",
            opacity = 1)

#히트맵 없는 버전
leaflet(data_polys) %>%
  setView(lng=126.9784, lat=37.566, zoom=11) %>%
  addPolygons(fillColor = "white",weight ="2",color = "black", opacity = 0.8  ) %>% 
  addProviderTiles('CartoDB.Positron') %>% 
  
  addCircleMarkers(data = stat_sdot  %>% filter(dust >=81, month ==12), lat = ~lat, lng = ~long,
                   fillColor = ~beatCol_dust(BeatHomeLvl_dust), popup = stat_sdot$dust,
                   radius = ~sqrt(dust/2),  stroke = TRUE, fillOpacity = 0.8, color = "black", weight =1.2) %>% 
  
  addCircleMarkers(data = stat_sdot  %>% filter(dust >=0, dust <=30, month ==12), lat = ~lat, lng = ~long,
                   fillColor = ~beatCol_dust(BeatHomeLvl_dust), popup = stat_sdot$dust,
                   radius = ~sqrt(dust/3),  stroke = FALSE, fillOpacity = 0.1, color = "black", weight =0.3) %>% 
  
  addCircleMarkers(data = stat_sdot  %>% filter(dust >=31, dust <=80, month ==12), lat = ~lat, lng = ~long,
                   fillColor = ~beatCol_dust(BeatHomeLvl_dust), popup = stat_sdot$dust,
                   radius = ~sqrt(dust/3),  stroke = FALSE, fillOpacity = 0.1, color = "black", weight =0.3) %>% 
  
  
  addPopups(126.8695, 37.649, content,
            options = popupOptions(closeButton = FALSE)) %>% 
  addLegendCustom("bottomright", 
                  colors =c("#3982BA", "#66B74F", "#FAE284", "#E93A30"),
                  labels= c("좋음 : 0 ~ 30㎍/㎥", "보통 : 31 ~ 80㎍/㎥","나쁨 : 81 ~ 150㎍/㎥","매우나쁨 : 151㎍/㎥ 이상"),
                  sizes = c(10, 12, 13,15), 
                  opacity = 1,
                  title= "미세먼지(PM10) 기준 등급")



#2019년 12월 트래픽 보정 초미세먼지 히트맵 버전 
tr12<- traffic_mean %>% filter(month =="12")
content <- paste0(
  " 나쁨 : ",g,"개, 매우나쁨 : ",h,"개"
)

leaflet(data_polys) %>%
  setView(lng=126.9784, lat=37.566, zoom=11) %>%
  addPolygons(fillColor = "white",weight ="2",color = "black", opacity = 0.8  ) %>% 
  addProviderTiles('CartoDB.Positron') %>% 
  addCircleMarkers(data = stat_sdot  %>% filter(super_dust >=0, super_dust <=15, month ==12), lat = ~lat, lng = ~long,
                   fillColor = ~beatCol(BeatHomeLvl), popup = stat_sdot$super_dust,
                   radius = ~sqrt(super_dust/4),  stroke = FALSE, fillOpacity = 0.1, color = "black", weight =0.3) %>% 
  
  addCircleMarkers(data = stat_sdot  %>% filter(super_dust >=16, super_dust <=35, month ==12), lat = ~lat, lng = ~long,
                   fillColor = ~beatCol(BeatHomeLvl), popup = stat_sdot$super_dust,
                   radius = ~sqrt(super_dust/4),  stroke = FALSE, fillOpacity = 0.1, color = "black", weight =0.3) %>% 
  
  addCircleMarkers(data = stat_sdot  %>% filter(super_dust >=36, month ==12), lat = ~lat, lng = ~long,
                   fillColor = ~beatCol(BeatHomeLvl), popup = stat_sdot$super_dust,
                   radius = ~sqrt(super_dust/2),  stroke = TRUE, fillOpacity = 0.8, color = "black", weight =1) %>% 
  
  
  addHeatmap(tr12, lng = tr12$long, lat = tr12$lat, intensity = tr12$mean, blur=40, radius =33, max= 5000) %>% 
  addPopups(126.8695, 37.649, content,
            options = popupOptions(closeButton = FALSE)) %>% 
  addLegendCustom("bottomright", 
                  colors =c("#3982BA", "#66B74F", "#FAE284", "#E93A30"),
                  labels= c("좋음 : 0 ~ 15㎍/㎥", "보통 : 16 ~ 35㎍/㎥","나쁨 : 36 ~ 75㎍/㎥","매우나쁨 : 76㎍/㎥ 이상"),
                  sizes = c(10, 12, 13,15), 
                  opacity = 1,
                  title= "초미세먼지(PM2.5) 기준 등급") %>% 
  addLegend("bottomright", 
            colors =c("#3982BA","#1CFF77", "#66B74F", "#FAE284", "#E93A30"),
            labels= c("0 ~ 2000대", "2000 ~ 3000대","3000 ~ 4000대","4000 ~ 5000대","5000대 이상"),
            title= "주요지점 교통량",
            opacity = 1)


#2019년 12월 트래픽 보정 초미세먼지 히트맵 없는버전 
leaflet(data_polys) %>%
  setView(lng=126.9784, lat=37.566, zoom=11) %>%
  addPolygons(fillColor = "white",weight ="2",color = "black", opacity = 0.8  ) %>% 
  addProviderTiles('CartoDB.Positron') %>% 
  addCircleMarkers(data = stat_sdot  %>% filter(super_dust >=0, super_dust <=15, month ==12), lat = ~lat, lng = ~long,
                   fillColor = ~beatCol(BeatHomeLvl), popup = stat_sdot$super_dust,
                   radius = ~sqrt(super_dust/4),  stroke = FALSE, fillOpacity = 0.1, color = "black", weight =0.3) %>% 
  
  addCircleMarkers(data = stat_sdot  %>% filter(super_dust >=16, super_dust <=35, month ==12), lat = ~lat, lng = ~long,
                   fillColor = ~beatCol(BeatHomeLvl), popup = stat_sdot$super_dust,
                   radius = ~sqrt(super_dust/4),  stroke = FALSE, fillOpacity = 0.1, color = "black", weight =0.3) %>% 
  
  addCircleMarkers(data = stat_sdot  %>% filter(super_dust >=36, month ==12), lat = ~lat, lng = ~long,
                   fillColor = ~beatCol(BeatHomeLvl), popup = stat_sdot$super_dust,
                   radius = ~sqrt(super_dust/2),  stroke = TRUE, fillOpacity = 0.8, color = "black", weight =1) %>% 
  
  addPopups(126.8695, 37.649, content,
            options = popupOptions(closeButton = FALSE)) %>% 
  addLegend("bottomright", 
            colors =c("#3982BA","#1CFF77", "#66B74F", "#FAE284", "#E93A30"),
            labels= c("0 ~ 2000대", "2000 ~ 3000대","3000 ~ 4000대","4000 ~ 5000대","5000대 이상"),
            title= "주요지점 교통량",
            opacity = 1)





# stat_sdot
#stat_sdot %>% group_by(address) %>% filter(month ==1) %>% view()


set<-stat_sdot %>% filter(month =="1") %>% group_by(address) %>% summarise(dust = mean(dust), super_dust = mean(super_dust))

a<-set %>% filter(dust >=0, dust <=30.999999) %>% nrow()
b<-set %>% filter(dust >=31, dust <=80.999999) %>% nrow()
c<-set %>% filter(dust >=81, dust <=150.99999) %>% nrow()
d<-set %>% filter(dust >=151) %>% nrow()

e<-set %>%  filter(super_dust >=0, super_dust <=15.99999999) %>% nrow()
f<-set %>%  filter(super_dust >=16, super_dust <=35.999999999) %>% nrow()
g<-set %>%  filter(super_dust >=36, super_dust <=75.999999999) %>% nrow()
h<-set %>%  filter(super_dust >=76) %>% nrow()


#2020년 1월 트래픽 보정 미세먼지 히트맵 버전 
tr01<- traffic_mean %>% filter(month =="01")
content <- paste0(
  "   나쁨 : ",c,"개, 매우나쁨 : ",d,"개"
)

#히트맵 있는거 
leaflet(data_polys) %>%
  setView(lng=126.9784, lat=37.566, zoom=11) %>%
  addPolygons(fillColor = "white",weight ="2",color = "black", opacity = 0.8  ) %>% 
  addProviderTiles('CartoDB.Positron') %>% 
  
  addCircleMarkers(data = stat_sdot  %>% filter(dust >=81, month ==1), lat = ~lat, lng = ~long,
                   fillColor = ~beatCol_dust(BeatHomeLvl_dust), popup = stat_sdot$dust,
                   radius = ~sqrt(dust/2),  stroke = TRUE, fillOpacity = 0.8, color = "black", weight =1.2) %>% 
  
  addCircleMarkers(data = stat_sdot  %>% filter(dust >=0, dust <=30, month ==1), lat = ~lat, lng = ~long,
                   fillColor = ~beatCol_dust(BeatHomeLvl_dust), popup = stat_sdot$dust,
                   radius = ~sqrt(dust/3),  stroke = FALSE, fillOpacity = 0.1, color = "black", weight =0.3) %>% 
  
  addCircleMarkers(data = stat_sdot  %>% filter(dust >=31, dust <=80, month ==1), lat = ~lat, lng = ~long,
                   fillColor = ~beatCol_dust(BeatHomeLvl_dust), popup = stat_sdot$dust,
                   radius = ~sqrt(dust/3),  stroke = FALSE, fillOpacity = 0.1, color = "black", weight =0.3) %>% 
  
  
  addHeatmap(tr01, lng = tr01$long, lat = tr01$lat, intensity = tr01$mean, blur=40, radius =34, max= 5000)   %>% 
  addPopups(126.8695, 37.649, content,
            options = popupOptions(closeButton = FALSE)) %>% 
  addLegendCustom("bottomright", 
                  colors =c("#3982BA", "#66B74F", "#FAE284", "#E93A30"),
                  labels= c("좋음 : 0 ~ 30㎍/㎥", "보통 : 31 ~ 80㎍/㎥","나쁨 : 81 ~ 150㎍/㎥","매우나쁨 : 151㎍/㎥ 이상"),
                  sizes = c(10, 12, 13,15), 
                  opacity = 1,
                  title= "미세먼지(PM10) 기준 등급") %>% 

  addLegend("bottomright", 
            colors =c("#3982BA","#1CFF77", "#66B74F", "#FAE284", "#E93A30"),
            labels= c("0 ~ 2000대", "2000 ~ 3000대","3000 ~ 4000대","4000 ~ 5000대","5000대 이상"),
            title= "주요지점 교통량",
            opacity = 1)


aa01 <- stat_sdot %>% filter(dust >=81, month ==1)
aa01_row <- stat_sdot %>% filter(dust <=80, month ==1)

#히트맵 없는거 
leaflet(data_polys) %>%
  setView(lng=126.9784, lat=37.566, zoom=11) %>%
  addPolygons(fillColor = "white",weight ="2",color = "black", opacity = 0.8  ) %>% 
  addProviderTiles('CartoDB.Positron') %>% 
  
  addHeatmap(aa01_row, lng = aa01_row$long, lat = aa01_row$lat, intensity = aa01_row$dust, blur=100, radius =30, max =200, gradient= "palette222")  %>%  
  addHeatmap(aa01, lng = aa01$long, lat = aa01$lat, intensity = aa01$dust, blur=40, radius =24, max =60)  %>%
  
  addCircleMarkers(data = stat_sdot  %>% filter(dust >=81, month ==1), lat = ~lat, lng = ~long,
                   fillColor = ~beatCol_dust(BeatHomeLvl_dust), popup = stat_sdot$dust,
                   radius = ~sqrt(dust/2),  stroke = TRUE, fillOpacity = 0.8, color = "black", weight =1.2) %>% 
  
  addCircleMarkers(data = stat_sdot  %>% filter(dust >=0, dust <=30, month ==1), lat = ~lat, lng = ~long,
                   fillColor = ~beatCol_dust(BeatHomeLvl_dust), popup = stat_sdot$dust,
                   radius = ~sqrt(dust/3),  stroke = FALSE, fillOpacity = 0.1, color = "black", weight =0.3) %>% 
  
  addCircleMarkers(data = stat_sdot  %>% filter(dust >=31, dust <=80, month ==1), lat = ~lat, lng = ~long,
                   fillColor = ~beatCol_dust(BeatHomeLvl_dust), popup = stat_sdot$dust,
                   radius = ~sqrt(dust/3),  stroke = FALSE, fillOpacity = 0.1, color = "black", weight =0.3) %>% 
  
  
  addPopups(126.8695, 37.649, content,
            options = popupOptions(closeButton = FALSE)) %>% 
  addLegendCustom("bottomright", 
                  colors =c("#3982BA", "#66B74F", "#FAE284", "#E93A30"),
                  labels= c("좋음 : 0 ~ 30㎍/㎥", "보통 : 31 ~ 80㎍/㎥","나쁨 : 81 ~ 150㎍/㎥","매우나쁨 : 151㎍/㎥ 이상"),
                  sizes = c(10, 12, 13,15), 
                  opacity = 1,
                  title= "미세먼지(PM10) 기준 등급")



#2020년 1월 트래픽 보정 초미세먼지 히트맵 버전 
tr01<- traffic_mean %>% filter(month =="01")
content <- paste0(
  " 나쁨 : ",g,"개, 매우나쁨 : ",h,"개"
)
#히트맵 있는거 
leaflet(data_polys) %>%
  setView(lng=126.9784, lat=37.566, zoom=11) %>%
  addPolygons(fillColor = "white",weight ="2",color = "black", opacity = 0.8  ) %>% 
  addProviderTiles('CartoDB.Positron') %>% 
  addCircleMarkers(data = stat_sdot  %>% filter(super_dust >=0, super_dust <=15, month ==1), lat = ~lat, lng = ~long,
                   fillColor = ~beatCol(BeatHomeLvl), popup = stat_sdot$super_dust,
                   radius = ~sqrt(super_dust/4),  stroke = FALSE, fillOpacity = 0.1, color = "black", weight =0.3) %>% 
  
  addCircleMarkers(data = stat_sdot  %>% filter(super_dust >=16, super_dust <=35, month ==1), lat = ~lat, lng = ~long,
                   fillColor = ~beatCol(BeatHomeLvl), popup = stat_sdot$super_dust,
                   radius = ~sqrt(super_dust/4),  stroke = FALSE, fillOpacity = 0.1, color = "black", weight =0.3) %>% 
  
  addCircleMarkers(data = stat_sdot  %>% filter(super_dust >=36, month ==1), lat = ~lat, lng = ~long,
                   fillColor = ~beatCol(BeatHomeLvl), popup = stat_sdot$super_dust,
                   radius = ~sqrt(super_dust/2),  stroke = TRUE, fillOpacity = 0.8, color = "black", weight =1) %>% 
  
  addHeatmap(tr01, lng = tr01$long, lat = tr01$lat, intensity = tr01$mean, blur=40, radius =34, max= 5000)  %>% 
  addPopups(126.8695, 37.649, content,
            options = popupOptions(closeButton = FALSE)) %>% 
  addLegendCustom("bottomright", 
                  colors =c("#3982BA", "#66B74F", "#FAE284", "#E93A30"),
                  labels= c("좋음 : 0 ~ 15㎍/㎥", "보통 : 16 ~ 35㎍/㎥","나쁨 : 36 ~ 75㎍/㎥","매우나쁨 : 76㎍/㎥ 이상"),
                  sizes = c(10, 12, 13,15), 
                  opacity = 1,
                  title= "초미세먼지(PM2.5) 기준 등급") %>% 
  
  addLegend("bottomright", 
            colors =c("#3982BA","#1CFF77", "#66B74F", "#FAE284", "#E93A30"),
            labels= c("0 ~ 2000대", "2000 ~ 3000대","3000 ~ 4000대","4000 ~ 5000대","5000대 이상"),
            title= "주요지점 교통량",
            opacity = 1)



aa01 <- stat_sdot %>% filter(super_dust >=36, month ==1)
aa01_row <- stat_sdot %>% filter(super_dust <=36, month ==1)
 

#stat_sdot  %>% filter(super_dust >=36, month ==1) %>% view()
#히트맵 없는거
leaflet(data_polys) %>%
  setView(lng=126.9784, lat=37.566, zoom=11) %>%
  addPolygons(fillColor = "white",weight ="2",color = "black", opacity = 0.8  ) %>% 
  addProviderTiles('CartoDB.Positron') %>% 
  
  addHeatmap(aa01_row, lng = aa01_row$long, lat = aa01_row$lat, intensity = aa01_row$super_dust, blur=100, radius =30, max =200, gradient= palette222)  %>%  
  addHeatmap(aa01, lng = aa01$long, lat = aa01$lat, intensity = aa01$super_dust, blur=40, radius =24, max =60)  %>%

  addCircleMarkers(data = stat_sdot  %>% filter(super_dust >=0, super_dust <=15, month ==1), lat = ~lat, lng = ~long,
                   fillColor = ~beatCol(BeatHomeLvl), popup = stat_sdot$super_dust,
                   radius = ~sqrt(super_dust/4),  stroke = FALSE, fillOpacity = 0.1, color = "black", weight =0.3) %>% 
  
  
  addCircleMarkers(data = stat_sdot  %>% filter(super_dust >=16, super_dust <=35, month ==1), lat = ~lat, lng = ~long,
                   fillColor = ~beatCol(BeatHomeLvl), popup = stat_sdot$super_dust,
                   radius = ~sqrt(super_dust/4),  stroke = FALSE, fillOpacity = 0.1, color = "black", weight =0.3) %>% 
  
  addCircleMarkers(data = stat_sdot  %>% filter(super_dust >=36, month ==1), lat = ~lat, lng = ~long,
                   fillColor = ~beatCol(BeatHomeLvl), popup = stat_sdot$super_dust,
                   radius = ~sqrt(super_dust/2),  stroke = TRUE, fillOpacity = 0.8, color = "black", weight =1) %>%

  # addCircleMarkers(data = vworld_dust, lat = ~lat, lng = ~long,
  #                  fillColor = "red", popup = stat_sdot$super_dust,
  #                  radius = ~sqrt(super_dust/8),  stroke = TRUE, fillOpacity = 0.8, color = "black", weight =1) %>%
  addPopups(126.8695, 37.649, content,
            options = popupOptions(closeButton = FALSE)) %>% 
  addLegendCustom("bottomright", 
                  colors =c("#3982BA", "#66B74F", "#FAE284", "#E93A30"),
                  labels= c("좋음 : 0 ~ 15㎍/㎥", "보통 : 16 ~ 35㎍/㎥","나쁨 : 36 ~ 75㎍/㎥","매우나쁨 : 76㎍/㎥ 이상"),
                  sizes = c(10, 12, 13,15), 
                  opacity = 1,
                  title= "초미세먼지(PM2.5) 기준 등급") 
  
#2020년 2월 트래픽 보정 미세먼지 히트맵 버전
#?addCircleMarkers

set<-stat_sdot %>% filter(month =="2") %>% group_by(address) %>% summarise(dust = mean(dust), super_dust = mean(super_dust))

a<-set %>% filter(dust >=0, dust <=30.999999) %>% nrow()
b<-set %>% filter(dust >=31, dust <=80.999999) %>% nrow()
c<-set %>% filter(dust >=81, dust <=150.99999) %>% nrow()
d<-set %>% filter(dust >=151) %>% nrow()

e<-set %>%  filter(super_dust >=0, super_dust <=15.99999999) %>% nrow()
f<-set %>%  filter(super_dust >=16, super_dust <=35.999999999) %>% nrow()
g<-set %>%  filter(super_dust >=36, super_dust <=75.999999999) %>% nrow()
h<-set %>%  filter(super_dust >=76) %>% nrow()

tr02<- traffic_mean %>% filter(month =="02")
content <- paste0(
  "   나쁨 : ",c,"개, 매우나쁨 : ",d,"개"
)

#히트맵 있는거
leaflet(data_polys) %>%
  setView(lng=126.9784, lat=37.566, zoom=11) %>%
  addPolygons(fillColor = "white",weight ="2",color = "black", opacity = 0.8  ) %>% 
  addProviderTiles('CartoDB.Positron') %>% 
  
  
  addCircleMarkers(data = stat_sdot  %>% filter(dust >=81, month ==2), lat = ~lat, lng = ~long,
                   fillColor = ~beatCol_dust(BeatHomeLvl_dust), popup = stat_sdot$dust,
                   radius = ~sqrt(dust/2),  stroke = TRUE, fillOpacity = 0.8, color = "black", weight =1.2) %>% 
  
  addCircleMarkers(data = stat_sdot  %>% filter(dust >=0, dust <=30, month ==2), lat = ~lat, lng = ~long,
                   fillColor = ~beatCol_dust(BeatHomeLvl_dust), popup = stat_sdot$dust,
                   radius = ~sqrt(dust/3),  stroke = FALSE, fillOpacity = 0.1, color = "black", weight =0.3) %>% 
  
  addCircleMarkers(data = stat_sdot  %>% filter(dust >=31, dust <=80, month ==2), lat = ~lat, lng = ~long,
                   fillColor = ~beatCol_dust(BeatHomeLvl_dust), popup = stat_sdot$dust,
                   radius = ~sqrt(dust/3),  stroke = FALSE, fillOpacity = 0.1, color = "black", weight =0.3) %>% 
  
  addHeatmap(tr02, lng = tr02$long, lat = tr02$lat, intensity = tr02$mean, blur=40, radius =34, max= 5000)  %>% 
  addPopups(126.8695, 37.649, content,
            options = popupOptions(closeButton = FALSE)) %>% 
  addLegendCustom("bottomright", 
                  colors =c("#3982BA", "#66B74F", "#FAE284", "#E93A30"),
                  labels= c("좋음 : 0 ~ 30㎍/㎥", "보통 : 31 ~ 80㎍/㎥","나쁨 : 81 ~ 150㎍/㎥","매우나쁨 : 151㎍/㎥ 이상"),
                  sizes = c(10, 12, 13,15), 
                  opacity = 1,
                  title= "미세먼지(PM10) 기준 등급") %>% 

  addLegend("bottomright", 
            colors =c("#3982BA","#1CFF77", "#66B74F", "#FAE284", "#E93A30"),
            labels= c("0 ~ 2000대", "2000 ~ 3000대","3000 ~ 4000대","4000 ~ 5000대","5000대 이상"),
            title= "주요지점 교통량",
            opacity = 1)
#stat_sdot %>% filter(month ==2) %>% view()



aa02 <- stat_sdot %>% filter(dust >=81, month ==2)
aa02_row <- stat_sdot %>% filter(dust <=80, month ==2)

#히트맵 없는거

leaflet(data_polys) %>%
  setView(lng=126.9784, lat=37.566, zoom=11) %>%
  addPolygons(fillColor = "white",weight ="2",color = "black", opacity = 0.8  ) %>% 
  addProviderTiles('CartoDB.Positron') %>% 
  
  addHeatmap(aa02_row, lng = aa02_row$long, lat = aa02_row$lat, intensity = aa02_row$dust, blur=100, radius =30, max =200, gradient= palette222) %>%  
  addHeatmap(aa02, lng = aa02$long, lat = aa02$lat, intensity = aa02$dust, blur=40, radius =24, max =60) %>%
  
  addCircleMarkers(data = stat_sdot  %>% filter(dust >=81, month ==2), lat = ~lat, lng = ~long,
                   fillColor = ~beatCol_dust(BeatHomeLvl_dust), popup = stat_sdot$dust,
                   radius = ~sqrt(dust/2),  stroke = TRUE, fillOpacity = 0.8, color = "black", weight =1.2) %>% 
  
  addCircleMarkers(data = stat_sdot  %>% filter(dust >=0, dust <=30, month ==2), lat = ~lat, lng = ~long,
                   fillColor = ~beatCol_dust(BeatHomeLvl_dust), popup = stat_sdot$dust,
                   radius = ~sqrt(dust/3),  stroke = FALSE, fillOpacity = 0.1, color = "black", weight =0.3) %>% 
  
  addCircleMarkers(data = stat_sdot  %>% filter(dust >=31, dust <=80, month ==2), lat = ~lat, lng = ~long,
                   fillColor = ~beatCol_dust(BeatHomeLvl_dust), popup = stat_sdot$dust,
                   radius = ~sqrt(dust/3),  stroke = FALSE, fillOpacity = 0.1, color = "black", weight =0.3) %>%
  
  addPopups(126.8695, 37.649, content,
            options = popupOptions(closeButton = FALSE)) %>% 
  addLegendCustom("bottomright", 
                  colors =c("#3982BA", "#66B74F", "#FAE284", "#E93A30"),
                  labels= c("좋음 : 0 ~ 30㎍/㎥", "보통 : 31 ~ 80㎍/㎥","나쁨 : 81 ~ 150㎍/㎥","매우나쁨 : 151㎍/㎥ 이상"),
                  sizes = c(10, 12, 13,15), 
                  opacity = 1,
                  title= "미세먼지(PM10) 기준 등급")



#2020년 2월 트래픽 보정 초미세먼지 히트맵 버전 

#히트맵 있는 버전 
tr02<- traffic_mean %>% filter(month =="02")
content <- paste0(
  " 나쁨 : ",g,"개, 매우나쁨 : ",h,"개"
)
leaflet(data_polys) %>%
  setView(lng=126.9784, lat=37.566, zoom=11) %>%
  addPolygons(fillColor = "white",weight ="2",color = "black", opacity = 0.8  ) %>% 
  addProviderTiles('CartoDB.Positron') %>% 
  
  addCircleMarkers(data = stat_sdot  %>% filter(super_dust >=0, super_dust <=15, month ==2), lat = ~lat, lng = ~long,
                   fillColor = ~beatCol(BeatHomeLvl), popup = stat_sdot$super_dust,
                   radius = ~sqrt(super_dust/4),  stroke = FALSE, fillOpacity = 0.1, color = "black", weight =0.3) %>% 
  
  addCircleMarkers(data = stat_sdot  %>% filter(super_dust >=16, super_dust <=35, month ==2), lat = ~lat, lng = ~long,
                   fillColor = ~beatCol(BeatHomeLvl), popup = stat_sdot$super_dust,
                   radius = ~sqrt(super_dust/4),  stroke = FALSE, fillOpacity = 0.1, color = "black", weight =0.3) %>% 
  
  addCircleMarkers(data = stat_sdot  %>% filter(super_dust >=36, month ==2), lat = ~lat, lng = ~long,
                   fillColor = ~beatCol(BeatHomeLvl), popup = stat_sdot$super_dust,
                   radius = ~sqrt(super_dust/2),  stroke = TRUE, fillOpacity = 0.8, color = "black", weight =1) %>% 
  
  
  
  addHeatmap(tr02, lng = tr02$long, lat = tr02$lat, intensity = tr02$mean, blur=40, radius =33, max= 5000)  %>% 
  addPopups(126.8695, 37.649, content,
            options = popupOptions(closeButton = FALSE)) %>%
  
  addLegendCustom("bottomright", 
                  colors =c("#3982BA", "#66B74F", "#FAE284", "#E93A30"),
                  labels= c("좋음 : 0 ~ 15㎍/㎥", "보통 : 16 ~ 35㎍/㎥","나쁨 : 36 ~ 75㎍/㎥","매우나쁨 : 76㎍/㎥ 이상"),
                  sizes = c(10, 12, 13,15), 
                  opacity = 1,
                  title= "초미세먼지(PM2.5) 기준 등급") %>% 
  
  addLegend("bottomright", 
            colors =c("#3982BA","#1CFF77", "#66B74F", "#FAE284", "#E93A30"),
            labels= c("0 ~ 2000대", "2000 ~ 3000대","3000 ~ 4000대","4000 ~ 5000대","5000대 이상"),
            title= "주요지점 교통량",
            opacity = 1)




aa02 <- stat_sdot %>% filter(super_dust >=36, month ==2)
aa02_row <- stat_sdot %>% filter(super_dust <=36, month ==2)

  
  
#히트맵 없는 버전 
leaflet(data_polys) %>%
  setView(lng=126.9784, lat=37.566, zoom=11) %>%
  addPolygons(fillColor = "white",weight ="2",color = "black", opacity = 0.8  ) %>% 
  addProviderTiles('CartoDB.Positron') %>% 
  
  addHeatmap(aa02_row, lng = aa02_row$long, lat = aa02_row$lat, intensity = aa02_row$super_dust, blur=100, radius =30, max =200, gradient= palette222)  %>%  
  addHeatmap(aa02, lng = aa02$long, lat = aa02$lat, intensity = aa02$super_dust, blur=30, radius =24, max =70)  %>%
  
  
  addCircleMarkers(data = stat_sdot  %>% filter(super_dust >=0, super_dust <=15, month ==2), lat = ~lat, lng = ~long,
                   fillColor = ~beatCol(BeatHomeLvl), popup = stat_sdot$super_dust,
                   radius = ~sqrt(super_dust/4),  stroke = FALSE, fillOpacity = 0.1, color = "black", weight =0.3) %>% 
  
  addCircleMarkers(data = stat_sdot  %>% filter(super_dust >=16, super_dust <=35, month ==2), lat = ~lat, lng = ~long,
                   fillColor = ~beatCol(BeatHomeLvl), popup = stat_sdot$super_dust,
                   radius = ~sqrt(super_dust/4),  stroke = FALSE, fillOpacity = 0.1, color = "black", weight =0.3) %>% 
  
  addCircleMarkers(data = stat_sdot  %>% filter(super_dust >=36, month ==2), lat = ~lat, lng = ~long,
                   fillColor = ~beatCol(BeatHomeLvl), popup = stat_sdot$super_dust,
                   radius = ~sqrt(super_dust/2),  stroke = TRUE, fillOpacity = 0.8, color = "black", weight =1) %>% 
  addPopups(126.8695, 37.649, content,
            options = popupOptions(closeButton = FALSE)) %>%
  addLegendCustom("bottomright", 
                  colors =c("#3982BA", "#66B74F", "#FAE284", "#E93A30"),
                  labels= c("좋음 : 0 ~ 15㎍/㎥", "보통 : 16 ~ 35㎍/㎥","나쁨 : 36 ~ 75㎍/㎥","매우나쁨 : 76㎍/㎥ 이상"),
                  sizes = c(10, 12, 13,15), 
                  opacity = 1,
                  title= "초미세먼지(PM2.5) 기준 등급")

  #2019년 3월 트래픽 보정 미세먼지 히트맵 버전 
tr03<- traffic_mean %>% filter(month =="03")


set<-stat_sdot %>% filter(month =="3") %>% group_by(address) %>% summarise(dust = mean(dust), super_dust = mean(super_dust))

a<-set %>% filter(dust >=0, dust <=30.999999) %>% nrow()
b<-set %>% filter(dust >=31, dust <=80.999999) %>% nrow()
c<-set %>% filter(dust >=81, dust <=150.99999) %>% nrow()
d<-set %>% filter(dust >=151) %>% nrow()

e<-set %>%  filter(super_dust >=0, super_dust <=15.99999999) %>% nrow()
f<-set %>%  filter(super_dust >=16, super_dust <=35.999999999) %>% nrow()
g<-set %>%  filter(super_dust >=36, super_dust <=75.999999999) %>% nrow()
h<-set %>%  filter(super_dust >=76) %>% nrow()

content <- paste0(
  "   나쁨 : ",c,"개, 매우나쁨 : ",d,"개"
)



#히트맵 있는거
leaflet(data_polys) %>%
  setView(lng=126.9784, lat=37.566, zoom=11) %>%
  addPolygons(fillColor = "white",weight ="2",color = "black", opacity = 0.8  ) %>% 
  addProviderTiles('CartoDB.Positron') %>% 
  
  addCircleMarkers(data = stat_sdot  %>% filter(dust >=81, month ==4), lat = ~lat, lng = ~long,
                   fillColor = ~beatCol_dust(BeatHomeLvl_dust), popup = stat_sdot$dust,
                   radius = ~sqrt(dust/2),  stroke = TRUE, fillOpacity = 0.8, color = "black", weight =1.2) %>% 
  
  addCircleMarkers(data = stat_sdot  %>% filter(dust >=0, dust <=30, month ==4), lat = ~lat, lng = ~long,
                   fillColor = ~beatCol_dust(BeatHomeLvl_dust), popup = stat_sdot$dust,
                   radius = ~sqrt(dust/3),  stroke = FALSE, fillOpacity = 0.1, color = "black", weight =0.3) %>% 
  
  addCircleMarkers(data = stat_sdot  %>% filter(dust >=31, dust <=80, month ==4), lat = ~lat, lng = ~long,
                   fillColor = ~beatCol_dust(BeatHomeLvl_dust), popup = stat_sdot$dust,
                   radius = ~sqrt(dust/3),  stroke = FALSE, fillOpacity = 0.1, color = "black", weight =0.3) %>%
  
  
  addHeatmap(tr03, lng = tr03$long, lat = tr03$lat, intensity = tr03$mean, blur=40, radius =34, max= 5000)   %>% 
  addPopups(126.8695, 37.649, content,
            options = popupOptions(closeButton = FALSE)) %>% 
  addLegendCustom("bottomright", 
                  colors =c("#3982BA", "#66B74F", "#FAE284", "#E93A30"),
                  labels= c("좋음 : 0 ~ 30㎍/㎥", "보통 : 31 ~ 80㎍/㎥","나쁨 : 81 ~ 150㎍/㎥","매우나쁨 : 151㎍/㎥ 이상"),
                  sizes = c(10, 12, 13,15), 
                  opacity = 1,
                  title= "미세먼지(PM10) 기준 등급") %>% 

  addLegend("bottomright", 
            colors =c("#3982BA","#1CFF77", "#66B74F", "#FAE284", "#E93A30"),
            labels= c("0 ~ 2000대", "2000 ~ 3000대","3000 ~ 4000대","4000 ~ 5000대","5000대 이상"),
            title= "주요지점 교통량",
            opacity = 1)


aa03 <- stat_sdot %>% filter(dust >=81, month ==3)
aa03_row <- stat_sdot %>% filter(dust <=80, month ==3)

#히트맵 없는거
leaflet(data_polys) %>%
  setView(lng=126.9784, lat=37.566, zoom=11) %>%
  addPolygons(fillColor = "white",weight ="2",color = "black", opacity = 0.8  ) %>% 
  addProviderTiles('CartoDB.Positron') %>% 
  
  addHeatmap(aa03_row, lng = aa03_row$long, lat = aa03_row$lat, intensity = aa03_row$dust, blur=100, radius =30, max =200, gradient= palette222) %>%  
  addHeatmap(aa03, lng = aa03$long, lat = aa03$lat, intensity = aa03$dust, blur=40, radius =24, max =60) %>%
  
  addCircleMarkers(data = stat_sdot  %>% filter(dust >=81, month ==4), lat = ~lat, lng = ~long,
                   fillColor = ~beatCol_dust(BeatHomeLvl_dust), popup = stat_sdot$dust,
                   radius = ~sqrt(dust/2),  stroke = TRUE, fillOpacity = 0.8, color = "black", weight =1.2) %>% 
  
  addCircleMarkers(data = stat_sdot  %>% filter(dust >=0, dust <=30, month ==4), lat = ~lat, lng = ~long,
                   fillColor = ~beatCol_dust(BeatHomeLvl_dust), popup = stat_sdot$dust,
                   radius = ~sqrt(dust/3),  stroke = FALSE, fillOpacity = 0.1, color = "black", weight =0.3) %>% 
  
  addCircleMarkers(data = stat_sdot  %>% filter(dust >=31, dust <=80, month ==4), lat = ~lat, lng = ~long,
                   fillColor = ~beatCol_dust(BeatHomeLvl_dust), popup = stat_sdot$dust,
                   radius = ~sqrt(dust/3),  stroke = FALSE, fillOpacity = 0.1, color = "black", weight =0.3) %>%
  
  
  addPopups(126.8695, 37.649, content,
            options = popupOptions(closeButton = FALSE)) %>% 
  addLegendCustom("bottomright", 
                  colors =c("#3982BA", "#66B74F", "#FAE284", "#E93A30"),
                  labels= c("좋음 : 0 ~ 30㎍/㎥", "보통 : 31 ~ 80㎍/㎥","나쁨 : 81 ~ 150㎍/㎥","매우나쁨 : 151㎍/㎥ 이상"),
                  sizes = c(10, 12, 13,15), 
                  opacity = 1,
                  title= "미세먼지(PM10) 기준 등급")



#2020년 3월 트래픽 보정 초미세먼지 히트맵 버전 
tr03<- traffic_mean %>% filter(month =="03")
content <- paste0(
  " 나쁨 : ",g,"개, 매우나쁨 : ",h,"개"
)




leaflet(data_polys) %>%
  setView(lng=126.9784, lat=37.566, zoom=11) %>%
  addPolygons(fillColor = "white",weight ="2",color = "black", opacity = 0.8  ) %>% 
  addProviderTiles('CartoDB.Positron') %>% 
  
  addCircleMarkers(data = stat_sdot  %>% filter(super_dust >=0, super_dust <=15, month ==4), lat = ~lat, lng = ~long,
                   fillColor = ~beatCol(BeatHomeLvl), popup = stat_sdot$super_dust,
                   radius = ~sqrt(super_dust/4),  stroke = FALSE, fillOpacity = 0.1, color = "black", weight =0.3) %>% 
  
  addCircleMarkers(data = stat_sdot  %>% filter(super_dust >=16, super_dust <=35, month ==4), lat = ~lat, lng = ~long,
                   fillColor = ~beatCol(BeatHomeLvl), popup = stat_sdot$super_dust,
                   radius = ~sqrt(super_dust/4),  stroke = FALSE, fillOpacity = 0.1, color = "black", weight =0.3) %>% 
  
  addCircleMarkers(data = stat_sdot  %>% filter(super_dust >=36, month ==4), lat = ~lat, lng = ~long,
                   fillColor = ~beatCol(BeatHomeLvl), popup = stat_sdot$super_dust,
                   radius = ~sqrt(super_dust/2),  stroke = TRUE, fillOpacity = 0.8, color = "black", weight =1) %>% 
  
  
  addHeatmap(tr03, lng = tr03$long, lat = tr03$lat, intensity = tr03$mean, blur=40, radius =33, max= 5000)   %>% 
  addPopups(126.8695, 37.649, content,
            options = popupOptions(closeButton = FALSE)) %>% 
  addLegendCustom("bottomright", 
                  colors =c("#3982BA", "#66B74F", "#FAE284", "#E93A30"),
                  labels= c("좋음 : 0 ~ 15㎍/㎥", "보통 : 16 ~ 35㎍/㎥","나쁨 : 36 ~ 75㎍/㎥","매우나쁨 : 76㎍/㎥ 이상"),
                  sizes = c(10, 12, 13,15), 
                  opacity = 1,
                  title= "초미세먼지(PM2.5) 기준 등급") %>% 
  
  addLegend("bottomright", 
            colors =c("#3982BA","#1CFF77", "#66B74F", "#FAE284", "#E93A30"),
            labels= c("0 ~ 2000대", "2000 ~ 3000대","3000 ~ 4000대","4000 ~ 5000대","5000대 이상"),
            title= "주요지점 교통량",
            opacity = 1)

aa03 <- stat_sdot %>% filter(super_dust >=36, month ==3)
aa03_row <- stat_sdot %>% filter(super_dust <=36, month ==3)


leaflet(data_polys) %>%
  setView(lng=126.9784, lat=37.566, zoom=11) %>%
  addPolygons(fillColor = "white",weight ="2",color = "black", opacity = 0.8  ) %>% 
  addProviderTiles('CartoDB.Positron') %>% 
  
  addHeatmap(aa03_row, lng = aa03_row$long, lat = aa03_row$lat, intensity = aa03_row$super_dust, blur=100, radius =30, max =200, gradient= palette222)  %>%  
  addHeatmap(aa03, lng = aa03$long, lat = aa03$lat, intensity = aa03$super_dust, blur=30, radius =24, max =70)  %>%
  
  addCircleMarkers(data = stat_sdot  %>% filter(super_dust >=0, super_dust <=15, month ==4), lat = ~lat, lng = ~long,
                   fillColor = ~beatCol(BeatHomeLvl), popup = stat_sdot$super_dust,
                   radius = ~sqrt(super_dust/4),  stroke = FALSE, fillOpacity = 0.1, color = "black", weight =0.3) %>% 
  
  addCircleMarkers(data = stat_sdot  %>% filter(super_dust >=16, super_dust <=35, month ==4), lat = ~lat, lng = ~long,
                   fillColor = ~beatCol(BeatHomeLvl), popup = stat_sdot$super_dust,
                   radius = ~sqrt(super_dust/4),  stroke = FALSE, fillOpacity = 0.1, color = "black", weight =0.3) %>% 
  
  addCircleMarkers(data = stat_sdot  %>% filter(super_dust >=36, month ==4), lat = ~lat, lng = ~long,
                   fillColor = ~beatCol(BeatHomeLvl), popup = stat_sdot$super_dust,
                   radius = ~sqrt(super_dust/2),  stroke = TRUE, fillOpacity = 0.8, color = "black", weight =1) %>% 
  
  addPopups(126.8695, 37.649, content,
            options = popupOptions(closeButton = FALSE)) %>% 
  addLegendCustom("bottomright", 
                  colors =c("#3982BA", "#66B74F", "#FAE284", "#E93A30"),
                  labels= c("좋음 : 0 ~ 15㎍/㎥", "보통 : 16 ~ 35㎍/㎥","나쁨 : 36 ~ 75㎍/㎥","매우나쁨 : 76㎍/㎥ 이상"),
                  sizes = c(10, 12, 13,15), 
                  opacity = 1,
                  title= "초미세먼지(PM2.5) 기준 등급") 




###################444444444444444444444

#2020년 4월 트래픽 보정 미세먼지 히트맵 버전 
tr04<- traffic_mean %>% filter(month =="04")


set<-stat_sdot %>% filter(month =="4") %>% group_by(address) %>% summarise(dust = mean(dust), super_dust = mean(super_dust))

a<-set %>% filter(dust >=0, dust <=30.999999) %>% nrow()
b<-set %>% filter(dust >=31, dust <=80.999999) %>% nrow()
c<-set %>% filter(dust >=81, dust <=150.99999) %>% nrow()
d<-set %>% filter(dust >=151) %>% nrow()

e<-set %>%  filter(super_dust >=0, super_dust <=15.99999999) %>% nrow()
f<-set %>%  filter(super_dust >=16, super_dust <=35.999999999) %>% nrow()
g<-set %>%  filter(super_dust >=36, super_dust <=75.999999999) %>% nrow()
h<-set %>%  filter(super_dust >=76) %>% nrow()

content <- paste0(
  "   나쁨 : ",c,"개, 매우나쁨 : ",d,"개"
)

#히트맵 있는거
leaflet(data_polys) %>%
  setView(lng=126.9784, lat=37.566, zoom=11) %>%
  addPolygons(fillColor = "white",weight ="2",color = "black", opacity = 0.8  ) %>% 
  addProviderTiles('CartoDB.Positron') %>% 
  
  addCircleMarkers(data = stat_sdot  %>% filter(dust >=81, month ==4), lat = ~lat, lng = ~long,
                   fillColor = ~beatCol_dust(BeatHomeLvl_dust), popup = stat_sdot$dust,
                   radius = ~sqrt(dust/2),  stroke = TRUE, fillOpacity = 0.8, color = "black", weight =1.2) %>% 
  
  addCircleMarkers(data = stat_sdot  %>% filter(dust >=0, dust <=30, month ==4), lat = ~lat, lng = ~long,
                   fillColor = ~beatCol_dust(BeatHomeLvl_dust), popup = stat_sdot$dust,
                   radius = ~sqrt(dust/3),  stroke = FALSE, fillOpacity = 0.1, color = "black", weight =0.3) %>% 
  
  addCircleMarkers(data = stat_sdot  %>% filter(dust >=31, dust <=80, month ==4), lat = ~lat, lng = ~long,
                   fillColor = ~beatCol_dust(BeatHomeLvl_dust), popup = stat_sdot$dust,
                   radius = ~sqrt(dust/3),  stroke = FALSE, fillOpacity = 0.1, color = "black", weight =0.3) %>%
  
  
  addHeatmap(tr03, lng = tr03$long, lat = tr03$lat, intensity = tr03$mean, blur=40, radius =34, max= 5000)   %>% 
  addPopups(126.8695, 37.649, content,
            options = popupOptions(closeButton = FALSE)) %>% 
  addLegendCustom("bottomright", 
                  colors =c("#3982BA", "#66B74F", "#FAE284", "#E93A30"),
                  labels= c("좋음 : 0 ~ 30㎍/㎥", "보통 : 31 ~ 80㎍/㎥","나쁨 : 81 ~ 150㎍/㎥","매우나쁨 : 151㎍/㎥ 이상"),
                  sizes = c(10, 12, 13,15), 
                  opacity = 1,
                  title= "미세먼지(PM10) 기준 등급") %>% 
  
  addLegend("bottomright", 
            colors =c("#3982BA","#1CFF77", "#66B74F", "#FAE284", "#E93A30"),
            labels= c("0 ~ 2000대", "2000 ~ 3000대","3000 ~ 4000대","4000 ~ 5000대","5000대 이상"),
            title= "주요지점 교통량",
            opacity = 1)


aa04 <- stat_sdot %>% filter(dust >=81, month ==4)
aa04_row <- stat_sdot %>% filter(dust <=80, month ==4)

#히트맵 없는거
leaflet(data_polys) %>%
  setView(lng=126.9784, lat=37.566, zoom=11) %>%
  addPolygons(fillColor = "white",weight ="2",color = "black", opacity = 0.8  ) %>% 
  addProviderTiles('CartoDB.Positron') %>% 
  
  addHeatmap(aa04_row, lng = aa04_row$long, lat = aa04_row$lat, intensity = aa04_row$dust, blur=100, radius =30, max =200, gradient= palette222) %>%  
  addHeatmap(aa04, lng = aa04$long, lat = aa04$lat, intensity = aa04$dust, blur=40, radius =24, max =60) %>%
  
  addCircleMarkers(data = stat_sdot  %>% filter(dust >=81, month ==4), lat = ~lat, lng = ~long,
                   fillColor = ~beatCol_dust(BeatHomeLvl_dust), popup = stat_sdot$dust,
                   radius = ~sqrt(dust/2),  stroke = TRUE, fillOpacity = 0.8, color = "black", weight =1.2) %>% 
  
  addCircleMarkers(data = stat_sdot  %>% filter(dust >=0, dust <=30, month ==4), lat = ~lat, lng = ~long,
                   fillColor = ~beatCol_dust(BeatHomeLvl_dust), popup = stat_sdot$dust,
                   radius = ~sqrt(dust/3),  stroke = FALSE, fillOpacity = 0.1, color = "black", weight =0.3) %>% 
  
  addCircleMarkers(data = stat_sdot  %>% filter(dust >=31, dust <=80, month ==4), lat = ~lat, lng = ~long,
                   fillColor = ~beatCol_dust(BeatHomeLvl_dust), popup = stat_sdot$dust,
                   radius = ~sqrt(dust/3),  stroke = FALSE, fillOpacity = 0.1, color = "black", weight =0.3) %>%
  
  
  addPopups(126.8695, 37.649, content,
            options = popupOptions(closeButton = FALSE)) %>% 
  addLegendCustom("bottomright", 
                  colors =c("#3982BA", "#66B74F", "#FAE284", "#E93A30"),
                  labels= c("좋음 : 0 ~ 30㎍/㎥", "보통 : 31 ~ 80㎍/㎥","나쁨 : 81 ~ 150㎍/㎥","매우나쁨 : 151㎍/㎥ 이상"),
                  sizes = c(10, 12, 13,15), 
                  opacity = 1,
                  title= "미세먼지(PM10) 기준 등급")



#2020년 4월 트래픽 보정 초미세먼지 히트맵 버전 
tr03<- traffic_mean %>% filter(month =="03")
content <- paste0(
  " 나쁨 : ",g,"개, 매우나쁨 : ",h,"개"
)


leaflet(data_polys) %>%
  setView(lng=126.9784, lat=37.566, zoom=11) %>%
  addPolygons(fillColor = "white",weight ="2",color = "black", opacity = 0.8  ) %>% 
  addProviderTiles('CartoDB.Positron') %>% 
  
  addCircleMarkers(data = stat_sdot  %>% filter(super_dust >=0, super_dust <=15, month ==4), lat = ~lat, lng = ~long,
                   fillColor = ~beatCol(BeatHomeLvl), popup = stat_sdot$super_dust,
                   radius = ~sqrt(super_dust/4),  stroke = FALSE, fillOpacity = 0.1, color = "black", weight =0.3) %>% 
  
  addCircleMarkers(data = stat_sdot  %>% filter(super_dust >=16, super_dust <=35, month ==4), lat = ~lat, lng = ~long,
                   fillColor = ~beatCol(BeatHomeLvl), popup = stat_sdot$super_dust,
                   radius = ~sqrt(super_dust/4),  stroke = FALSE, fillOpacity = 0.1, color = "black", weight =0.3) %>% 
  
  addCircleMarkers(data = stat_sdot  %>% filter(super_dust >=36, month ==4), lat = ~lat, lng = ~long,
                   fillColor = ~beatCol(BeatHomeLvl), popup = stat_sdot$super_dust,
                   radius = ~sqrt(super_dust/2),  stroke = TRUE, fillOpacity = 0.8, color = "black", weight =1) %>% 
  
  
  addHeatmap(tr03, lng = tr03$long, lat = tr03$lat, intensity = tr03$mean, blur=40, radius =33, max= 5000)   %>% 
  addPopups(126.8695, 37.649, content,
            options = popupOptions(closeButton = FALSE)) %>% 
  addLegendCustom("bottomright", 
                  colors =c("#3982BA", "#66B74F", "#FAE284", "#E93A30"),
                  labels= c("좋음 : 0 ~ 15㎍/㎥", "보통 : 16 ~ 35㎍/㎥","나쁨 : 36 ~ 75㎍/㎥","매우나쁨 : 76㎍/㎥ 이상"),
                  sizes = c(10, 12, 13,15), 
                  opacity = 1,
                  title= "초미세먼지(PM2.5) 기준 등급") %>% 
  
  addLegend("bottomright", 
            colors =c("#3982BA","#1CFF77", "#66B74F", "#FAE284", "#E93A30"),
            labels= c("0 ~ 2000대", "2000 ~ 3000대","3000 ~ 4000대","4000 ~ 5000대","5000대 이상"),
            title= "주요지점 교통량",
            opacity = 1)

aa04 <- stat_sdot %>% filter(super_dust >=36, month ==4)
aa04_row <- stat_sdot %>% filter(super_dust <=36, month ==4)



leaflet(data_polys) %>%
  setView(lng=126.9784, lat=37.566, zoom=11) %>%
  addPolygons(fillColor = "white",weight ="2",color = "black", opacity = 0.8  ) %>% 
  addProviderTiles('CartoDB.Positron') %>% 
  
  addHeatmap(aa04_row, lng = aa04_row$long, lat = aa04_row$lat, intensity = aa04_row$super_dust, blur=100, radius =30, max =200, gradient= palette222)  %>%  
  addHeatmap(aa04, lng = aa04$long, lat = aa04$lat, intensity = aa04$super_dust, blur=30, radius =24, max =70)  %>%
  
  
  addCircleMarkers(data = stat_sdot  %>% filter(super_dust >=0, super_dust <=15, month ==4), lat = ~lat, lng = ~long,
                   fillColor = ~beatCol(BeatHomeLvl), popup = stat_sdot$super_dust,
                   radius = ~sqrt(super_dust/2),  stroke = FALSE, fillOpacity = 0.1, color = "black", weight =0.3) %>% 
  
  addCircleMarkers(data = stat_sdot  %>% filter(super_dust >=16, super_dust <=35, month ==4), lat = ~lat, lng = ~long,
                   fillColor = ~beatCol(BeatHomeLvl), popup = stat_sdot$super_dust,
                   radius = ~sqrt(super_dust/2),  stroke = FALSE, fillOpacity = 0.1, color = "black", weight =0.3) %>% 
  
  addCircleMarkers(data = stat_sdot  %>% filter(super_dust >=36, month ==4), lat = ~lat, lng = ~long,
                   fillColor = ~beatCol(BeatHomeLvl), popup = stat_sdot$super_dust,
                   radius = ~sqrt(super_dust/2),  stroke = TRUE, fillOpacity = 0.8, color = "black", weight =1) %>% 
  
  addPopups(126.8695, 37.649, content,
            options = popupOptions(closeButton = FALSE)) %>% 
  addLegendCustom("bottomright", 
                  colors =c("#3982BA", "#66B74F", "#FAE284", "#E93A30"),
                  labels= c("좋음 : 0 ~ 15㎍/㎥", "보통 : 16 ~ 35㎍/㎥","나쁨 : 36 ~ 75㎍/㎥","매우나쁨 : 76㎍/㎥ 이상"),
                  sizes = c(10, 12, 13,15), 
                  opacity = 1,
                  title= "초미세먼지(PM2.5) 기준 등급") 



#####################33555555555555555555555555555555555


#2019년 5월 트래픽 보정 미세먼지 히트맵 버전 
tr05<- traffic_mean %>% filter(month =="05")


set<-stat_sdot %>% filter(month =="5") %>% group_by(address) %>% summarise(dust = mean(dust), super_dust = mean(super_dust))

a<-set %>% filter(dust >=0, dust <=30.999999) %>% nrow()
b<-set %>% filter(dust >=31, dust <=80.999999) %>% nrow()
c<-set %>% filter(dust >=81, dust <=150.99999) %>% nrow()
d<-set %>% filter(dust >=151) %>% nrow()

e<-set %>%  filter(super_dust >=0, super_dust <=15.99999999) %>% nrow()
f<-set %>%  filter(super_dust >=16, super_dust <=35.999999999) %>% nrow()
g<-set %>%  filter(super_dust >=36, super_dust <=75.999999999) %>% nrow()
h<-set %>%  filter(super_dust >=76) %>% nrow()

content <- paste0(
  "   나쁨 : ",c,"개, 매우나쁨 : ",d,"개"
)


#히트맵 있는거
leaflet(data_polys) %>%
  setView(lng=126.9784, lat=37.566, zoom=11) %>%
  addPolygons(fillColor = "white",weight ="2",color = "black", opacity = 0.8  ) %>% 
  addProviderTiles('CartoDB.Positron') %>% 
  
  addCircleMarkers(data = stat_sdot  %>% filter(dust >=81, month ==5), lat = ~lat, lng = ~long,
                   fillColor = ~beatCol_dust(BeatHomeLvl_dust), popup = stat_sdot$dust,
                   radius = ~sqrt(dust/2),  stroke = TRUE, fillOpacity = 0.8, color = "black", weight =1.2) %>% 
  
  addCircleMarkers(data = stat_sdot  %>% filter(dust >=0, dust <=30, month ==5), lat = ~lat, lng = ~long,
                   fillColor = ~beatCol_dust(BeatHomeLvl_dust), popup = stat_sdot$dust,
                   radius = ~sqrt(dust/3),  stroke = FALSE, fillOpacity = 0.1, color = "black", weight =0.3) %>% 
  
  addCircleMarkers(data = stat_sdot  %>% filter(dust >=31, dust <=80, month ==5), lat = ~lat, lng = ~long,
                   fillColor = ~beatCol_dust(BeatHomeLvl_dust), popup = stat_sdot$dust,
                   radius = ~sqrt(dust/3),  stroke = FALSE, fillOpacity = 0.1, color = "black", weight =0.3) %>%
  
  
  addHeatmap(tr03, lng = tr03$long, lat = tr03$lat, intensity = tr03$mean, blur=40, radius =34, max= 5000)   %>% 
  addPopups(126.8695, 37.649, content,
            options = popupOptions(closeButton = FALSE)) %>% 
  addLegendCustom("bottomright", 
                  colors =c("#3982BA", "#66B74F", "#FAE284", "#E93A30"),
                  labels= c("좋음 : 0 ~ 30㎍/㎥", "보통 : 31 ~ 80㎍/㎥","나쁨 : 81 ~ 150㎍/㎥","매우나쁨 : 151㎍/㎥ 이상"),
                  sizes = c(10, 12, 13,15), 
                  opacity = 1,
                  title= "미세먼지(PM10) 기준 등급") %>% 
  
  addLegend("bottomright", 
            colors =c("#3982BA","#1CFF77", "#66B74F", "#FAE284", "#E93A30"),
            labels= c("0 ~ 2000대", "2000 ~ 3000대","3000 ~ 4000대","4000 ~ 5000대","5000대 이상"),
            title= "주요지점 교통량",
            opacity = 1)


aa05 <- stat_sdot %>% filter(dust >=81, month ==5)
aa05_row <- stat_sdot %>% filter(dust <=80, month ==5)

#히트맵 없는거
leaflet(data_polys) %>%
  setView(lng=126.9784, lat=37.566, zoom=11) %>%
  addPolygons(fillColor = "white",weight ="2",color = "black", opacity = 0.8  ) %>% 
  addProviderTiles('CartoDB.Positron') %>% 
  
  addHeatmap(aa05_row, lng = aa05_row$long, lat = aa05_row$lat, intensity = aa05_row$dust, blur=80, radius =30, max =200, gradient= palette222) %>%  
  addHeatmap(aa05, lng = aa05$long, lat = aa05$lat, intensity = aa05$dust, blur=40, radius =24, max =60) %>%
  
  addCircleMarkers(data = stat_sdot  %>% filter(dust >=81, month ==5), lat = ~lat, lng = ~long,
                   fillColor = ~beatCol_dust(BeatHomeLvl_dust), popup = stat_sdot$dust,
                   radius = ~sqrt(dust/2),  stroke = TRUE, fillOpacity = 0.8, color = "black", weight =1.2) %>% 
  
  addCircleMarkers(data = stat_sdot  %>% filter(dust >=0, dust <=30, month ==5), lat = ~lat, lng = ~long,
                   fillColor = ~beatCol_dust(BeatHomeLvl_dust), popup = stat_sdot$dust,
                   radius = ~sqrt(dust/3),  stroke = FALSE, fillOpacity = 0.1, color = "black", weight =0.3) %>% 
  
  addCircleMarkers(data = stat_sdot  %>% filter(dust >=31, dust <=80, month ==5), lat = ~lat, lng = ~long,
                   fillColor = ~beatCol_dust(BeatHomeLvl_dust), popup = stat_sdot$dust,
                   radius = ~sqrt(dust/3),  stroke = FALSE, fillOpacity = 0.1, color = "black", weight =0.3) %>%
  
  
  addPopups(126.8695, 37.649, content,
            options = popupOptions(closeButton = FALSE)) %>% 
  addLegendCustom("bottomright", 
                  colors =c("#3982BA", "#66B74F", "#FAE284", "#E93A30"),
                  labels= c("좋음 : 0 ~ 30㎍/㎥", "보통 : 31 ~ 80㎍/㎥","나쁨 : 81 ~ 150㎍/㎥","매우나쁨 : 151㎍/㎥ 이상"),
                  sizes = c(10, 12, 13,15), 
                  opacity = 1,
                  title= "미세먼지(PM10) 기준 등급")



#2020년 5월 트래픽 보정 초미세먼지 히트맵 버전 
tr05<- traffic_mean %>% filter(month =="05")
content <- paste0(
  " 나쁨 : ",g,"개, 매우나쁨 : ",h,"개"
)




leaflet(data_polys) %>%
  setView(lng=126.9784, lat=37.566, zoom=11) %>%
  addPolygons(fillColor = "white",weight ="2",color = "black", opacity = 0.8  ) %>% 
  addProviderTiles('CartoDB.Positron') %>% 
  
  addCircleMarkers(data = stat_sdot  %>% filter(super_dust >=0, super_dust <=15, month ==5), lat = ~lat, lng = ~long,
                   fillColor = ~beatCol(BeatHomeLvl), popup = stat_sdot$super_dust,
                   radius = ~sqrt(super_dust/4),  stroke = FALSE, fillOpacity = 0.1, color = "black", weight =0.3) %>% 
  
  addCircleMarkers(data = stat_sdot  %>% filter(super_dust >=16, super_dust <=35, month ==5), lat = ~lat, lng = ~long,
                   fillColor = ~beatCol(BeatHomeLvl), popup = stat_sdot$super_dust,
                   radius = ~sqrt(super_dust/4),  stroke = FALSE, fillOpacity = 0.1, color = "black", weight =0.3) %>% 
  
  addCircleMarkers(data = stat_sdot  %>% filter(super_dust >=36, month ==5), lat = ~lat, lng = ~long,
                   fillColor = ~beatCol(BeatHomeLvl), popup = stat_sdot$super_dust,
                   radius = ~sqrt(super_dust/2),  stroke = TRUE, fillOpacity = 0.8, color = "black", weight =1) %>% 
  
  
  addHeatmap(tr03, lng = tr03$long, lat = tr03$lat, intensity = tr03$mean, blur=40, radius =33, max= 5000)   %>% 
  addPopups(126.8695, 37.649, content,
            options = popupOptions(closeButton = FALSE)) %>% 
  addLegendCustom("bottomright", 
                  colors =c("#3982BA", "#66B74F", "#FAE284", "#E93A30"),
                  labels= c("좋음 : 0 ~ 15㎍/㎥", "보통 : 16 ~ 35㎍/㎥","나쁨 : 36 ~ 75㎍/㎥","매우나쁨 : 76㎍/㎥ 이상"),
                  sizes = c(10, 12, 13,15), 
                  opacity = 1,
                  title= "초미세먼지(PM2.5) 기준 등급") %>% 
  
  addLegend("bottomright", 
            colors =c("#3982BA","#1CFF77", "#66B74F", "#FAE284", "#E93A30"),
            labels= c("0 ~ 2000대", "2000 ~ 3000대","3000 ~ 4000대","4000 ~ 5000대","5000대 이상"),
            title= "주요지점 교통량",
            opacity = 1)

aa05 <- stat_sdot %>% filter(super_dust >=36, month ==5)
aa05_row <- stat_sdot %>% filter(super_dust <=36, month ==5)

leaflet(data_polys) %>%
  setView(lng=126.9784, lat=37.566, zoom=11) %>%
  addPolygons(fillColor = "white",weight ="2",color = "black", opacity = 0.8  ) %>% 
  addProviderTiles('CartoDB.Positron') %>% 
  
  addHeatmap(aa05_row, lng = aa05_row$long, lat = aa05_row$lat, intensity = aa05_row$super_dust, blur=80, radius =30, max =200, gradient= palette222) %>%  
  addHeatmap(aa05, lng = aa05$long, lat = aa05$lat, intensity = aa05$super_dust, blur=30, radius =24, max =70) %>%
  
  addCircleMarkers(data = stat_sdot  %>% filter(super_dust >=0, super_dust <=15, month ==5), lat = ~lat, lng = ~long,
                   fillColor = ~beatCol(BeatHomeLvl), popup = stat_sdot$super_dust,
                   radius = ~sqrt(super_dust/1),  stroke = FALSE, fillOpacity = 0.1, color = "black", weight =0.3) %>% 
  
  addCircleMarkers(data = stat_sdot  %>% filter(super_dust >=16, super_dust <=35, month ==5), lat = ~lat, lng = ~long,
                   fillColor = ~beatCol(BeatHomeLvl), popup = stat_sdot$super_dust,
                   radius = ~sqrt(super_dust/2),  stroke = FALSE, fillOpacity = 0.1, color = "black", weight =0.3) %>% 
  
  addCircleMarkers(data = stat_sdot  %>% filter(super_dust >=36, month ==5), lat = ~lat, lng = ~long,
                   fillColor = ~beatCol(BeatHomeLvl), popup = stat_sdot$super_dust,
                   radius = ~sqrt(super_dust/2),  stroke = TRUE, fillOpacity = 0.8, color = "black", weight =1) %>% 
  
  addPopups(126.8695, 37.649, content,
            options = popupOptions(closeButton = FALSE)) %>% 
  addLegendCustom("bottomright", 
                  colors =c("#3982BA", "#66B74F", "#FAE284", "#E93A30"),
                  labels= c("좋음 : 0 ~ 15㎍/㎥", "보통 : 16 ~ 35㎍/㎥","나쁨 : 36 ~ 75㎍/㎥","매우나쁨 : 76㎍/㎥ 이상"),
                  sizes = c(10, 12, 13,15), 
                  opacity = 1,
                  title= "초미세먼지(PM2.5) 기준 등급") 


#한국온도
A <- 30
#화씨온도 변환 
T<-(A*9/5) + 32  
R <- 30

T <-
(-42.379 + (2.04901523*F) + (10.14333127*R)-(0.22475541*F*R)-(0.00683770*F*F)-(0.05481717 * R * R)+(0.00122874 * F * F * R)+(0.00085282 * F * R * R)-(0.00000199 * F * F * R * R))

42.379 + 2.05901523 * T + 10.14333127 * R - 0.22475541 * T * R - 6.83783 * 10^-3 *T^2 - 5.481717 * 10^-2 * R^2 + 1.22874 * 10^-3 *T^2 * R + 8.5282 * 10^-4 * T *R^2 - 1.99 * 10^-6 *T^2 * R^2


T <- 86
R <- 30

-42.379 + 2.05901523 * T + 10.14333127 * R - 0.22475541 * T * R - 6.83783 * 10^-3 *T^2 - 5.481717 * 10^-2 * R^2 + 1.22874 * 10^-3 *T^2 * R + 8.5282 * 10^-4 * T *R^2 - 1.99 * 10^-6 *T^2 * R^2











