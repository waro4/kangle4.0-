PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH
#######
Main()
{
Loading
}

Loading()
{
rm -rf $0 >/dev/null 2>&1
clear 
echo
echo "正在启动搭建程序，预计需要30秒，请稍后...（如果30秒后没反应可重新连接服务器再试）
-----------"
#安装环境 避免因缺失环境出现错误
yum -y install wget curl openssl net-tools net-tools.x86_64 >/dev/null 2>&1
Home_page
}

Home_page()
{
clear
echo
echo "
==================================================================
		Openvpn流量控制系统 | 一键搭建脚本
                 Powered by kangml.com 2015-2021
                 本脚本👉Geela维护 2022-2-7 2:37
		       交流群 632088776
     温馨提示： 
         做最好的服务,做最好的搭建程序。
         禁止使用Centos7.x 64位以外的系统版本搭建！
         本脚本仅适用于学习与研究等个人用途,请勿用于任何违法国家法律的活动！
         谢谢各位老康！
==================================================================
回车Enter继续~
"
read
sleep 1
Install_Mean
}

Install_Mean()
{
clear
echo "
------------------------
1 - 安装康师傅流控 + APP
2 - 在线更新   >> （免重装一键更新流控程序）
3 - 流控负载   >> （集群服务器 负载均衡 账号共享）
4 - 制作代理APP    >> (生成代理APP)
------------------------
"
echo
read -p "请输入对应的数字并回车（默认全新安装）:" a
echo
k=$a
if [[ $k == 1 ]];then
Ntp_Date
fi
if [[ $k == 2 ]];then
Install_Update
fi
if [[ $k == 3 ]];then
Install_Fuzai
fi
if [[ $k == 4 ]];then
Install_App
fi
Ntp_Date
}

Ntp_Date()
{
rm -rf /etc/localtime >/dev/null 2>&1
cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime >/dev/null 2>&1
yum -y install ntpdate >/dev/null 2>&1
ntpdate time1.cloud.tencent.com >/dev/null 2>&1
sudo hwclock --systohc >/dev/null 2>&1
Check_OS
}

Check_OS()
{
if [ -f "/var/www/html" ];then
echo "
康师傅AI智能系统：检测到您已安装流控，如需要重新安装流控，请先给服务器重装系统！
"
fi
if [ ! -f "/root/bin/ps" ];then
echo "
【系统错误】可能是服务器环境问题导致～请联系客服！结束搭建。
"
fi
Install_Auth
}

Install_Update()
{
clear
cd /var/www/html/
wget -q https://raw.githubusercontent.com/waro4/kangle4.0-/main/kangml-update.zip
unzip -o kangml-update.zip >/dev/null 2>&1
chmod 777 -R ./ >/dev/null 2>&1
rm -rf kangml-update.zip >/dev/null 2>&1
echo "已经更新完毕！"
}

Install_Fuzai()
{
wget -q https://raw.githubusercontent.com/waro4/kangle4.0-/main/kangfz
}

Install_App()
{
wget -q https://raw.githubusercontent.com/waro4/kangle4.0-/main/kangapp
}

Install_Auth()
{
Close_SELinux
}

Close_SELinux()
{
setenforce 0 >/dev/null 2>&1
sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config >/dev/null 2>&1
Choose_Yum
}

