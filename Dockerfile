FROM centos:7

RUN yum -y update

RUN yum -y install httpd yum-utils

RUN yum -y install http://rpms.remirepo.net/enterprise/remi-release-7.rpm
RUN yum-config-manager --enable remi-php74
RUN yum -y install php php-devel php-mbstring php-pdo php-gd php-xml php-mcrypt php-pgsql

RUN echo "[mariadb]" >> /etc/yum.repos.d/mariadb.repo
RUN echo "name = MariaDB" >> /etc/yum.repos.d/mariadb.repo
RUN echo "baseurl = http://yum.mariadb.org/10.4/centos7-amd64" >> /etc/yum.repos.d/mariadb.repo
RUN echo "gpgkey=https://yum.mariadb.org/RPM-GPG-KEY-MariaDB" >> /etc/yum.repos.d/mariadb.repo
RUN echo "gpgcheck=1" >> /etc/yum.repos.d/mariadb.repo
RUN yum install mariadb-server

WORKDIR /root
ADD /home/minhquan/Documents/code_web/* /root
RUN mysql -sfu root < "mysql_secure_installation.sql"
RUN mysql -uroot -p123 -e "CREATE DATABASE web;"
RUN mysql -u root -p123 web <thienancorp_db.sql
RUN cp /root/tacorp.vn/public_html/* /var/www/html
RUN sed -i 's/DirectoryIndex index.html/DirectoryIndex index.html index.php/g' /etc/httpd/conf/httpd.conf
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
EXPOSE 80