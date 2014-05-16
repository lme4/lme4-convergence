library(lme4)
library(lme4.0)

c. <- function(x) scale(x, center=TRUE, scale=FALSE)
reml <- FALSE

modeldata <- read.table("data.tab",header=T,
                        colClasses=c(mean="numeric",subj="factor",item="factor",
                                     roi="factor",win="factor",
                                     sdiff="numeric", dist="numeric",signdist="numeric",ambiguity="factor"))

modeldata <- subset(modeldata, roi == 'Left-Posterior')
modeldata.n400 <- subset(modeldata,win=="N400")

sdiff.new <- lme4::lmer(mean ~ ambiguity * c.(sdiff) + (1+c.(sdiff)|item) + (1+c.(sdiff)|subj), data=modeldata.n400, REML=reml)
print("New lme4")
print(summary(sdiff.new))

sdiff.old <- lme4.0::lmer(mean ~ ambiguity * c.(sdiff) + (1+c.(sdiff)|item) + (1+c.(sdiff)|subj), data=modeldata.n400, REML=reml)
print("Old lme4")
print(summary(sdiff.old))
