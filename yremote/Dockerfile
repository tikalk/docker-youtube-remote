FROM node:5.1.1 
MAINTAINER Liya Katz <liya@tikalk.com> 

#RUN apt-get update && apt-get install -y git

RUN mkdir -p /opt/youtube-remote
WORKDIR /opt/youtube-remote

RUN npm -g install sails && npm -g install yo
ADD youtube-remote-js/* /opt/youtube-remote
RUN cd /opt/youtube-remote && npm install && bower install

ENV MONGO_DB_CS mongodb

EXPORT 3000