Choose_Yum()
{
clear
echo "
在自动搭建之前，请先填写您的安装信息，不会填写可直接回车默认。
如出现^H这种特殊字符无法删除的可使用ctrl+退格键删除！
 
请选择安装源：
1 - 阿里云存储 >> （优先推荐，安装速度快）
2 - 本服务器系统默认 >> （安装出错时候可使用，速度略慢）
"
echo
read -p "请输入数字并回车（默认阿里云）：" b
echo
s=$b
if [[ $b == 1 ]];then
echo "已选择安装源：阿里云"
mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup >/dev/null 2>&1
wget -qO /etc/yum.repos.d/CentOS-Base.repo https://mirrors.aliyun.com/repo/Centos-7.repo >/dev/null 2>&1
wget -qO /etc/yum.repos.d/epel.repo http://mirrors.aliyun.com/repo/epel-7.repo >/dev/null 2>&1
yum install -y https://mirrors.aliyun.com/remi/enterprise/remi-release-7.rpm >/dev/null 2>&1
sed -i 's/https*:\/\/rpms.remirepo.net/https:\/\/mirrors.aliyun.com\/remi/g' /etc/yum.repos.d/remi-glpi91.repo /etc/yum.repos.d/remi-glpi92.repo /etc/yum.repos.d/remi-glpi93.repo /etc/yum.repos.d/remi-glpi94.repo /etc/yum.repos.d/remi-modular.repo /etc/yum.repos.d/remi-php54.repo /etc/yum.repos.d/remi-php70.repo /etc/yum.repos.d/remi-php71.repo /etc/yum.repos.d/remi-php72.repo /etc/yum.repos.d/remi-php73.repo /etc/yum.repos.d/remi-php74.repo /etc/yum.repos.d/remi-php80.repo /etc/yum.repos.d/remi-php81.repo /etc/yum.repos.d/remi.repo /etc/yum.repos.d/remi.repo.rpmnew /etc/yum.repos.d/remi-safe.repo >/dev/null 2>&1
sed -i 's/#baseurl/baseurl/g' /etc/yum.repos.d/remi-glpi91.repo /etc/yum.repos.d/remi-glpi92.repo /etc/yum.repos.d/remi-glpi93.repo /etc/yum.repos.d/remi-glpi94.repo /etc/yum.repos.d/remi-modular.repo /etc/yum.repos.d/remi-php54.repo /etc/yum.repos.d/remi-php70.repo /etc/yum.repos.d/remi-php71.repo /etc/yum.repos.d/remi-php72.repo /etc/yum.repos.d/remi-php73.repo /etc/yum.repos.d/remi-php74.repo /etc/yum.repos.d/remi-php80.repo /etc/yum.repos.d/remi-php81.repo /etc/yum.repos.d/remi.repo /etc/yum.repos.d/remi.repo.rpmnew /etc/yum.repos.d/remi-safe.repo >/dev/null 2>&1
sed -i 's|^mirrorlist|#mirrorlist|' /etc/yum.repos.d/remi-glpi91.repo /etc/yum.repos.d/remi-glpi92.repo /etc/yum.repos.d/remi-glpi93.repo /etc/yum.repos.d/remi-glpi94.repo /etc/yum.repos.d/remi-modular.repo /etc/yum.repos.d/remi-php54.repo /etc/yum.repos.d/remi-php70.repo /etc/yum.repos.d/remi-php71.repo /etc/yum.repos.d/remi-php72.repo /etc/yum.repos.d/remi-php73.repo /etc/yum.repos.d/remi-php74.repo /etc/yum.repos.d/remi-php80.repo /etc/yum.repos.d/remi-php81.repo /etc/yum.repos.d/remi.repo /etc/yum.repos.d/remi.repo.rpmnew /etc/yum.repos.d/remi-safe.repo >/dev/null 2>&1
yum clean all >/dev/null 2>&1
yum makecache >/dev/null 2>&1
yum -y install yum-utils >/dev/null 2>&1
Install_Command
fi
if [[ $b == 2 ]];then
echo "已选择安装源：备用"
mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup >/dev/null 2>&1
wget -qO /etc/yum.repos.d/CentOS-Base.repo https://mirrors.aliyun.com/repo/Centos-7.repo >/dev/null 2>&1
wget -qO /etc/yum.repos.d/epel.repo http://mirrors.aliyun.com/repo/epel-7.repo >/dev/null 2>&1
yum install -y https://mirrors.aliyun.com/remi/enterprise/remi-release-7.rpm >/dev/null 2>&1
sed -i 's/https*:\/\/rpms.remirepo.net/https:\/\/mirrors.aliyun.com\/remi/g' /etc/yum.repos.d/remi-glpi91.repo /etc/yum.repos.d/remi-glpi92.repo /etc/yum.repos.d/remi-glpi93.repo /etc/yum.repos.d/remi-glpi94.repo /etc/yum.repos.d/remi-modular.repo /etc/yum.repos.d/remi-php54.repo /etc/yum.repos.d/remi-php70.repo /etc/yum.repos.d/remi-php71.repo /etc/yum.repos.d/remi-php72.repo /etc/yum.repos.d/remi-php73.repo /etc/yum.repos.d/remi-php74.repo /etc/yum.repos.d/remi-php80.repo /etc/yum.repos.d/remi-php81.repo /etc/yum.repos.d/remi.repo /etc/yum.repos.d/remi.repo.rpmnew /etc/yum.repos.d/remi-safe.repo >/dev/null 2>&1
sed -i 's/#baseurl/baseurl/g' /etc/yum.repos.d/remi-glpi91.repo /etc/yum.repos.d/remi-glpi92.repo /etc/yum.repos.d/remi-glpi93.repo /etc/yum.repos.d/remi-glpi94.repo /etc/yum.repos.d/remi-modular.repo /etc/yum.repos.d/remi-php54.repo /etc/yum.repos.d/remi-php70.repo /etc/yum.repos.d/remi-php71.repo /etc/yum.repos.d/remi-php72.repo /etc/yum.repos.d/remi-php73.repo /etc/yum.repos.d/remi-php74.repo /etc/yum.repos.d/remi-php80.repo /etc/yum.repos.d/remi-php81.repo /etc/yum.repos.d/remi.repo /etc/yum.repos.d/remi.repo.rpmnew /etc/yum.repos.d/remi-safe.repo >/dev/null 2>&1
sed -i 's|^mirrorlist|#mirrorlist|' /etc/yum.repos.d/remi-glpi91.repo /etc/yum.repos.d/remi-glpi92.repo /etc/yum.repos.d/remi-glpi93.repo /etc/yum.repos.d/remi-glpi94.repo /etc/yum.repos.d/remi-modular.repo /etc/yum.repos.d/remi-php54.repo /etc/yum.repos.d/remi-php70.repo /etc/yum.repos.d/remi-php71.repo /etc/yum.repos.d/remi-php72.repo /etc/yum.repos.d/remi-php73.repo /etc/yum.repos.d/remi-php74.repo /etc/yum.repos.d/remi-php80.repo /etc/yum.repos.d/remi-php81.repo /etc/yum.repos.d/remi.repo /etc/yum.repos.d/remi.repo.rpmnew /etc/yum.repos.d/remi-safe.repo >/dev/null 2>&1
yum clean all >/dev/null 2>&1
yum makecache >/dev/null 2>&1
yum -y install yum-utils >/dev/null 2>&1
Install_Command
fi
echo "已选择安装源：阿里云"
mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup >/dev/null 2>&1
wget -qO /etc/yum.repos.d/CentOS-Base.repo https://mirrors.aliyun.com/repo/Centos-7.repo >/dev/null 2>&1
wget -qO /etc/yum.repos.d/epel.repo http://mirrors.aliyun.com/repo/epel-7.repo >/dev/null 2>&1
yum install -y https://mirrors.aliyun.com/remi/enterprise/remi-release-7.rpm >/dev/null 2>&1
sed -i 's/https*:\/\/rpms.remirepo.net/https:\/\/mirrors.aliyun.com\/remi/g' /etc/yum.repos.d/remi-glpi91.repo /etc/yum.repos.d/remi-glpi92.repo /etc/yum.repos.d/remi-glpi93.repo /etc/yum.repos.d/remi-glpi94.repo /etc/yum.repos.d/remi-modular.repo /etc/yum.repos.d/remi-php54.repo /etc/yum.repos.d/remi-php70.repo /etc/yum.repos.d/remi-php71.repo /etc/yum.repos.d/remi-php72.repo /etc/yum.repos.d/remi-php73.repo /etc/yum.repos.d/remi-php74.repo /etc/yum.repos.d/remi-php80.repo /etc/yum.repos.d/remi-php81.repo /etc/yum.repos.d/remi.repo /etc/yum.repos.d/remi.repo.rpmnew /etc/yum.repos.d/remi-safe.repo >/dev/null 2>&1
sed -i 's/#baseurl/baseurl/g' /etc/yum.repos.d/remi-glpi91.repo /etc/yum.repos.d/remi-glpi92.repo /etc/yum.repos.d/remi-glpi93.repo /etc/yum.repos.d/remi-glpi94.repo /etc/yum.repos.d/remi-modular.repo /etc/yum.repos.d/remi-php54.repo /etc/yum.repos.d/remi-php70.repo /etc/yum.repos.d/remi-php71.repo /etc/yum.repos.d/remi-php72.repo /etc/yum.repos.d/remi-php73.repo /etc/yum.repos.d/remi-php74.repo /etc/yum.repos.d/remi-php80.repo /etc/yum.repos.d/remi-php81.repo /etc/yum.repos.d/remi.repo /etc/yum.repos.d/remi.repo.rpmnew /etc/yum.repos.d/remi-safe.repo >/dev/null 2>&1
sed -i 's|^mirrorlist|#mirrorlist|' /etc/yum.repos.d/remi-glpi91.repo /etc/yum.repos.d/remi-glpi92.repo /etc/yum.repos.d/remi-glpi93.repo /etc/yum.repos.d/remi-glpi94.repo /etc/yum.repos.d/remi-modular.repo /etc/yum.repos.d/remi-php54.repo /etc/yum.repos.d/remi-php70.repo /etc/yum.repos.d/remi-php71.repo /etc/yum.repos.d/remi-php72.repo /etc/yum.repos.d/remi-php73.repo /etc/yum.repos.d/remi-php74.repo /etc/yum.repos.d/remi-php80.repo /etc/yum.repos.d/remi-php81.repo /etc/yum.repos.d/remi.repo /etc/yum.repos.d/remi.repo.rpmnew /etc/yum.repos.d/remi-safe.repo >/dev/null 2>&1
yum clean all >/dev/null 2>&1
yum makecache >/dev/null 2>&1
yum -y install yum-utils >/dev/null 2>&1
Install_Command
}

