# Centos 7 in Vagrant with rpmbuild nginx

В jikarto/centos-nginx-rpm собран nginx с lua, develkit и vts модулями. Порядок сборки можно посмореть в packer/scprits/... Своя репа называется "myy"

Для старта образа докера: 
docker run --name mynginx -p 80:80 -d jikarto/nginxlua

```
$ curl http://localhost/repo/

<a href="nginx-1.6.3-1.el7.ngx.x86_64.rpm">nginx-1.6.3-1.el7.ngx.x86_64.rpm</a>
<a href="percona-release-0.1-6.noarch.rpm">percona-release-0.1-6.noarch.rpm</a>
```


### Links:

https://app.vagrantup.com/jikarto/boxes/centos-nginx-rpm
https://hub.docker.com/repository/docker/jikarto/nginxlua

### License
[![License: WTFPL](https://img.shields.io/badge/License-WTFPL-brightgreen.svg)](http://www.wtfpl.net/about/)
