1、U盘开机挂载
   　   安装 <pre><code class="language-html">curl -Os https://diversion.ch/amtm/amtm && sh amtm</code></pre>
   　   使用 SSH 　　 输入amtm　　  安装USB disk check at boot　　到所有U盘分区 　　重启路由测试



2、在线更新SS规则 　　重启或者升级插件后失效
  SSH输入
   　      　   <pre><code class="language-html">sed -i 's/^URL_MAIN.*/URL_MAIN="https:\/\/raw.githubusercontent.com\/qxzg\/Actions\/3.0\/fancyss_rules"/g' /koolshare/scripts/ss_rule_update.sh</code></pre>



3、定时重启wan （crontabs文件夹及里边的klcb2010需要手动创建　　restart_wan.log以及set_crontab.log　　最后scripts文件夹赋值777）

   　   重启路由后需要手动运行"/jffs/scripts/set_crontab.sh"　　

   　   nano编辑定时任务：nano /jffs/scripts/crontabs/klcb2010
 
   　   Crtl+O保存　　enter确认　　Crtl+X退出

   　   然后执行/jffs/scripts/set_crontab.sh SSH　　用amtm验证定时任务。



4、自定义hosts   在/jffs/configs/目录下创建 hosts和dnsmasq.conf.add

   　   nano  /jffs/configs/hosts　　输入以hosts内容


   　   nano /jffs/configs/dnsmasq.conf.add　　输入 addn-hosts=/jffs/configs/hosts

   　   执行service restart_dnsmasq重启　　dnsmasq 服务
