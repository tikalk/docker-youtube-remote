FROM node:5.1.1 
MAINTAINER Liya Katz <liya@tikalk.com> 

RUN apt-get update && apt-get install -y git

RUN npm -g install sails && npm -g install yo && npm -g install bower && npm install -g grunt-cli
RUN cd /opt && git clone https://github.com/tikalk/youtube-remote-js/
RUN cd /opt/youtube-remote-js && npm install grunt --save-dev && npm install && bower --allow-root install

WORKDIR /opt/youtube-remote

ENV MONGO_DB_CS mongodb

EXPOSE 3000

CMD sails lift
