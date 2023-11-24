FROM rstudio/plumber
LABEL org.opencontainers.image.authors="Docker User <docker@user.org>"

RUN R -e "install.packages('broom')"

CMD ["/app/plumber.R"]