FROM centos:7
RUN yum -y install httpd yum-utils
RUN yum -y install php php-{common,opcache,mcrypt,cli,gd,mysqlnd,curl}
RUN yum-config-manager --add-repo http://downloads.mariadb.org/mariadb/repositories/
RUN yum -y update
RUN yum -y install mariadb-server
WORKDIR /root
ADD /home/minhquan/Documents/code_web/* /root
EXPOSE 80
RUN cp 
