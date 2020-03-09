#!/bin/bash

yum install -y wget vim epel-release yum-utils rpm-build rpmdevtools redhat-lsb-core createrepo
yum install -y htop luajit
yum groupinstall -y 'Development Tools'
wget http://nginx.org/packages/rhel/7/SRPMS/nginx-1.6.3-1.el7.ngx.src.rpm
rpm -i nginx-1.6.3-1.el7.ngx.src.rpm
rpmdev-setuptree
rm -f /root/rpmbuild/SPECS/nginx.spec
### Watch out!
# wget -O /root/rpmbuild/SPECS/nginx.spec <Your super spec>
yum-builddep -y /root/rpmbuild/SPECS/nginx.spec
spectool -g -R /root/rpmbuild/SPECS/nginx.spec
rpmbuild -ba /root/rpmbuild/SPECS/nginx.spec
setenforce 0
yum install -y /root/rpmbuild/RPMS/x86_64/nginx-1.6.3-1.el7.ngx.x86_64.rpm
systemctl start nginx
systemctl enable nginx
mkdir /usr/share/nginx/html/repo
cp /root/rpmbuild/RPMS/x86_64/nginx-1.6.3-1.el7.ngx.x86_64.rpm /usr/share/nginx/html/repo/
wget http://www.percona.com/downloads/percona-release/redhat/0.1-6/percona-release-0.1-6.noarch.rpm -O /usr/share/nginx/html/repo/percona-release-0.1-6.noarch.rpm
createrepo /usr/share/nginx/html/repo/
sed -i $'/index  index.html index.htm;/a autoindex on;' /etc/nginx/conf.d/default.conf
nginx -s reload
cat >> /etc/yum.repos.d/my.repo << EOF
[myy]
name=mys
baseurl=http://localhost/repo
gpgcheck=0
enabled=1
EOF
yum install percona-release -y
