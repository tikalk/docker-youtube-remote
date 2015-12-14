FROM node:5.1.1 
MAINTAINER Liya Katz <liya@tikalk.com> 

RUN apt-get update && apt-get install -y git

RUN cd /opt && git clone https://github.com/assafg/youtube-remote/ && \
 	cd /opt/youtube-remote && npm install 

WORKDIR /opt/youtube-remote

ENV MONGO_DB_CS mongodb

EXPOSE 3000

CMD node server.js