Install_Options()
{
IP=`curl -s ip.3322.net`;
wangka1=`ifconfig`;wangka2=`echo $wangka1|awk '{print $1}'`;wangka=${wangka2/:/};
clear
echo
sleep 1
read -p "填写管理后台自定义地址后缀(回车默认admin)：" Web
if [ -z "$Web" ];then
Web=admin
fi
echo -e "已设置管理后台自定义地址后缀："$Web""
	
echo
read -p "填写后台管理员账号(回车默认admin)：" User
if [ -z "$User" ];then
User=admin
fi
echo -e "已设置后台管理员账号："$User""
	
echo
read -p "填写后台管理员密码(为了安全，请不要密码设置123456这么简单的，回车默认随机)：" Pwd
if [ -z "$Pwd" ];then
Pwd=`date +%s%N | md5sum | head -c 6 ; echo`;
fi
echo -e "已设置后台管理员密码："$Pwd""
	
echo
read -p "填写后台管理员安全码(为了安全，请不要密码设置123456这么简单的，回车默认随机)：" Pwd2
if [ -z "$Pwd2" ];then
Pwd2=`date +%s%N | md5sum | head -c 6 ; echo`;
fi
echo -e "已设置后台管理员安全码："$Pwd2""
	
echo
read -p "填写数据库目录名字(5-10个英文字母，为了安全，请不要设置admin和mysql，不要和管理员目录相同，回车随机)：" Sql
if [ -z "$Sql" ];then
Sql=`date +%s%N | md5sum | head -c 10 ; echo`;
fi
echo -e "已设置数据库目录名字："$Sql""

echo
read -p "填写数据库密码(为了安全，请不要密码设置123456这么简单的，回车默认随机)：" SqlPwd
if [ -z "$SqlPwd" ];then
SqlPwd=`date +%s%N | md5sum | head -c 10 ; echo`;
fi
echo -e "已设置数据库目录密码："$SqlPwd""

echo
read -p "填写APP名字(回车默认：极速加速器)：" AppName
if [ -z "$AppName" ];then
AppName=极速加速器
fi
echo -e "已设置APP名字："$AppName""
	
echo
read -p "填写APP解析的IP地址(可输入域名或IP，不带http://和端口号，回车默认：本服务器的IP)：" Appip
if [ -z "$Appip" ];then
Appip=$IP
fi
echo -e "已设置APP解析的IP地址："$Appip""
	
sleep 1
echo "
所有安装信息已设置保存完成！
请回车开始无人全自动搭建系统：
"
read
clear
echo "
>>>开始搭建，预计花费几分钟，趁这个时间去喝杯茶吧！
【搭建的时候，进度条卡住是正常的，不要动它，请耐心等待】
"
sleep 5
}

