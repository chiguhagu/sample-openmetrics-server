FROM golang:1.15.6-alpine AS build
ENV WORKDIR_PATH /go/src/github.com/chiguhagu/metrics-server
WORKDIR ${WORKDIR_PATH}
COPY go.mod .
COPY go.sum .
RUN CGO_ENABLED=0 go mod download
ADD . ${WORKDIR_PATH}
RUN CGO_ENABLED=0 go build -o /bin/metrics-server .

FROM alpine:3.12.3
COPY --from=build /bin/metrics-server metrics-server
EXPOSE 9100
ENTRYPOINT ["./metrics-server"]
