#!/usr/bin/bash

#服务器列表
hosts=(
	"1.a.com"
	"2.a.com"
	"3.a.com"
)
#服务器密码
password="password"

for host in ${hosts[@]}
do
	/usr/bin/expect <<-EOF
		set timeout 30
		#sftp上传文件至服务器的/install目录
		spawn sftp root@$host
		expect {
			"Are you sure you want to continue connecting (yes/no)?" {send "yes\r"; exp_continue}
			"*password:*" {send "$password\r"}
		}
		expect "sftp> "
		send "mkdir /install\r"
		expect "sftp> "
		send "cd /install\r"
		expect "sftp> " 
		send "put testdoc\r"
		expect "sftp> " 
		send "put install.sh\r"
		expect "sftp> "
		send "exit\r"
		expect eof
		#ssh至服务器执行install.sh
		spawn ssh root@$host
		expect {
			"Are you sure you want to continue connecting (yes/no)?" {send "yes\r"; exp_continue}
			"*password:*" {send "$password\r"}
		}
		expect "*root*"
		send "sh /install/install.sh\r"
		expect "install complete\r"
		send "cd .\r"
		expect "root"
		send "exit\r"
		expect eof
	EOF
done
