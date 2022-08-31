export GOPROXY=https://proxy.golang.com.cn,direct
export GOPRIVATE=git.mycompany.com,github.com/my/private
go mod download
CGO_ENABLED=0 go build -a -o jenkins-test ./main.go
BUILD_ID=DONTKILLME
nohup ./jenkins-test &>jenkins_sample.log &
