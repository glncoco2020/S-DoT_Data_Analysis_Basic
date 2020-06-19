---
title: "README"
output: 
  html_document:
    keep_md: true
---




## GitHub Documents

This is an R Markdown format used for publishing markdown documents to GitHub. When you click the **Knit** button all R code chunks are run and a markdown file (.md) suitable for publishing to GitHub is generated.

## Including Code

You can include R code in the document as follows:


```r
tsv<-read.csv("data/sdot_20200507.csv", fileEncoding = 'euc-kr')
summary(tsv)
```

```
##        X                 시리얼              date            hour      
##  Min.   :    1   V02Q1940043:   24   2020-05-01:20280   Min.   : 0.00  
##  1st Qu.: 5071   V02Q1940044:   24                      1st Qu.: 5.75  
##  Median :10140   V02Q1940045:   24                      Median :11.50  
##  Mean   :10140   V02Q1940046:   24                      Mean   :11.50  
##  3rd Qu.:15210   V02Q1940047:   24                      3rd Qu.:17.25  
##  Max.   :20280   V02Q1940049:   24                      Max.   :23.00  
##                  (Other)    :20136                                     
##  초미세먼지...... 미세먼지......      기온....      상대습도....  
##  Min.   :  0.00   Min.   :  0.00   Min.   :15.24   Min.   :31.57  
##  1st Qu.: 14.10   1st Qu.: 18.82   1st Qu.:19.46   1st Qu.:57.06  
##  Median : 23.69   Median : 31.90   Median :21.21   Median :68.27  
##  Mean   : 23.56   Mean   : 31.75   Mean   :22.02   Mean   :64.78  
##  3rd Qu.: 31.00   3rd Qu.: 41.67   3rd Qu.:24.41   3rd Qu.:72.12  
##  Max.   :175.17   Max.   :268.33   Max.   :34.23   Max.   :85.62  
##                                                                   
##     풍향....         풍속..m.s.      돌풍.풍향....     돌풍.풍속..m.s.  
##  Min.   :  0.000   Min.   :0.00000   Min.   :  0.000   Min.   :0.00000  
##  1st Qu.:  0.000   1st Qu.:0.00000   1st Qu.:  0.000   1st Qu.:0.00000  
##  Median :  0.000   Median :0.00000   Median :  0.000   Median :0.00000  
##  Mean   :  2.363   Mean   :0.01573   Mean   :  2.328   Mean   :0.03093  
##  3rd Qu.:  0.000   3rd Qu.:0.00000   3rd Qu.:  0.000   3rd Qu.:0.00000  
##  Max.   :299.593   Max.   :4.55714   Max.   :295.750   Max.   :8.40714  
##                                                                         
##    조도..lux.        자외선..UVI.       소음..dB.      진동.x...g.     
##  Min.   :    1.00   Min.   :  1.000   Min.   : 0.00   Min.   :0.00000  
##  1st Qu.:    5.12   1st Qu.:  2.000   1st Qu.:45.38   1st Qu.:0.01833  
##  Median : 1296.71   Median :  2.130   Median :48.07   Median :0.02276  
##  Mean   : 6664.73   Mean   :  9.105   Mean   :48.17   Mean   :0.02797  
##  3rd Qu.: 9079.19   3rd Qu.: 10.823   3rd Qu.:50.90   3rd Qu.:0.03500  
##  Max.   :50200.48   Max.   :108.767   Max.   :64.52   Max.   :0.11077  
##                                                                        
##   진동.y...g.       진동.z...g.    진동.x..최대..g.  진동.y..최대..g.
##  Min.   :0.00000   Min.   :0.000   Min.   :0.00000   Min.   :0.0000  
##  1st Qu.:0.02815   1st Qu.:1.006   1st Qu.:0.07241   1st Qu.:0.1163  
##  Median :0.04826   Median :1.029   Median :0.08708   Median :0.1300  
##  Mean   :0.05542   Mean   :1.026   Mean   :0.09167   Mean   :0.1340  
##  3rd Qu.:0.07880   3rd Qu.:1.050   3rd Qu.:0.10088   3rd Qu.:0.1454  
##  Max.   :0.17696   Max.   :1.116   Max.   :2.41815   Max.   :2.0540  
##                                                                      
##  진동.z..최대..g. 흑구.온도....     미세먼지.보정...... 초미세먼지.보정......
##  Min.   : 0.000   Min.   :  4.833   Min.   :-88.12      Min.   :-98.12       
##  1st Qu.: 1.095   1st Qu.:  5.000   1st Qu.: 36.09      1st Qu.: 23.23       
##  Median : 1.107   Median :  5.000   Median : 46.00      Median : 27.76       
##  Mean   : 1.117   Mean   :  7.590   Mean   : 43.68      Mean   : 26.87       
##  3rd Qu.: 1.124   3rd Qu.:  5.000   3rd Qu.: 53.31      3rd Qu.: 32.00       
##  Max.   :10.451   Max.   :195.385   Max.   :345.60      Max.   :179.97       
## 
```

## Including Plots

You can also embed plots, for example:

![](Untitled_files/figure-html/pressure-1.png)<!-- -->

Note that the `echo = FALSE` parameter was added to the code chunk to prevent printing of the R code that generated the plot.
