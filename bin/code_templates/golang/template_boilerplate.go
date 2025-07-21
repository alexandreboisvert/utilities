package main

import (
	"encoding/json"
	"fmt"
	"os"
)

type ProgramConfig struct {
	ConfigDir string `json:"config_dir"`
}

func main() {
	fmt.Println("Golang Template Program")

	fmt.Println("all command line arguments", os.Args)
	fmt.Println("command line arguments received", os.Args[1:])

	cmdLineParsing(os.Args[1:])
}

func cmdLineParsing(args []string) {
	fmt.Println("cmdLineParsing")
	fmt.Printf("args = %v\n", args)

	if len(args) == 0 {
		printHelp()
		os.Exit(0)
	}

	for _, filePath := range args {
		fmt.Printf("Processing file %v\n", filePath)

		err := processFile(filePath)
		if err != nil {
			fmt.Printf("Failure to process file %v: %v\n", filePath, err)
		} else {
			fmt.Printf("Successfully processed file %v\n", filePath)
		}
	}

	fmt.Println("End Program")
}

func printHelp() {
	helpMessage := ""
	helpMessage += "Golang Template Program\n"
	helpMessage += "When used without options, show this help and exit\n"
	helpMessage += "Command line options:\n"
	helpMessage += "f1.txt f2.txt f3.txt: process files listed\n"
	fmt.Println(helpMessage)
}

func processFile(path string) error {

	var config ProgramConfig

	data, err := os.ReadFile(path)
	if err != nil {
		return fmt.Errorf("failure to read data from path %s: %v", path, err)
	}

	err = json.Unmarshal(data, &config)
	if err != nil {
		return fmt.Errorf("failure to unmarshal data: %v", err)
	}

	fmt.Printf("Config from file: %v\n", config)
	return nil
}

/*

==> Makefile <==

linux: demo_arg

demo_arg: *.go
	go mod tidy
	go fmt
	go vet
	golangci-lint run
	govulncheck .
	CGO_ENABLED=0 go build -a -ldflags "-X main.ProgramVersion=`./current_version.sh`" -o demo_arg

windows: demo_arg.exe

demo_arg.exe: *.go
	go mod tidy
	go fmt
	go vet
	golangci-lint run
	govulncheck .
	GOOS=windows GOARCH=amd64 CGO_ENABLED=0 go build -a -ldflags "-X main.ProgramVersion=`./current_version.sh`" -o demo_arg.exe

clean:
	rm -f demo_arg
	rm -f demo_arg.exe

==> current_version.sh <==
#!/usr/bin/env bash

current_version=""

if [[ -d ".git" ]]
then
    # Version: use date / latest commit ID / git status
    current_version=$(git log -1 --color=never --date=iso-strict | awk '
      BEGIN{
        ts = "";
        c = ""}
      /^commit/ { c = $2 }
      /^Date:/ { ts = $2 }
      END{ print ts "/" c}')

    git_status=$(git status --short | wc -l)

    if [[ "${git_status}" -ne "0" ]]
    then
      current_version="${current_version}/dirty"
    else
      current_version="${current_version}/clean"
    fi
else
    current_version="$(date +%Y-%m-%d_%H%M%S)"
fi

echo "${current_version}"

*/
