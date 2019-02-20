# remove all elements for a clean start
rm(list=ls(all=TRUE))
# Supplementary Material for Longitudinal Analysis: Modeling Within-Person Fluctuation and Change 
# Chapter 2: MPLUS Syntax and Output by Model

## @knitr LoadPackages
require(sas7bdat)
library(nlme)
library(lme4)
library(emmeans)

## @knitr LoadData
pathDir  <- getwd()
pathCh2  <- file.path(pathDir,"Chapters/02/SAS_Chapter2/SAS_Chapter2.sas7bdat")
dsL2   <- read.sas7bdat(pathCh2, debug=TRUE) 
ds <- dsL2
# cloumn names
names(ds)
# counts/structure of data
str(ds)

# change sex and demgroup to factors
ds$sexMW <- as.factor(ds$sexMW)
ds$demgroup <- as.factor(ds$demgroup)

# description (mean, median, etc.)
summary(ds)

# show the breakdown of the data types
table(ds$sexMW, ds$demgroup)

# culminative sum
cumsum(table(ds$demgroup))

## @knitr EmptyMeansModel
model_null <- nlme::gls(cognition ~ 1, data=ds, method="REML")
summary(model_null)
# can't figure out how to get covariance structure
# getVarCov(model_null, individual=1)
# this is the variance estimate (residual standard error squared)
summary(model_null)$sigma^2


## @knitr AddingAge(0=85)
ds$age85 <- ds$age - 85
ds$grip9 <- ds$grip - 9

model_age85 <- nlme::gls(cognition ~ 1 + age85, data=ds, method="REML")
summary(model_age85)
ds$model_age85 <- predict(model_age85)


logLik <- summary(model_age85)$logLik
deviance <- -2*logLik
AIC <- AIC(model_age85)
BIC <- BIC(model_age85)
df.resid <- NA
N <- summary(model_age85)$dims$N
p <- summary(model_age85)$dims$p
ids <- length(unique(ds$PersonID))
df.resid <- N - p
mInfo <- data.frame("logLik" = logLik,
                    "deviance"= deviance,
                    "AIC" = AIC,
                    "BIC" = BIC,
                    "df.resid" = df.resid,
                    "N" = N, 
                    "p" = p,
                    "ids" = ids)
t <- t(mInfo)
rownames(t)<-colnames(mInfo)
dsmInfo<- data.frame(new=t)
colnames(dsmInfo) <- c("modelA")
# dsmInfo$Coefficient <- rownames(dsmInfo)
mA <- dsmInfo
print(mA)

summary(model_age85)$sigma^2

# see the impact of adding age
anova(model_null, model_age85)

# trying to compare the r-squared between both models
# https://github.com/jslefche/piecewiseSEM


# Model of unadjusted age

model_age <- nlme::gls(cognition ~ 1 + age, data=ds, method="REML")
summary(model_age)
summary(model_age)$sigma^2

# Model add grip

model_add_grip <- nlme::gls(cognition ~ 1 + age85 + grip9, data=ds, method="REML")
summary(model_add_grip)
summary(model_add_grip)$sigma^2

# Model add sex (M=0, W=1)
ds$sexMW <- factor(ds$sexMW, levels=c(0, 1))
model_add_sex_m0 <- nlme::gls(cognition ~ 1 + age85 + grip9 + sexMW, data=ds, method="REML")
summary(model_add_sex_m0)
summary(model_add_sex_m0)$sigma^2

# Model add sex (W=1, M=0)
ds$sexMW <- factor(ds$sexMW, levels=c(1, 0))
model_add_sex_w0 <- nlme::gls(cognition ~ 1 + age85 + grip9 + sexMW, data=ds, method="REML")
summary(model_add_sex_w0)
summary(model_add_sex_w0)$sigma^2

# Model add demgroup
model_add_demgroup <- nlme::gls(cognition ~ 1 + age85 + grip9 + sexMW + demgroup, data=ds, method="REML")
summary(model_add_demgroup)
summary(model_add_demgroup)$sigma^2

# get all contrasts
emmeans(model_add_demgroup, pairwise~demgroup)


# Model add interaction age85*grip9

model_add_int <- nlme::gls(cognition ~ 1 + age85*grip9 + sexMW + demgroup, data=ds, method="REML")
summary(model_add_int)
summary(model_add_int)$sigma^2


# Model add interaction sex*dem

model_add_ints <- nlme::gls(cognition ~ 1 + age85*grip9 + sexMW*demgroup, data=ds, method="REML")
summary(model_add_ints)
summary(model_add_ints)$sigma^2
