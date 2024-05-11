   　      　      　      　      　      　   　      　      　      　      　      　      　      　      　      　      仅适合梅林原版及改版   

1、U盘开机挂载
   　   安装 <pre><code class="language-html">curl -Os https://diversion.ch/amtm/amtm && sh amtm</code></pre>
   　   使用 SSH 　　 输入amtm　　  安装USB disk check at boot　　到所有U盘分区 　　重启路由测试



2、在线更新SS规则 　需要关闭自带定时　重启或者升级插件后失效
     　   SSH输入
   　      　   <pre><code class="language-html">sed -i 's/^URL_MAIN.*/URL_MAIN="https:\/\/raw.githubusercontent.com\/qxzg\/Actions\/3.0\/fancyss_rules"/g' /koolshare/scripts/ss_rule_update.sh</code></pre>
   　   定时任务：30 13 * * * /bin/sh /koolshare/scripts/ss_rule_update.sh #supdate#


3、定时重启wan （crontabs文件夹及里边的klcb2010需要手动创建　最后scripts文件夹赋值777）

   　   重启路由后需要手动运行"/jffs/scripts/set_crontab.sh"　　

   　   nano编辑定时任务：nano /jffs/scripts/crontabs/klcb2010
 
   　   Crtl+O保存　　enter确认　　Crtl+X退出

   　   然后执行/jffs/scripts/set_crontab.sh 　　用amtm验证定时任务。
   　  
   　   定时任务：0 5 * * 0,1,3,5 /jffs/scripts/restart_wan.sh #wan_reboot#

4、自定义hosts 
   　   /jffs/scripts/hosts   编辑完毕  运行 /jffs/scripts/copy_hosts.sh
   　   执行killall -SIGHUP dnsmasq重启 dnsmasq 服务  
   　   定时任务：0 10 * * 1 /jffs/scripts/copy_hosts.sh #hosts#

   　  

5、定时任务总结：

<pre><code class="language-html"> 0 5 * * 0,1,3,5 /jffs/scripts/restart_wan.sh #wan_reboot#
 30 13 * * * /bin/sh /koolshare/scripts/ss_rule_update.sh #supdate#
 0 10 * * 1 /jffs/scripts/copy_hosts.sh #hosts#</code></pre>
