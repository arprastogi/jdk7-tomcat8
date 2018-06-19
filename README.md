# jdk7-tomcat8
jdk7 + tomcat8 on CentOS 7

Pre-requisite:
Download jdk-7u80-linux-x64.tar.gz file from Oracle website (http://www.oracle.com/technetwork/java/javase/downloads/java-archive-downloads-javase7-521261.html)

````
git clone https://github.com/arprastogi/jdk7-tomcat8.git

cd jdk7-tomcat8
````
Place the downloaded jdk file under 'jdk7-tomcat8' folder and execute below command.

````
# docker build -t jdk7-tomcat8 .

# docker images
````
To run container execute below:
````
# docker run -d --rm -p 8888:8080 jdk7-tomcat8
````