Install_Dependency_File()
{
echo "【1/7】配置环境（预计1-2分钟）"
yum -y install openvpn >/dev/null 2>&1
yum-config-manager --enable remi-php74 >/dev/null 2>&1
echo "[#################################################] 100%"
}

Install_firewall()
{
echo "【2/7】安装并配置防火墙（预计30秒）"
systemctl stop firewalld.service > /dev/null 2>&1
systemctl disable firewalld.service > /dev/null 2>&1
yum install iptables iptables-services -y >/dev/null 2>&1
systemctl stop iptables.service
systemctl preset iptables.service ip6tables.service >/dev/null 2>&1
systemctl start iptables.service >/dev/null 2>&1
iptables -F
service iptables save
iptables -A INPUT -s 127.0.0.1/32 -j ACCEPT
iptables -A INPUT -d 127.0.0.1/32 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 22 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 1234 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 80 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 137 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 138 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 440 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 443 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 1024 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 1194 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 1195 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 1196 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 1197 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 3306 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 3389 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 8080 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 8091 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 8128 -j ACCEPT
iptables -A INPUT -p udp -m udp --dport 123 -j ACCEPT
iptables -A INPUT -p udp -m udp --dport 137 -j ACCEPT
iptables -A INPUT -p udp -m udp --dport 138 -j ACCEPT
iptables -A INPUT -p udp -m udp --dport 161 -j ACCEPT
iptables -A INPUT -p udp -m udp --dport 636 -j ACCEPT
iptables -A INPUT -p udp -m udp --dport 1194 -j ACCEPT
iptables -A INPUT -p udp -m udp --dport 3389 -j ACCEPT
iptables -A INPUT -p udp -m udp --dport 6868 -j ACCEPT
iptables -A INPUT -p udp -m udp --dport 8060 -j ACCEPT
iptables -A INPUT -p udp -m udp --dport 5353 -j ACCEPT
iptables -A INPUT -p udp -m udp --dport 3848 -j ACCEPT
iptables -A INPUT -p udp -m udp --dport 53 -j ACCEPT
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A OUTPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -P INPUT DROP
iptables -t nat -A PREROUTING -p udp --dport 67 -j REDIRECT --to-ports 53
iptables -t nat -A PREROUTING -p udp --dport 68 -j REDIRECT --to-ports 53
iptables -t nat -A PREROUTING -p udp --dport 69 -j REDIRECT --to-ports 53
iptables -t nat -A PREROUTING -p udp --dport 123 -j REDIRECT --to-ports 53
iptables -t nat -A PREROUTING -p udp --dport 636 -j REDIRECT --to-ports 53
iptables -t nat -A PREROUTING -p udp --dport 161 -j REDIRECT --to-ports 53
iptables -t nat -A PREROUTING -p udp --dport 5353 -j REDIRECT --to-ports 53
iptables -t nat -A PREROUTING -p udp --dport 6868 -j REDIRECT --to-ports 53
iptables -t nat -A PREROUTING -p udp --dport 3389 -j REDIRECT --to-ports 53
iptables -t nat -A PREROUTING -p udp --dport 138 -j REDIRECT --to-ports 53
iptables -t nat -A PREROUTING -p udp --dport 137 -j REDIRECT --to-ports 53
iptables -t nat -A PREROUTING -p udp --dport 1194 -j REDIRECT --to-ports 53
iptables -t nat -A PREROUTING -p udp --dport 1195 -j REDIRECT --to-ports 53
iptables -t nat -A PREROUTING -p udp --dport 1196 -j REDIRECT --to-ports 53
iptables -t nat -A PREROUTING -p udp --dport 1197 -j REDIRECT --to-ports 53
iptables -t nat -A PREROUTING -p udp --dport 8060 -j REDIRECT --to-ports 53
iptables -t nat -A PREROUTING -p udp --dport 3848 -j REDIRECT --to-ports 53
iptables -t nat -A PREROUTING --dst 10.8.0.1 -p udp --dport 53 -j DNAT --to-destination 10.8.0.1:5353
iptables -t nat -A PREROUTING --dst 10.9.0.1 -p udp --dport 53 -j DNAT --to-destination 10.9.0.1:5353
iptables -t nat -A PREROUTING --dst 10.10.0.1 -p udp --dport 53 -j DNAT --to-destination 10.10.0.1:5353
iptables -t nat -A PREROUTING --dst 10.11.0.1 -p udp --dport 53 -j DNAT --to-destination 10.11.0.1:5353
iptables -t nat -A PREROUTING --dst 10.12.0.1 -p udp --dport 53 -j DNAT --to-destination 10.12.0.1:5353
iptables -t nat -A POSTROUTING -s 10.8.0.0/24 -j MASQUERADE
iptables -t nat -A POSTROUTING -s 10.9.0.0/24 -j MASQUERADE
iptables -t nat -A POSTROUTING -s 10.10.0.0/24 -j MASQUERADE
iptables -t nat -A POSTROUTING -s 10.11.0.0/24 -j MASQUERADE
iptables -t nat -A POSTROUTING -s 10.12.0.0/24 -j MASQUERADE
iptables -A INPUT -p icmp --icmp-type echo-request -j ACCEPT
iptables -A OUTPUT -p icmp --icmp-type echo-reply -j ACCEPT
service iptables save

systemctl restart iptables.service > /dev/null 2>&1
systemctl enable iptables.service > /dev/null 2>&1
echo "[#################################################] 100%"
}

