FROM tomcat:8.5.21
WORKDIR /app
COPY index.js ./
RUN ls

FROM tomcat:8.0.0
WORKDIR /app
COPY --from=0 / ./
RUN ls


