#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH
install_tmp='/tmp/bt_install.pl'
public_file=/www/server/panel/install/public.sh
if [ ! -f $public_file ];then
	wget -O $public_file http://download.bt.cn/install/public.sh -T 5;
fi
. $public_file
download_Url=$NODE_URL
pluginPath=/www/server/panel/plugin/masterslave

Install_masterslave()
{	
	isbt_pcre=`rpm -qa|grep bt-pcre`
	if [ "$isbt_pcre" != '' ];then
		rpm -e bt-pcre;
		yum reinstall pcre -y;
	fi
	mkdir -p $pluginPath
	echo '正在安装脚本文件...' > $install_tmp
	wget -O $pluginPath/masterslave_main.py $download_Url/install/lib/plugin/masterslave/masterslave_main.py -T 5
	wget -O $pluginPath/index.html $download_Url/install/lib/plugin/masterslave/index.html -T 5
	wget -O $pluginPath/info.json $download_Url/install/lib/plugin/masterslave/info.json -T 5
	wget -O $pluginPath/icon.png $download_Url/install/lib/plugin/masterslave/icon.png -T 5
	wget -O $pluginPath/install.sh $download_Url/install/lib/plugin/masterslave/install.sh -T 5
	\cp -a -r /www/server/panel/plugin/masterslave/icon.png /www/server/panel/static/img/soft_ico/ico-masterslave.png
	echo '安装完成' > $install_tmp
}

Uninstall_masterslave()
{
	rm -rf $pluginPath
}




if [ "${1}" == 'install' ];then
	Install_masterslave
elif [ "${1}" == 'uninstall' ];then
	Uninstall_masterslave
fi
