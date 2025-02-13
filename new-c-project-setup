#! /usr/bin/env bash

if [ $# -eq 1 ]; then
	project_name=$1
else
	project_name="defaultprojectname-rename-me_$(date +%Y%m%d)"
fi

project_path="./${project_name}"


if [ -d ${project_path} ]; then
	echo "${project_path} exists!"
	exit
fi

echo "Creating new project: ${project_name}"
mkdir -vp ${project_path}/{src,lib,include,tests,bin,build}

cat <<'EOF' > "${project_path}/Makefile"
#for win
#CC=/c/Users/gregor.redelonghi/majstaf/majprogs/mingw./build/x86_64-w64-mingw32-gcc-11.1.0.exe
CC = gcc
CFLAGS = -g -Wall
RM = rm -v
BIN = ./bin
SRC = ./src

SRCS = $(wildcard $(SRC)/*.c)
# PROGS = $(patsubst %.c,%,$(SRCS))
PROGS = $(SRCS:$(SRC)/%.c=%)

all: newbindir $(PROGS)

newbindir:
	@mkdir -p ./bin

%: $(SRC)/%.c $(SRC)/*.h
	$(CC) $(CFLAGS) -o $(BIN)/$@ $<

%: $(SRC)/%.c
	$(CC) $(CFLAGS) -o $(BIN)/$@ $<

clean:
	$(RM) $(BIN)/*

EOF

cat <<'EOF2' > ${project_path}/src/main.c
#include <stdio.h>
#include <string.h>

int main(void) {
	printf("I'm ALIVE!!\n");

	return 0;
}

EOF2

tree ${project_path}

