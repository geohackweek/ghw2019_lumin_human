library(ggplot2)
library(ggregplot)
library(tidyverse)
library(RColorBrewer)
library(maptools)
library(raster)
library(dismo)
library(rpart)
library(randomForest)
library(spgwr)

# host <- read.csv("HouseholdGeovars_Y3.csv", header = T)
# consum <- read.csv("ConsumptionNPS3.csv", header = T) %>% 
#   select(y3_hhid, expm)
# 
# data <- data.frame("N" = 1:4988)
# data$ID <- host$y3_hhid
# data$dist_center <- host$dist02
# data$dist_market <- host$dist03
# data$lon <- host$lon_dd_mod
# data$lat <- host$lat_dd_mod
# 
# 
# data <- left_join(data, consum, by=c("ID" = "y3_hhid")) %>% drop_na()

# head(host)
# head(consum)
# head(data)
# dim(data)

## Prediction of sampled places 

# par(mfrow=c(1,1))
# par(mar=c(4,4,4,4))
# plot(data[,5:6], cex=0.5, col='red')
# ## Checking rgeos availability: TRUE
# # data(wrld_simpl)
# plot(wrld_simpl, add=TRUE)
# 
# wc <- raster::getData('worldclim', res=10, var='bio')
# plot(wc[[2]])

ext_wc <- raster::extract(wc, data[,5:6])
# head(ext_wc)
# dim(ext_wc)

# plot(ext_wc[ ,'bio1'] / 10, ext_wc[, 'bio12'], xlab='Annual mean temperature (C)', ylab='Annual precipitation (mm)')


# extent of all points
e_box <- extent(SpatialPoints(data[,5:6]))

# set.seed(0)
# sample_wc <- sampleRandom(wc, 4000, ext=e_box)
# dim(sample_wc)
# head(sample_wc)

# d <- rbind(cbind(pa=1, ext_wc), cbind(pa=0, sample_wc))
# d <- data.frame(d)
# dim(d)

d_east <- d[data[,5] > 35, ]
d_west <- d[data[,5] <= 35, ]

# ## CART
# cart <- rpart(pa~., data=d_west)
# printcp(cart)
# plotcp(cart)
# plot(cart, uniform=TRUE, main="Regression Tree")
# # text(cart, use.n=TRUE, all=TRUE, cex=.8)
# text(cart, cex=.8, digits=1)

# ## Random Forest
# fpa <- as.factor(d_west[, 'pa'])
# crf <- randomForest(d_west[, 2:ncol(d_west)], fpa)
# plot(crf)
# varImpPlot(crf)
# trf <- tuneRF(d_west[, 2:ncol(d_west)], d_west[, 'pa'])
# 
# mt <- trf[which.min(trf[,2]), 1]
# rrf <- randomForest(d_west[, 2:ncol(d)], d_west[, 'pa'], mtry=mt)
# plot(rrf)
# varImpPlot(rrf)
# 
# ew_box <- extent(SpatialPoints(data[data[,5] <= 35, 5:6]))
# 
# rp <- predict(wc, rrf, ext=ew_box)
# plot(rp)
# plot(wrld_simpl, add=TRUE)
# 
# eva <- evaluate(d_west[d_west$pa==1, ], d_west[d_west$pa==0, ], rrf)
# plot(eva, 'ROC')
# 
# tr <- threshold(eva)
# plot(rp > tr[1, 'spec_sens'])
# 
# rc2 <- predict(wc, crf, ext=ew_box, type='prob', index=2)
# plot(rc2)
# plot(wrld_simpl, add=TRUE)
# 
# d_east <- na.omit(d_east)
# eva2 <- evaluate(d_east[de$pa==1, ], d_east[d_east$pa==0, ], rrf)
# plot(eva2, 'ROC')
# 
# rwhole <- predict(wc, rrf, ext=e_box)
# plot(rwhole)
# plot(wrld_simpl, add=TRUE)
# points(data[, 5:6], cex=.25, col="red")