Install_Web()
{
echo "【3/7】安装WEB服务（预计1-2分钟）"
echo '#kangml配置 net.ipv4.ip_forward = 1 net.core.rmem_max=10485760 net.core.wmem_max=10485760 net.core.rmem_default=1048576 net.core.wmem_default=1048576' > /etc/sysctl.conf
chmod -R 0777 /etc/sysctl.conf > /dev/null 2>&1
sysctl -p /etc/sysctl.conf > /dev/null 2>&1
yum -y install epel-release > /dev/null 2>&1
yum -y install telnet avahi openssl-libs openssl-devel lzo lzo-devel > /dev/null 2>&1
yum -y install pam pam-devel > /dev/null 2>&1
yum -y install automake pkgconfig gawk tar zip unzip net-tools psmisc gcc pkcs11-helper libxml2 libxml2-devel bzip2 bzip2-devel libcurl libcurl-devel libjpeg libjpeg-devel libpng libpng-devel freetype freetype-devel gmp gmp-devel libmcrypt libmcrypt-devel readline readline-devel libxslt libxslt-devel > /dev/null 2>&1
yum -y install mariadb mariadb-server dnsmasq jre-1.7.0-openjdk crontabs lsof > /dev/null 2>&1
yum install -y php74 php74-php-devel php74-php-fpm php74-php-mbstring php74-php-memcache php74-php-memcached php74-php-redis php74-php-mysqlnd php74-php-pdo php74-php-bcmath php74-php-xml php74-php-gd php74-php-gmp php74-php-igbinary php74-php-imagick php74-php-mcrypt php74-php-pdo_mysql php74-php-posix php74-php-simplexml php74-php-opcache php74-php-xsl php74-php-xmlwriter php74-php-xmlreader php74-php-swoole php74-php-zip php74-php-phalcon php74-php-yaml php74-php-yar php74-php-yaf php74-php-uuid > /dev/null 2>&1
rpm -Uvh https://raw.githubusercontent.com/waro4/kangle4.0-/main/liblz4-1.8.1.2-alt1.x86_64.rpm --force --nodeps > /dev/null 2>&1
rpm -Uvh https://raw.githubusercontent.com/waro4/kangle4.0-/main/openvpn-2.4.3-1.el7.x86_64.rpm --force --nodeps > /dev/null 2>&1
systemctl start mariadb.service > /dev/null 2>&1
mysqladmin -uroot password ''$SqlPwd'' > /dev/null 2>&1
mysql -uroot -p''$SqlPwd'' -e 'create database vpndata;' > /dev/null 2>&1
systemctl restart mariadb.service > /dev/null 2>&1
echo '[nginx-stable] name=nginx stable repo baseurl=http://nginx.org/packages/centos/$releasever/$basearch/ gpgcheck=1 enabled=1 gpgkey=https://nginx.org/keys/nginx_signing.key module_hotfixes=true ' > /etc/yum.repos.d/nginx.repo > /dev/null 2>&1
yum makecache > /dev/null 2>&1
yum install -y nginx > /dev/null 2>&1
mkdir -p /var/www/html
rm -rf /etc/nginx/conf.d/default.conf > /dev/null 2>&1
wget -qO /etc/nginx/conf.d/default.conf https://raw.githubusercontent.com/waro4/kangle4.0-/main/default.conf > /dev/null 2>&1
sed -i 's/listen 80/listen 1234/g' /etc/nginx/conf.d/default.conf > /dev/null 2>&1
systemctl start nginx > /dev/null 2>&1
wget -q https://raw.githubusercontent.com/waro4/kangle4.0-/main/ixed.7.4.lin -P /opt/remi/php74/root/usr/lib64/php/modules/ > /dev/null 2>&1
echo ' extension=ixed.7.4.lin' >> /etc/opt/remi/php74/php.ini
chmod 777 /var/opt/remi/php74/lib/php/session > /dev/null 2>&1
ln -s /bin/php74 /bin/php > /dev/null 2>&1
systemctl start php74-php-fpm > /dev/null 2>&1
rm -rf /etc/dnsmasq.conf > /dev/null 2>&1
wget -q https://raw.githubusercontent.com/waro4/kangle4.0-/main/dnsmasq.conf -P /etc > /dev/null 2>&1
chmod 0777 /etc/dnsmasq.conf > /dev/null 2>&1
echo '#kangml自定义屏蔽host文件 ' >> /etc/kangml_host
chmod 0777 /etc/kangml_host > /dev/null 2>&1
echo '#广告屏蔽:列：127.0.0.1 www.kangml.com ' >> /etc/AD.conf
chmod 0777 /etc/AD.conf > /dev/null 2>&1
systemctl start dnsmasq.service > /dev/null 2>&1
systemctl restart crond.service > /dev/null 2>&1
echo "[#################################################] 100%"
}

