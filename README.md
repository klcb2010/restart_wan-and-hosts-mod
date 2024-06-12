   　      　      　      　      　      　      　      　      　 仅适合梅林原版及改版　　用于修正原版及改版的定时任务缺陷与WiFi断流

1、U盘开机挂载及定时任务前提条件
   　   安装 <pre><code class="language-html">/usr/sbin/curl -Os https://diversion.ch/amtm/amtm && sh amtm</code></pre>
   　   使用 SSH 　　 输入amtm　　  安装USB disk check at boot　　到所有U盘分区 　　重启路由测试



2、【链接已经整合到第 4 点】在线更新SS规则 　 需要关闭插件自带定时　重启路由或者升级插件后失效 
     　   SSH输入
   　      　   <pre><code class="language-html">sed -i 's#^URL_MAIN.*#URL_MAIN="https://mirror.ghproxy.com/https%3A%2F%2Fraw.githubusercontent.com%2Fqxzg%2FActions%2F3.0%2Ffancyss_rules"#g' /koolshare/scripts/ss_rule_update.sh</code></pre>
   　   脚本定时任务：30 13 * * * /bin/sh /koolshare/scripts/ss_rule_update.sh #supdate#


3、【restart_wan.sh】定时重启wan  　只保留7天日志

   　   根据 5 来执行相关操作　　用amtm验证定时任务。
   　  
   　   脚本定时任务：0 5 * * 0,1,3,5 /jffs/scripts/restart_wan.sh #wan_reboot#

4、已删除  与SS插件冲突
       
5、【set_crontab.sh】编辑定时任务 日志永久保留   重启路由器后 必须运行一次  否则失效
   　  
   　   编辑 nano /jffs/scripts/crontabs/klcb2010 完毕  运行 /jffs/scripts/set_crontab.sh
       
   　   即可更新定时任务
   　  

6、定时任务2 3 总结：

<pre><code class="language-html">0 5 * * 0,1,3,5 /jffs/scripts/restart_wan.sh #wan_reboot#
30 13 * * * /bin/sh /koolshare/scripts/ss_rule_update.sh #supdate#</code></pre>


7、【restart_wan-cron-ss.sh】一键导入上面三个脚本
<pre><code class="language-html">curl -L -o /jffs/scripts/hosts-wan-cron.sh https://mirror.ghproxy.com/raw.githubusercontent.com/klcb2010/restart_wan-cron-ss-mod/main/restart_wan-cron-ss.sh</code></pre>

赋值后执行 <pre><code class="language-html">chmod 777 /jffs/scripts/restart_wan-cron-ss.sh</code></pre>


8、改进：使用脚本执行第七步，运行install_and_run.sh

