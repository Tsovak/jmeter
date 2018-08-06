#!/usr/bin/env bash

protocol=${protocol:-http}
ApiHost=${ApiHost:-www.googleapis.com}
ApiPort=${ApiPort:-443}
count=${count:-5}
repeatCount=${repeatCount:-1}
rampup=${rampup:-1}
testGroup2ThreadActive=${testGroup2ThreadActive:-true}
jmxfile=${jmxfile:-tests.jmx}

cd /jmeter/

sh ./apache-jmeter-4.0/bin/jmeter.sh -n \
     -t $jmxfile \
     -l log.jtl \
     -j jmeter.log \
     -Jprotocol=$protocol \
     -JApiHost=$ApiHost \
     -JApiPort=$ApiPort \
	 -JtestGroup2ThreadActive=$testGroup2ThreadActive \
     -Jthreadgroup.count=$count \
     -Jthreadgroup.duration=$repeatCount \
     -Jthreadgroup.rampup=$rampup \
     -Jjmeter.save.saveservice.response_data=true \
     -Jjmeter.save.saveservice.samplerData=true \
     -Jjmeter.save.saveservice.requestHeaders=true \
     -Jjmeter.save.saveservice.url=true \
     -Jjmeter.save.saveservice.responseHeaders=true

awk -F "\t" 'BEGIN {OFS=FS} {print $1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14}' log.jtl > jtl2.jtl

mkdir -p results/dashboard
java -jar ./apache-jmeter-4.0/bin/ApacheJMeter.jar \
     -g log.jtl \
     -o results/dashboard

ls -al ./
cp log.jtl results/dashboard
cp jtl2.jtl results/dashboard
cp jmeter.log results/dashboard

echo "...change permitions"
chown -R 1000 results
chmod -R 0777 results

echo "...ls -al"
ls -al 
ls -al results

FAIL_COUNT=`cat log.jtl | cut -d ',' -f 8 | grep -v success | grep -c false`
if [ $FAIL_COUNT -gt 0 ]; then
    echo "Error was found"
    cat log.jtl | cut -d ',' -f 3,8 | grep -v success | grep false
fi
exit $FAIL_COUNT

