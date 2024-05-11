   　      　      　      　      　      　      　      　      　 仅适合梅林原版及改版　　修正原版及改版的定时任务缺陷与WiFi断流

1、U盘开机挂载及定时任务前提条件
   　   安装 <pre><code class="language-html">curl -Os https://diversion.ch/amtm/amtm && sh amtm</code></pre>
   　   使用 SSH 　　 输入amtm　　  安装USB disk check at boot　　到所有U盘分区 　　重启路由测试



2、【链接整合到第 4 点】在线更新SS规则 　 需要关闭插件自带定时　重启路由或者升级插件后失效 
     　   SSH输入
   　      　   <pre><code class="language-html">sed -i 's#^URL_MAIN.*#URL_MAIN="https://mirror.ghproxy.com/https%3A%2F%2Fraw.githubusercontent.com%2Fqxzg%2FActions%2F3.0%2Ffancyss_rules"#g' /koolshare/scripts/ss_rule_update.sh</code></pre>
   　   脚本定时任务：30 13 * * * /bin/sh /koolshare/scripts/ss_rule_update.sh #supdate#


3、【restart_wan.sh】定时重启wan  　只保留7天日志

   　   根据 5 来执行相关操作　　用amtm验证定时任务。
   　  
   　   脚本定时任务：0 5 * * 0,1,3,5 /jffs/scripts/restart_wan.sh #wan_reboot#

4、【copy_hosts.sh】自定义hosts  　可能经常更新  所以 只保留7天日志  重启路由器后 必须运行一次  否则与 2 同时失效
   　   
   　   整合了自定义规则的更新链接
   　   nano /jffs/scripts/hosts   编辑完毕  
   　   运行 /jffs/scripts/copy_hosts.sh
   　   执行killall -SIGHUP dnsmasq重启 dnsmasq 服务  
   　   脚本定时任务：0 10 * * 1 /jffs/scripts/copy_hosts.sh #hosts#
       
5、【set_crontab.sh】编辑定时任务 日志永久保留   重启路由器后 必须运行一次  否则失效
   　  
   　   编辑 nano /jffs/scripts/crontabs/klcb2010 完毕  运行 /jffs/scripts/set_crontab.sh
       
   　   即可更新定时任务
   　  

6、定时任务2 3 总结：

<pre><code class="language-html">0 5 * * 0,1,3,5 /jffs/scripts/restart_wan.sh #wan_reboot#
30 13 * * * /bin/sh /koolshare/scripts/ss_rule_update.sh #supdate#</code></pre>


7、【hosts-wan-cron.sh】一键导入上面三个脚本并运行
   　   /jffs/scripts/hosts-wan-cron.sh
