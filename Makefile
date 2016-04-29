.PHONY: all

all: test

test: scanner.go tabinfo.go parse.go
	go test -v ./...

scanner.go: scanner.l
	nex -o scanner.go scanner.l

tabinfo.go: tabinfo.y
	go tool yacc -o tabinfo.go tabinfo.y
