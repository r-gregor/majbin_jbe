#! /usr/bin/env bash

# filename: go_project_env_d.sh

usage_msg="Usage: go_project_env_d <project_name>"

# if no <project_name> supplied
if [ $# -ne 1 ]; then
    echo ${usage_msg}
    exit 1
fi

# initial setup
project_nm=$1
gostart=$PWD

# if already exists: delete ASK?
if [ -d src/example.com/rgregor/${project_nm} ]; then
    echo "src/example.com/rgregor/${project_nm} exists!"
    echo "Aborting."
    exit 1
fi

# contents of a test main.go file in a variable test_main
read -r -d '' test_main <<-EOF
package main

import "fmt"

func main() {
    project_nm := "${project_nm}"
    fmt.Println("Project: ", project_nm)
    fmt.Println("SUCCESS!!")
}

EOF


env_f=env_settings.txt

mkdir -pv ${gostart}/{src,bin,pkg}
mkdir -pv ${gostart}/src/example.com/rgregor/${project_nm}

godir="example.com/rgregor/${project_nm}"
gomain="${godir}/${project_nm}.go"


touch src/${gomain}
echo "${test_main}" > src/${gomain}


echo -e "\nThe contents of src/${gomain}:"
cat src/${gomain}

echo
\tree --charset ASCI --noreport ${gostart}

touch ${env_f}
> ${env_f}

go_path="GOPATH=${gostart}"
# go_bin="GOBIN=\"$(cygpath -w ${gostart}/bin)\""

echo ${go_path} >> ${env_f}

echo -e "\nTest run:" >> ${env_f}
echo "${go_path} go run ./src/${gomain}" >> ${env_f}

echo -e "\nRun:" >> ${env_f}
echo "${go_path} go install ./src/${godir}" >> ${env_f}

echo
echo "The contents of ${env_f}:"
cat ${env_f}
