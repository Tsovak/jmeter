FROM ubuntu
MAINTAINER Tsovak Sahakyan

RUN apt-get clean && \
	apt-get update 

RUN apt-get -qy install \
			wget \
			openjdk-8-jdk \
			unzip
RUN mkdir -p /jmeter

COPY ./ /jmeter

RUN  ls -al /jmeter &&  chmod +x /jmeter/run.sh
# RUN bash /jmeter/run.sh