Install_OpenVPN()
{
echo "【4/7】安装OPENVPN主程序（预计30秒）"
cd /etc/openvpn > /dev/null 2>&1
rm -rf /etc/openvpn/client /etc/openvpn/server > /dev/null 2>&1
wget -q https://raw.githubusercontent.com/waro4/kangle4.0-/main/openvpn.zip > /dev/null 2>&1
cd /etc/openvpn > /dev/null 2>&1
unzip -o openvpn.zip > /dev/null 2>&1
rm -rf openvpn.zip > /dev/null 2>&1
chmod 0777 -R /etc/openvpn > /dev/null 2>&1
sed -i 's/newpass/'$SqlPwd'/g' /etc/openvpn/auth_config.conf > /dev/null 2>&1
sed -i 's/服务器IP/'$IP'/g' /etc/openvpn/auth_config.conf > /dev/null 2>&1
echo "[#################################################] 100%"
}

Install_RuoZhiKang()
{
echo "【5/7】安装康师傅流控（预计30秒）"
cd
wget -q https://raw.githubusercontent.com/waro4/kangle4.0-/main/shvpn > /dev/null 2>&1
chmod 777 shvpn > /dev/null 2>&1
./shvpn 1 > /dev/null 2>&1
# rm -rf ./shvpn > /dev/null 2>&1
systemctl start crond.service
crontab -l > /tmp/crontab1200
echo '0 1 * * * /bin/vpn cleanuser #每天凌晨1点清理未激活用户 55 23 * * * php /var/www/html/admin/cron.php #每天23:55统计用户和代理' >> /tmp/crontab.1200
crontab /tmp/crontab.1200 > /dev/null 2>&1
systemctl restart crond.service
mkdir /etc/rate.d/
chmod -R 0777 /etc/rate.d/ > /dev/null 2>&1
wget -q https://raw.githubusercontent.com/waro4/kangle4.0-/main/res.zip > /dev/null 2>&1
unzip -o res.zip > /dev/null 2>&1
chmod -R 0777 /root > /dev/null 2>&1
rm -rf /root/res.zip > /dev/null 2>&1
mv /root/res/kangml.service /lib/systemd/system/kangml.service > /dev/null 2>&1
chmod -R 0777 /lib/systemd/system/kangml.service > /dev/null 2>&1
systemctl enable kangml.service
cd /bin > /dev/null 2>&1
wget -q https://raw.githubusercontent.com/waro4/kangle4.0-/main/bin.zip > /dev/null 2>&1
cd /bin > /dev/null 2>&1
unzip -o bin.zip > /dev/null 2>&1
rm -rf /bin/bin.zip > /dev/null 2>&1
chmod -R 0777 /bin > /dev/null 2>&1
rm -rf /var/www/html > /dev/null 2>&1
cd /var/www > /dev/null 2>&1
wget -q https://raw.githubusercontent.com/waro4/kangle4.0-/main/kangml_web.zip > /dev/null 2>&1
unzip -o kangml_web.zip > /dev/null 2>&1
rm -rf kangml_web.zip > /dev/null 2>&1
chmod 0777 -R /var/www/html > /dev/null 2>&1
mv /var/www/html/admin /var/www/html/$Web > /dev/null 2>&1
sed -i 's/kangmladmin/'$User'/g' /var/www/vpndata.sql > /dev/null 2>&1
sed -i 's/kangmlpass/'$Pwd'/g' /var/www/vpndata.sql > /dev/null 2>&1
sed -i 's/服务器IP/'$IP'/g' /var/www/vpndata.sql > /dev/null 2>&1
mysql -uroot -p''$SqlPwd'' vpndata < /var/www/vpndata.sql > /dev/null 2>&1
rm -rf /var/www/vpndata.sql > /dev/null 2>&1
sed -i 's/newpass/'$SqlPwd'/g' /var/www/html/config.php > /dev/null 2>&1
echo ''$Pwd2'' > /var/www/auth_key.access
mv /var/www/html/phpmyadmin /var/www/html/$Sql > /dev/null 2>&1
echo "[#################################################] 100%"
}

