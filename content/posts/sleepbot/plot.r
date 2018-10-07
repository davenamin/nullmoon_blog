library(tidyverse)
library(ggplot2)
library(lubridate)

data  <- read.csv("sleep.csv", stringsAsFactors=F)
data$x  <- mdy(data$Date, tz="America/New_York")
data$ymin  <- hm(data$Sleep.Time)
data$ymax  <- hm(data$Wake.Time)
data$ymax  <- ifelse(data$ymin > data$ymax,
                     as.numeric(data$ymax+hours(24)),
                     as.numeric(data$ymax))
data$ymax  <- seconds(data$ymax)

baseline  <- today(tz="America/New_York") + hours(4)
miny  <- as.POSIXct(baseline)
maxy  <- as.POSIXct(baseline + hours(12))
ggplot(data) +
    geom_linerange(
        aes(x=x,
            ymin=baseline+ymin,
            ymax=baseline+ymax)) +
    scale_y_datetime(limits=c(miny, maxy)) +
    scale_x_datetime()
