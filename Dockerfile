FROM node:12.16.3-alpine3.9
ENV PATH=/home/node/node_modules/.bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
COPY ./package*json /home/node/
RUN cd /home/node && \
    npm install && \
    apk add git && \
    git config --global user.email "automated" && \
    git config --global user.name "Standard Version"
WORKDIR /repo
ENTRYPOINT ["standard-version"]
