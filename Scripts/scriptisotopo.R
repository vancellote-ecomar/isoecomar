# remove previously loaded items from the current environment and remove previous graphics.
rm(list=ls())
graphics.off()

# Here, I set the seed each time so that the results are comparable. 
# This is useful as it means that anyone that runs your code, *should*
# get the same results as you, although random number generators change 
# from time to time.
set.seed(1)

library(SIBER)
library(ggplot2)

setwd("C:/Users/user-1/Área de Trabalho/Vancellote/isotopos")

isot<- read.table("isotopos_estaveisscript.txt", header = T)

isot2 <- data.frame(isot$X13C, isot$X15N, isot$Codigo)
colnames(isot2) <- c("iso1", "iso2", "group")
isot2

community <- rep(1,10)

isoano <- data.frame(isot2[,c(1,2,3)], community)
colnames(isoano) <- c("iso1", "iso2","group","community")
isoano

# create the siber object
siber.example <- createSiberObject(isoano)

siber.example$sample.sizes

# Create lists of plotting arguments to be passed onwards to each 
# of the three plotting functions.

community.hulls.args <- list(palette(c("red","blue")), 
                             lty = 1, lwd = 1)
group.ellipses.args  <- list(n = 100, p.interval = 0.95, lty = 1, lwd = 2)
group.hull.args      <- list(lty = 2, col = "grey20")



par(mfrow=c(1,1))
plotSiberObject(siber.example,
                      ax.pad = 2, 
                      hulls = F, community.hulls.args, 
                      ellipses = T, group.ellipses.args,
                      group.hulls = T, group.hull.args,
                      bty = "L",
                      iso.order = c(1,2),
                      xlab = expression({delta}^13*C~'\u2030'),
                      ylab = expression({delta}^15*N~'\u2030')
)


par(mfrow=c(1,1))

legend("bottomright", c("Common dolphin", "Bottlenose dolphin"),
       fill=c("red","blue"), lty=0, bty="n")


#community.hulls.args <- list(col = 1, lty = 1, lwd = 1)
#group.ellipses.args  <- list(n = 100, p.interval = 0.95, lty = 1, lwd = 2)
#group.hull.args      <- list(lty = 2, col = "grey20")

# this time we will make the points a bit smaller by 
# cex = 0.5
#plotSiberObject(siber.example,
                #ax.pad = 2, 
                #hulls = F, community.hulls.args, 
                #ellipses = F, group.ellipses.args,
                #group.hulls = F, group.hull.args,
                #bty = "L",
                #iso.order = c(1,2),
                #xlab=expression({delta}^13*C~'\u2030'),
                #ylab=expression({delta}^15*N~'\u2030'),
                #cex = 0.5
#)



# Calculate summary statistics for each group: TA, SEA and SEAc
group.ML <- groupMetricsML(siber.example)
print(group.ML)

View(group.ML)

# You can add more ellipses by directly calling plot.group.ellipses()
# Add an additional p.interval % prediction ellilpse
#plotGroupEllipses(siber.example, n = 100, p.interval = 0.95,
                  #lty = 1, lwd = 2)

# or you can add the XX% confidence interval around the bivariate means
# by specifying ci.mean = T along with whatever p.interval you want.

#plotGroupEllipses(siber.example, n = 100, p.interval = 0.95, ci.mean = T,                lty = 1, lwd = 2)

# A second plot provides information more suitable to comparing
# the two communities based on the community-level Layman metrics

# this time we will make the points a bit smaller by 
# cex = 0.5
#plotSiberObject(siber.example,
                #ax.pad = 2, 
                #hulls = T, community.hulls.args, 
                #ellipses = F, group.ellipses.args,
                #group.hulls = F, group.hull.args,
                #bty = "L",
                #iso.order = c(1,2),
                #xlab=expression({delta}^13*C~'\u2030'),
                #ylab=expression({delta}^15*N~'\u2030'),
                #cex = 0.5
#)
 
# Calculate the various Layman metrics on each of the communities.
community.ML <- communityMetricsML(siber.example) 
print(community.ML)
