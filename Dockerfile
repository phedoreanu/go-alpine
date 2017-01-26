FROM golang:alpine
MAINTAINER adrian.fedoreanu@gmail.com

RUN apk add --no-cache git

ONBUILD ENV APP_PATH /go/src/app
ONBUILD RUN mkdir -p $APP_PATH
ONBUILD WORKDIR $APP_PATH
ONBUILD COPY . $APP_PATH
ONBUILD RUN chown -R daemon:daemon $APP_PATH

ONBUILD RUN go-wrapper download
ONBUILD RUN go-wrapper install
ONBUILD USER daemon
# this will ideally be built by the `go-wrapper` ;)
ONBUILD CMD go-wrapper run
