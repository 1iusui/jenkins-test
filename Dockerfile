FROM golang:1.18-alpine as builder

WORKDIR /workspace

# copy modules manifests
COPY go.mod go.mod
COPY go.sum go.sum

# export go proxy
ENV GOPROXY https://proxy.golang.com.cn,direct
ENV GOPRIVATE git.mycompany.com,github.com/my/private
# cache modules
RUN go mod download

# copy source code
COPY main.go main.go

# build
RUN CGO_ENABLED=0 go build \
    -a -o jenkins-test ./main.go

FROM alpine:3.16

RUN apk --no-cache add ca-certificates


COPY --from=builder /workspace/jenkins-test .

ENTRYPOINT ["./jenkins-test"]