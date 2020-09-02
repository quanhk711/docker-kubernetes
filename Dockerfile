FROM centos:7

RUN yum -y install httpd yum-utils

RUN yum -y install systemd

RUN yum -y install http://rpms.remirepo.net/enterprise/remi-release-7.rpm
RUN yum-config-manager --enable remi-php74
RUN yum -y install php php-devel php-mbstring php-pdo php-gd php-xml php-mcrypt php-pgsql

RUN echo "[mariadb]" >> /etc/yum.repos.d/mariadb.repo
RUN echo "name = MariaDB" >> /etc/yum.repos.d/mariadb.repo
RUN echo "baseurl = http://yum.mariadb.org/10.4/centos7-amd64" >> /etc/yum.repos.d/mariadb.repo
RUN echo "gpgkey=https://yum.mariadb.org/RPM-GPG-KEY-MariaDB" >> /etc/yum.repos.d/mariadb.repo
RUN echo "gpgcheck=1" >> /etc/yum.repos.d/mariadb.repo
RUN yum -y install mariadb-server
RUN echo "ServerName localhost" >> /etc/httpd/conf/httpd.conf

WORKDIR /root
ADD ./code_web/ /root
CMD [ "/usr/sbin/init" ]
#CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
EXPOSE 80