Install_App()
{
echo "【6/7】制作APP（预计1-2分钟）"
rm -rf /APP > /dev/null 2>&1
mkdir /APP > /dev/null 2>&1
cd /APP > /dev/null 2>&1
wget -q https://raw.githubusercontent.com/waro4/kangle4.0-/main/kangml.apk > /dev/null 2>&1
wget -q https://raw.githubusercontent.com/waro4/kangle4.0-/main/apktool.jar > /dev/null 2>&1
java -jar apktool.jar d kangml.apk > /dev/null 2>&1
rm -rf kangml.apk > /dev/null 2>&1
sed -i 's/Kangml/'$AppName'/g' /APP/kangml/res/values/strings.xml > /dev/null 2>&1
sed -i 's/82.156.8.26/'$IP'/g' /APP/kangml/res/values/strings.xml > /dev/null 2>&1
sed -i 's/dailiid/'0'/g' /APP/kangml/res/values/strings.xml > /dev/null 2>&1
java -jar apktool.jar b kangml > /dev/null 2>&1
wget -q https://raw.githubusercontent.com/waro4/kangle4.0-/main/signer.zip > /dev/null 2>&1
unzip -o signer.zip > /dev/null 2>&1
mv /APP/kangml/dist/kangml.apk /APP/kangml.apk > /dev/null 2>&1
java -jar signapk.jar testkey.x509.pem testkey.pk8 /APP/kangml.apk /APP/kangml_sign.apk > /dev/null 2>&1
rm -rf /var/www/html/kangmlapp.apk > /dev/null 2>&1
cp -rf /APP/kangml_sign.apk /var/www/html/kangmlapp.apk > /dev/null 2>&1
rm -rf /APP > /dev/null 2>&1
cd
echo "[#################################################] 100%"
}

