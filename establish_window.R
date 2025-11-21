# loading package
library(tidyr)
library(zoo)
library(ggplot2)
library(raster)
library(viridis)

# Loading summary function
summarySE = function(data=NULL, measurevar, 
                     groupvars=NULL, na.rm=FALSE,
                     conf.interval=.95, .drop=TRUE) {
  library(plyr)
  
  # if na.rm==T, don't count them
  length2 = function (x, na.rm=FALSE) {
    if (na.rm) sum(!is.na(x))
    else length(x)}
  
  # for each group's data frame, return a vector with N, mean, and sd
  datac = ddply(data, groupvars, 
                .drop = .drop,.fun = function(xx, col) {
                  c(N = length2(xx[[col]], na.rm = na.rm),
                    mean = mean(xx[[col]], na.rm = na.rm),
                    sd = sd(xx[[col]], na.rm = na.rm))},
                measurevar)
  
  # rename the "mean" column    
  datac <- rename(datac, c("mean" = measurevar))
  
  # Calculate standard error of the mean
  datac$se <- datac$sd / sqrt(datac$N)  
  
  # calculate t-statistic for confidence interval: 
  ciMult <- qt(conf.interval/2 + .5, datac$N-1)
  datac$ci <- datac$se * ciMult
  
  return(datac)
}

# loading data
df = read.csv('sr_2sp.csv')
df$date = as.POSIXct(as.character(df$date), format = '%Y%m%d')
df$mr = 1- df$sr

df$salinity[df$salinity == '5'] = '5 PSU' 
df$salinity[df$salinity == '10'] = '10 PSU' 
df$salinity[df$salinity == '20'] = '20 PSU' 
df$salinity[df$salinity == '30'] = '30 PSU' 
df$salinity = factor(df$salinity, levels = c('5 PSU', '10 PSU', '20 PSU', '30 PSU'))

df$sp_code = df$species
df$species[df$species == 'CE'] = 'C. edule'
df$species[df$species == 'RP'] = 'R. philippinarum'

# subset 
dfce = df[df$sp_code == 'CE', ]
dfrp = df[df$sp_code == 'RP', ]

# summary
dfce_summ = summarySE(data = dfce, measurevar = 'sr', 
                      groupvars = c('date', 'salinity', 'treatment'),
                      na.rm = T)
dfrp_summ = summarySE(data = dfrp, measurevar = 'sr', 
                      groupvars = c('date', 'salinity', 'treatment'),
                      na.rm = T)

df_summ = summarySE(data = df, measurevar = 'sr', 
                    groupvars = c('species', 'date', 'salinity', 'treatment'),
                    na.rm = T)

df_summ$sp_ht = paste(df_summ$species, df_summ$treatment, sep = '_')

df_neo = df_summ[, c(1,2,3,4,6)] 

df_wide = pivot_wider(df_neo, names_from = "treatment", values_from = "sr")
df_order = df_wide[order(df_wide$species, df_wide$salinity, df_wide$date),]

df_order$C = na.locf(df_order$C)
df_order$H = na.locf(df_order$H)
df_order$Sdiff = df_order$C - df_order$H # optional

# add data categories
plb = c(rep('Phase 1', 5), rep('Phase 2', 5), rep('Phase 3', 5), rep('Phase 4', 5), rep('Phase 5', 5))
df_order$phase = rep(plb, 8)
dsb = paste0('D', 1:25)
df_order$days = rep(dsb, 8)
df_order$days = factor(df_order$days, levels = c(paste0('D', 1:25)))

df_order$salinity = factor(df_order$salinity, levels = c('30 PSU', '20 PSU', '10 PSU', '5 PSU'))

# subset by species
df_odce = df_order[df_order$species == 'C. edule', ]
df_odrp = df_order[df_order$species == 'R. philippinarum', ]

df_odce1 = df_odce[seq(5,100, by = 5),]
df_odrp1 = df_odrp[seq(5,100, by = 5),]

################################# plotting WINDOW #####################################
par(mar = c(5,5,4,4),font.axis = 2)
Lraster = raster(array(NA,dim = c(100,100)))
df_odrp$svDiff = df_odrp$H-df_odce$H
df_Diff = df_odrp
df_Diff = df_Diff[,-c(1, 4:6)]

X3 = tapply(df_Diff$svDiff, list(df_Diff$days, df_Diff$salinity), identity)

X3 = X3[nrow(X3):1, ]
sr3 = raster(X3)
sr31 = resample(sr3, Lraster)
sr31[sr31 > 1] = 1
sr31[sr31 < 0] = 0

#colBW = viridis::turbo(10000)
breakpoints = c(seq(0, 0.7, 0.1), 0.9)
colBW = c(viridis::viridis(10)[3:10], "#FDE725FF")

Phase1 = 53.2
Phase2 = 121.6
Phase3 = 192.6
Phase4 = 276.3
Phase5 = 370.7

r.range = c(minValue(sr31), maxValue(sr31))
png('diff_mRateWINDOW.png',width = 8, height = 6, units='in', res = 300)
plot(sr31, axes = F, box= F, legend=F, col = colBW, breaks = breakpoints, zlim = c(0.0,0.9))########
plot(rasterToPolygons(sr31), add=TRUE, border=adjustcolor("black",alpha.f=0.1) , lwd=1)
axis(side = 1, at = seq(0.125,0.875,length.out = 4), labels = c(30,20,10,5),cex.axis =0.9, pos=-0.01)
axis(side = 2, at = seq(0.1,0.9,length.out = 5), labels = c(Phase1, Phase2, Phase3, Phase4, Phase5),cex.axis =0.9, pos=-0.01)
axis(side = 1, line = 1.5, at = 0.5, labels = 'Salinity stress (PSU)', tick = F, cex.axis = 1.4, pos = -0.08, font = 2)
axis(side = 2, line = 1.5, at = 0.5, labels = 'Accumulated thermal stress (°C)', tick = F, cex.axis = 1.4, pos = -0.1, font = 2)
plot(sr31, axes = F, box= F, col = colBW, breaks = breakpoints, zlim = c(0, 0.9),########
     legend.width=1.5, legend.shrink=1,
     axis.args=list(at=seq(0.0, 0.9, 0.1), ######
                    labels=seq(0.0, 0.9, 0.1), ######
                    cex.axis=0.95, srt = 35),
     legend.args=list(text= expression(bold('Species survival difference')), side=2, font=2, line=1.5, cex=1),
     legend.only=T, horizontal = F)
dev.off()
