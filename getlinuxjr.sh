#!/bin/bash
#
# warning: this isn't pretty or good in anyway, but it worked for me...
#
 
ACCOUNT="LJ869556"
# remember to URL encode the zip (%20 instead of space etc.)
ZIP="11764"
 
for u in `curl -vvv "http://download.linuxjournal.com/pdf/dljdownload.php?AN=${ACCOUNT}&ZP=${ZIP}" |grep a\ href | grep get\-doc | sed 's/^.*href\=\"//g' | sed 's/\".*$//g'`
do
    f=`curl ${u} |grep refresh | sed 's/^.*content\=\"5\;url\=//g' | sed 's/\"\>//g' | sed 's/\&amp\;/\&/g'`
    wget "http://download.linuxjournal.com${f}"
done
 
for f in `find . -type f -name "get-doc.php*" -depth 1`
do
    newf=`echo ${f} | sed 's/^.*tcode\=//g' | sed 's/\&.*$//g'`
    ext=`echo ${newf} | sed 's/\-.*$//g'`
    newf=`echo ${newf}.${ext}`
    mv "${f}" "${newf}"
done
