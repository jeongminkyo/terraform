#!/bin/sh

if [ -z "$1" ]
  then
    echo "No argument service name."
	exit 1
fi

# -t: 암호화 타입
# -b: 비트 수
# -C: 코멘트
# -f: 파일 저장 경로
# -N: 암호화 옵션
ssh-keygen -t rsa -b 4096 -C "" -f "./$1-ssh-key" -N ""
 
