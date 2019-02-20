FROM rocker/rstudio:3.5.1

# get the tidyverse for data wrangling
RUN install2.r tidyverse 

# install packages for class
RUN install2.r \
        arm \
        emmeans \
        lmer4 \
        lmerTest \
        multcomp \
        nlme \
        psych \
        reshape2 \
        sas7bdat
