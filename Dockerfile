FROM centos:7
ENV container docker
RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == \
systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*; \
yum install -y wget vim epel-release yum-utils rpm-build rpmdevtools redhat-lsb-core createrepo; \
yum install -y htop luajit ;\
yum groupinstall -y 'Development Tools';\
wget http://nginx.org/packages/rhel/7/SRPMS/nginx-1.6.3-1.el7.ngx.src.rpm;\
rpm -i nginx-1.6.3-1.el7.ngx.src.rpm;\
rpmdev-setuptree;\
rm -f /root/rpmbuild/SPECS/nginx.spec;\
### Warning !!!
# wget -O /root/rpmbuild/SPECS/nginx.spec <your super spec>;\
yum-builddep -y /root/rpmbuild/SPECS/nginx.spec;\
spectool -g -R /root/rpmbuild/SPECS/nginx.spec;\
rpmbuild -ba /root/rpmbuild/SPECS/nginx.spec;\
yum install -y /root/rpmbuild/RPMS/x86_64/nginx-1.6.3-1.el7.ngx.x86_64.rpm;\
mkdir /usr/share/nginx/html/repo;\
cp /root/rpmbuild/RPMS/x86_64/nginx-1.6.3-1.el7.ngx.x86_64.rpm /usr/share/nginx/html/repo/;\
wget http://www.percona.com/downloads/percona-release/redhat/0.1-6/percona-release-0.1-6.noarch.rpm -O /usr/share/nginx/html/repo/percona-release-0.1-6.noarch.rpm;\
createrepo /usr/share/nginx/html/repo/;\
sed -i $'/index  index.html index.htm;/a autoindex on;' /etc/nginx/conf.d/default.conf;

CMD ["nginx", "-g", "daemon off;"]
