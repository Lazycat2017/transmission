#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

ver="latest"
echo "Which version(latest OR stable) do you want to install:"
read -p "Type latest or stable (latest):" ver
if [ "$ver" = "" ]; then
	ver="latest"
fi

username=""
read -p "Set username:" username
if [ "$username" = "" ]; then
	username="woaipt"
fi

password=""
read -p "Set password:" password
if [ "$password" = "" ]; then
	password="woaipt"
fi

port=""
read -p "Set port(9091):" port
if [ "$port" = "" ]; then
	port="9091"
fi

	get_char()
	{
	SAVEDSTTY=`stty -g`
	stty -echo
	stty cbreak
	dd if=/dev/tty bs=1 count=1 2> /dev/null
	stty -raw
	stty echo
	stty $SAVEDSTTY
	}
	echo ""
	echo "Press any key to start...or Press Ctrl+c to cancel"
	char=`get_char`

apt-get update
apt-get -y install transmission-daemon

/etc/init.d/transmission-daemon stop
wget --no-check-certificate https://raw.githubusercontent.com/Lazycat2017/transmission/master/conf/settings.json
chmod +x settings.json
mkdir -p /var/lib/transmission-daemon/info
mv -f settings.json /var/lib/transmission-daemon/info/
sed -i 's/^.*rpc-username.*/"rpc-username": "'$(echo $username)'",/' /var/lib/transmission-daemon/info/settings.json
sed -i 's/^.*rpc-password.*/"rpc-password": "'$(echo $password)'",/' /var/lib/transmission-daemon/info/settings.json
sed -i 's/^.*rpc-port.*/"rpc-port": '$(echo $port)',/' /var/lib/transmission-daemon/info/settings.json
/etc/init.d/transmission-daemon start

clear
echo "Done."
echo " "
echo "Web GUI: http://your ip:$port/"
echo "username: $username"
echo "password: $password"
echo "Configuration file  /var/lib/transmission-daemon/info/settings.json"