## Again prediction
# fp <- as.factor(d[, 'pa'])
# crf_w <- randomForest(d[, 2:ncol(d)], fp)
# plot(crf_w)
# varImpPlot(crf_w)
# trf_w <- tuneRF(d[, 2:ncol(d)], d[, 'pa'])
# mt <- trf_w[which.min(trf_w[,2]), 1]
# rrf <- randomForest(d[, 2:ncol(d)], d[, 'pa'], mtry=mt)
# plot(rrf)
# varImpPlot(rrf)

## ROC 
eva <- evaluate(d[d$pa==1, ], d[d$pa==0, ], rrf)
# plot(eva, 'ROC')

# rwhole <- predict(wc, rrf, ext=e_box)
# plot(rwhole)
# plot(wrld_simpl, add=TRUE)
# points(data[, 5:6], cex=.25, col="red")

# ken <- getData('GADM', country='KEN', level=1)
# GADM, the Database of Global Administrative Areas, is a high-resolution database of country administrative areas, with a goal of "all countries, at all levels, at any time period.
# pk <- predict(wc, rrf, ext=ken)
# pk <- mask(pk, ken)
# plot(pk)
# plot(wrld_simpl, add=TRUE)

# fut <- getData('CMIP5', res=10, var='bio', rcp=85, model='AC', year=70)
# # The CMIP  (formally: Coupled Model Intercomparison Project Phase 5) is a standard experimental framework for studying the output of coupled atmosphere-ocean general circulation models. This facilitates assessment of the strengthsand weaknesses of climate models which can enhance and focus the development of future models. For example, if the models indicate a wide range of values either regionally or globally, then scientists may be able to determine the cause(s) of this uncertainty.
# 
# ## Different predictors 
# names(fut) <- names(wc)
# futusa <- predict(fut, rrf, ext=e_box, progress='window')
# plot(futusa)
# plot(wrld_simpl, add=TRUE)


## GWR 
# night <- raster('VIIRS.tif')
# plot(night)
# plot(raster("DMSP_TimeSeries.tif"))

ext_night <- raster::extract(night, data[,5:6])
# length(ext_night)
# data$light <- ext_night
# data$sum_dist <- data$dist_center + data$dist_market

OLS <- lm(expm ~ sum_dist + light, data=data)
# alb <- CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs +towgs84=0,0,0")
# sp <- data %>% drop_na()
# coordinates(sp) = ~ lon + lat
# crs(sp) <- "+proj=longlat +datum=WGS84"
# tan <- wrld_simpl[wrld_simpl@data$NAME == "United Republic of Tanzania",]
# spt <- spTransform(sp, alb)
# ctst <- spTransform(wrld_simpl[wrld_simpl@data$NAME == "United Republic of Tanzania",], alb)
# plot(tan)
# z <- raster(tan, nrow=200, ncol=200)
# z <- mask(z, tan)
# plot(z)
# r <- rasterize(tan, z)
# newpts <- rasterToPoints(r)
# plot(newpts)

# bw <- gwr.sel(expm ~ sum_dist + light, data=sp)
# bw <- 26
# g <- gwr(expm ~ sum_dist + light, data=sp, bandwidth=bw, 
#          fit.points=newpts[, 1:2])

# rv_dist <- r
# n_light <- r
# intercept <- r
# weigh <- r
# rv_dist[!is.na(rv_dist)] <- g$SDF$sum_dist
# n_light[!is.na(n_light)] <- g$SDF$light
# intercept[!is.na(intercept)] <- g$SDF$'(Intercept)'
# weigh[!is.na(weigh)] <- g$SDF$sum.w
# s <- stack(intercept, rv_dist, n_light, weigh)
# names(s) <- c('intercept', 'distant', 'night light', 'weight')
# plot(s)

# save(data, wrld_simpl, wc, d, rrf, rwhole, ken, pk, tan, night, g, s, file = "geo.Rdata")

