# The Jmeter samples with reports

It's a demonstration of Jmeter with reports where tou can configure each needed parameter and use in your CI environment 

## How to build and run  

    # docker build -t autotest . 
    # docker run --rm -t -v /tmp/jmeter/:/jmeter/results autotest bash -c "sh /jmeter/run.sh"


After get the result report in the /tmp/jmeter/

You can send several parameters or used default:
    
    protocol=https
    ApiHost=-www.googleapis.com
    ApiPort=443
    count=5
    duration=1

Where `count` is the number of threads.
`duration` is the ramp-up period (seconds)

Each thread will execute the test plan in its entirety and completely independently of other test threads. Multiple threads are used to simulate concurrent connections to your server application.

The ramp-up period tells JMeter how long to take to "ramp-up" to the full number of threads chosen. 
If 10 threads are used, and the ramp-up period is 100 seconds, then JMeter will take 100 seconds to get all 10 threads up and running. 
Each thread will start 10 (100/10) seconds after the previous thread was begun. 
If there are 30 threads and a ramp-up period of 120 seconds, then each successive thread will be delayed by 4 seconds.

 Example #2
 
    docker run --rm -t -v /tmp/jmeter/:/jmeter/results \
     -e count='10' \
     -e repeatCount='1' \
     -e rampup='1' \
     -testGroup2ThreadActive='true' \
     -e protocol='https'  \
     -e ApiHost='-www.googleapis.com' \
     -e ApiPort='443' \
     autotest bash -c "sh /jmeter/run.sh"