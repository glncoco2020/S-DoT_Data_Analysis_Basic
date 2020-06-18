
---
title: "README"
output: 
  html_document:
    keep_md: true
---
=======
#S-Dot 데이터분석하기 

```{r setup, include=FALSE}

knitr::opts_chunk$set(echo = TRUE)
```

## GitHub Documents

This is an R Markdown format used for publishing markdown documents to GitHub. When you click the **Knit** button all R code chunks are run and a markdown file (.md) suitable for publishing to GitHub is generated.

## Including Code

You can include R code in the document as follows:

```{r cars}
sdot_20200501<- read.csv("file/ALLDATA_20200501.csv", head = TRUE, fileEncoding = 'euc-kr')
summary(sdot_20200501)
```

## Including Plots

You can also embed plots, for example:

```{r pressure, echo=FALSE}
plot(pressure)
```

Note that the `echo = FALSE` parameter was added to the code chunk to prevent printing of the R code that generated the plot.
