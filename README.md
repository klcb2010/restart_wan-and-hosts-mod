1、U盘开机挂载
安装 curl -Os https://diversion.ch/amtm/amtm && sh amtm
使用 SSH  输入amtm  安装USB disk check at boot 到所有U盘分区  重启路由测试

2、在线更新SS规则 重启或者升级插件后失效
SSH  输入
sed -i 's/^URL_MAIN.*/URL_MAIN="https:\/\/raw.githubusercontent.com\/qxzg\/Actions\/3.0\/fancyss_rules"/g' /koolshare/scripts/ss_rule_update.sh

3、定时重启wan （crontabs文件夹及里边的klcb2010需要手动创建，restart_wan.log以及set_crontab.log，最后scripts文件夹赋值777）
重启路由需要手动运行"/jffs/scripts/set_crontab.sh"，
nano编辑定时任务：nano /jffs/scripts/crontabs/klcb2010
 Crtl+O保存enter确认  Crtl+X退出
然后执行/jffs/scripts/set_crontab.sh SSH，用amtm验证定时任务。

4自定义hosts   在/jffs/configs/目录下创建 hosts和dnsmasq.conf.add
nano  /jffs/configs/hosts    输入以下内容
127.0.0.1 f12.baidu.com
127.0.0.1 t-dsp.pinduoduo.com
127.0.0.1 luimg.baidu.com
127.0.0.1 wn.pos.baidu.com
127.0.0.1 mobads.baidu.com
127.0.0.1 ulogs.umeng.com
127.0.0.1 ulogs.umengcloud.com
127.0.0.1 ios.bugly.com
127.0.0.1 showapi.babybus.com
127.0.0.1 union.baidu.com
127.0.0.1 two.fsylr.com
127.0.0.1 arms-retcode.aliyuncs.com
127.0.0.1 ott.da.mgtv.com
127.0.0.1 ys.da.mgtv.com
127.0.0.1 img.da.mgtv.com
127.0.0.1 luimg.baidu.com
127.0.0.1 wn.pos.baidu.com
127.0.0.1 mobads.baidu.com
127.0.0.1 ulogs.umeng.com
127.0.0.1 ulogs.umengcloud.com
127.0.0.1 ios.bugly.com
127.0.0.1 showapi.babybus.com
127.0.0.1 hm.baidu.com
127.0.0.1 mbd.baidu.com
127.0.0.1 erebor.douban.com
127.0.0.1 googletagmanager.com
127.0.0.1 googlesyndication.com
127.0.0.1 at3.doubanio.com
127.0.0.1 mbd.baidu.com
127.0.0.1 f12.baidu.com
127.0.0.1 t-dsp.pinduoduo.com
127.0.0.1 luimg.baidu.com
127.0.0.1 wn.pos.baidu.com
127.0.0.1 mobads.baidu.com
127.0.0.1 ulogs.umeng.com
127.0.0.1 ulogs.umengcloud.com
127.0.0.1 ios.bugly.com
127.0.0.1 showapi.babybus.com
127.0.0.1 hm.baidu.com
127.0.0.1 mbd.baidu.com
127.0.0.1 erebor.douban.com
127.0.0.1 googletagmanager.com
127.0.0.1 googlesyndication.com
127.0.0.1 at3.doubanio.com
127.0.0.1 mbd.baidu.com


nano /jffs/configs/dnsmasq.conf.add  输入 addn-hosts=/jffs/configs/hosts

执行service restart_dnsmasq重启 dnsmasq 服务