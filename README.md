# remoteshell
multi host remote shell

最近遇到一个任务，需要给所有服务器配置nginx插件naxis，用来放置xss攻击。<br>
由于大概需要配置30个服务器左右，人工操作起来还是太麻烦了，于是写了这个shell脚本一键批量配置。<br>

## expect.sh

这个是入口程序，负责配置所有服务器及密码，以及上传配置所需文件至服务器的/install目录。<br>
在上传完成配置所需文件后在服务器执行install.sh执行配置。<br>
项目中的install.sh和testdoc都是示例。<br>
实际使用中testdoc是naxis的规则文件mysite.rules以及nginx的配置文件nginx.conf等等，<br>
install.sh会将这些规则文件和nginx.conf等拷贝到响应的目录，然后重启nginx。<br>

```shell
#修改expect.sh,上传业务所需的文件，配置服务器和密码等
#修改install.sh,实现业务所需的shell脚本
sh expect.sh
```
