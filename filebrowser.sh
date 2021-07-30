#!/bin/bash
#当前已经在CentOS7测试完毕，其它系统未测试。
yum -y install wget 
mkdir /root/app
cd /root/app
mkdir /root/app/filebrowser
cd /root/app/filebrowser


dir=$(pwd)
echo 当前目录:$dir
wget https://github.com/filebrowser/filebrowser/releases/download/v2.16.0/linux-amd64-filebrowser.tar.gz
tar -xzvf linux-amd64-filebrowser.tar.gz
mkdir /etc/filebrowser/
touch /etc/filebrowser/config.json


cd /etc/filebrowser/
read -t 35 -p "Input Home Folder(30秒内输入Filebrowser的家目录):" fb0
echo -e "\n"
echo "Home(家目录):$fb0"
sleep 1s
read -t 35 -p "Input Port(30秒内输入监听端口):" lp0
echo -e "\n"
echo "Port:$lp0"
echo -e "{\n\"address\":\"0.0.0.0\",\n\"database\":\"/etc/filebrowser/filebrowser.db\",\n\"log\":\"/var/log/filebrowser.log\",\n\"port\":$lp0,\n\"root\":\"$fb0\",\n\"username\":\"admin\"\n}\n" > config.json
chmod -R 0777 /media/public

sleep 1s
touch /etc/systemd/system/filebrowser.service
echo -e "[Unit]\nDescription=filebrowser daemon\n\n[Service]\nType=simple\nExecStart=/usr/bin/filebrowser -c /etc/filebrowser/config.json\n\n[Install]\nWantedBy=multi-user.target\n" > /etc/systemd/system/filebrowser.service


systemctl start filebrowser.service
sleep 2s

systemctl status filebrowser.service
sleep 3s

systemctl enable filebrowser.service
sleep 1s
echo -e " \n Filebrowser 搞定安装\n \n     建立在绝对路径：$fb0 \n \n     监听地址是$lp0\n"