Install_Check()
{
echo "【7/7】检查安装是否完成"
systemctl restart iptables.service > /dev/null 2>&1
systemctl restart mariadb.service > /dev/null 2>&1
systemctl restart nginx > /dev/null 2>&1
systemctl restart php74-php-fpm > /dev/null 2>&1
systemctl restart dnsmasq.service > /dev/null 2>&1
systemctl restart crond.service > /dev/null 2>&1
systemctl restart openvpn@server-tcp > /dev/null 2>&1
systemctl restart openvpn@server-udp > /dev/null 2>&1
echo "[#################################################] 100%"
}

Install_complete()
{
clear
echo "
恭喜您！康师傅流量控制系统搭建成功啦~
-----------------------------------
管理员后台: http://"$IP":1234/"$Web"
管理员账号: "$User"
管理员密码: "$Pwd"
管理员口令: "$Pwd2"
-----------------------------------
数据库地址: http://"$IP":1234/"$Sql"
数据库账号: root
数据库密码: "$SqlPwd"
-----------------------------------
代理中心: http://"$IP":1234/daili
用户中心: http://"$IP":1234
-----------------------------------
APP下载地址: http://"$IP":1234/kangmlapp.apk
PC软件下载地址: https://wwa.lanzous.com/u/66fz8
IOS软件: 使用国际ID 搜索openvpn即可
-----------------------------------
重启VPN：vpn restart
关闭VPN：vpn stop
解锁管理后台：onadmin
锁定管理后台：offadmin
开端口：port
进程守护：shvpn
-----------------------------------
流控使用帮助：请阅读管理后台右上角【帮助中心】
如果搭建完成后无法访问后台请配置好安全组/防火墙，开放全部端口
安装信息保存在/home/messages.txt
" >> /home/messages.txt
cat /home/messages.txt
}

Install_Last()
{
echo "恭喜您，搭建完成！
输入回车结束搭建，并重启VPN："
read
vpn restart
shvpn 3 > /dev/null 2>&1
shvpn 4 > /dev/null 2>&1
shvpn 3
sed -i "s/FasAUTH.bin/kangml_auth.bin/g" /var/www/html/''$Web''/admin.php > /dev/null 2>&1
echo "感谢使用Geela一键搭建OpenVpn康师傅流控脚本~"
exit;0
}

Install_Command()
{
	#变量安装命令
	Install_Options
	Install_Dependency_File
	Install_firewall
	Install_Web
	Install_OpenVPN
	Install_RuoZhiKang
	Install_App
	Install_Check
	Install_complete
	Install_Last
}

Main
exit;0
