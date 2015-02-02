FROM ubuntu:14.04
MAINTAINER ben wyeth <ripple-rest@nimmaj.com>
RUN apt-get update && apt-get -y install nodejs npm git
RUN git clone https://github.com/ripple/ripple-rest.git
RUN sudo ln -s /usr/bin/nodejs /usr/bin/node
WORKDIR ripple-rest
RUN npm install
ADD config.json startRippleRest.sh ripple-rest/
RUN chmod +x startRippleRest.sh
RUN mkdir certs
RUN openssl genrsa -out ./certs/server.key 2048
RUN openssl req -utf8 -new -key ./certs/server.key -out ./certs/server.csr -sha512 -batch
RUN openssl x509 -req -days 730 -in ./certs/server.csr -signkey ./certs/server.key -out ./certs/server.crt -sha512
EXPOSE 5990
CMD ./startRippleRest.sh
