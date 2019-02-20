FROM rocker/rstudio:3.5.2

# set the theme to Vibrant Ink (dark theme)
RUN echo "uiPrefs={\"theme\" : \"Vibrant Ink\"}" >> \
  /home/rstudio/.rstudio/monitored/user-settings/user-settings

# automatically start with project activated
RUN mkdir -p /home/rstudio/.rstudio/projects_settings &&\
    echo "/home/rstudio/kitematic/kitematic.Rproj" > /home/rstudio/.rstudio/projects_settings/last-project-path

# packages for Rmarkdown/Rnotebooks
RUN install2.r \
        caTools \ 
        bitops \
        rprojroot

# get the tidyverse for data wrangling and here for sensibly resolving paths
RUN install2.r \
        tidyverse \
        here 

# install packages for class
RUN install2.r \
        arm \
        emmeans \
        lme4 \
        lmerTest \
        multcomp \
        nlme \
        psych \
        reshape2 \
        sas7bdat
