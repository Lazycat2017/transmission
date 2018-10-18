# 第一部分
### 安装nfs客户端

```
apt update
```


```
apt install vim htop wget curl -y
```

```
apt install nfs-common
```

### 查看ip是否有挂载

```
showmount -e 10.10.1.8
```

		
### 创建挂载点

```
mkdir /pt
```

### 挂载命令

```
mount -t nfs -onoexec,nosuid,nodev,noatime 10.10.1.8:/volume2/PT /pt
```

### 开机自动挂载

```
vim /etc/fstab
```


```
10.10.1.8:/volume2/PT /pt   nfs auto,nofail,noatime,nolock,intr,tcp,actimeo=1800 0 0
```

# 第二部分

### Transmission安装
		

```
wget --no-check-certificate https://raw.githubusercontent.com/Lazycat2017/transmission/master/transmission.sh
```

		

```
chmod +x transmission.sh
```

		

```
sh transmission.sh
```

### 给下载目录权限
			

```
chmod 777 /pt/ && mkdir -p /pt/torrent && chmod 777 /pt/torrent
```

### Transmission主题美化

```
wget --no-check-certificate https://github.com/ronggang/transmission-web-control/raw/master/release/install-tr-control-cn.sh
```

```
sh install-tr-control-cn.sh
```

# 第三部分

### RSS订阅安装flexget及配置
	

```
apt-get install python-pip python-setuptools -y
```


```
pip install --upgrade pip
```

```
pip2 install flexget
```

```
pip2 install transmissionrpc
```

```
mkdir /root/.flexget
```

```
vim /root/.flexget/config.yml
```

```
:set paste
```

```
tasks:
  whsir:
    rss: http://bt.3dmgame.com/rss.php
    template: default
    accept_all: yes
    download: /pt/torrent
    transmission:
      path: /pt/
templates:
  default:
    transmission:
      host: localhost
      port: 8888
      username: admin
      password: "admin"
    clean_transmission:
      host: localhost
      port: 8888
      username: admin
      password: "admin"
      finished_for: 24 hours

web_server: 8889
```

```
flexget web passwd
```

```
flexget daemon start --daemonize
```

	which flexget

```
which flexget

/usr/local/bin/flexget
```

	

```
crontab -e
```

	

```
*/5 * * * * /usr/local/bin/flexget -c /root/.flexget/config.yml execute
```

### 进程守护supervisor

```
apt install python-pip python-m2crypto supervisor
```

```
vim /etc/supervisor/conf.d/flexgetweb.conf
```

```
[program:flexget-web]
command=python /usr/local/bin/flexget daemon start
user=root
autostart=true
autorestart=true
```

```
/etc/init.d/supervisor restart
```

```
supervisorctl status
```

```
vim /etc/profile
```

```
ulimit -n 51200
ulimit -Sn 4096
ulimit -Hn 8192
```

```
vim /etc/default/supervisor
```

```
ulimit -n 51200
ulimit -Sn 4096
ulimit -Hn 8192
```


# 视频教程

https://youtu.be/F7W3rlAdTH0
