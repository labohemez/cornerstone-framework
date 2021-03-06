#!/bin/bash

GIT_ROOT=/home/appadmin/CORNER/git/CornersGithub
CORNER_DEV=$GIT_ROOT/cornerstone-framework.dev

GITSYNC=$CORNER_DEV/examples/github.sync

### 10분 단위로 git pull이 수행되도록 설정한다.
TEN_MIN=600
sleep_interval=$TEN_MIN

AN_HOUR=3600
hourly_reset_cnt=`expr $AN_HOUR \/ $TEN_MIN`

reset_cnt=$hourly_reset_cnt

##################################################
### GIT pull 반복 수행 용 루프 와 초기 세팅 값!!!
##################################################
cnt=0
hcnt=0

echo "----------------------GitHub SYNC START-------------------------";
echo;

while [ 1 ] 
do


if [ $cnt = $reset_cnt ]
then
cnt=0
hcnt=`expr $hcnt + 1`;
fi

cnt=`expr $cnt + 1`;

### git pull 수행
echo "1. GitHub cornerstone-framework (dev) pulling ...";
cd $CORNER_DEV
echo CURRENT DIR = [ `pwd` ]; echo;
git pull;
echo;

### markdown TO eco 변환작업 수행 (livedoc 전용)
echo "2. Converting: Markdown -> Livedoc Eco";
cd $GITSYNC
echo CURRENT DIR = [ `pwd` ]; echo;
lsync.sh
#ls -l
echo;

echo Execute GIT pull '(count = '$cnt', hour = '$hcnt')';

sleep $sleep_interval

echo;

done
