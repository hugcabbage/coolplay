![GitHub repo size](https://img.shields.io/github/repo-size/hugcabbage/coolplay)
![GitHub file size in bytes](https://img.shields.io/github/size/hugcabbage/coolplay/jar%2Fpg.jar?label=pg.jar%20size)
![GitHub file size in bytes](https://img.shields.io/github/size/hugcabbage/coolplay/jar%2FXYQ.jar?label=XYQ.jar%20size)
![GitHub last commit](https://img.shields.io/github/last-commit/hugcabbage/coolplay)

所有资源均来自于各路大神无私分享，如有侵权，请联系删除。

所有直接或间接使用本仓库内容的个人和组织，应 24 小时内完成学习和研究，并及时删除本仓库内容。如对本仓库内容的功能有需求，应自行开发相关功能。所有基于本仓库内容的源代码，进行的任何修改，为其他个人或组织的自发行为，与本仓库内容没有任何直接或间接的关系，所造成的一切后果亦与本仓库内容和本仓库管理者无关。

> 该项目来自于[gaotianliuyun/gao](https://github.com/gaotianliuyun/gao.git)，做了一些修改。

### 多线路源
- framagit
```text
https://framagit.org/hugcabbage/coolplay/-/raw/master/all.json
```
- github
```text
https://gitdl.cn/https://raw.githubusercontent.com/hugcabbage/coolplay/master/all.json
```
```text
https://hub.gitmirror.com/https://raw.githubusercontent.com/hugcabbage/coolplay/master/all.json
```
```text
https://gh.con.sh/https://raw.githubusercontent.com/hugcabbage/coolplay/master/all.json
```
```text
https://cdn.jsdelivr.net/gh/hugcabbage/coolplay@master/all.json
```

### 配置说明
- all.json 蜂蜜影视多线路配置源。
- XYQ.json 香雅情的jar包和配置，[github更新](https://github.com/xyq254245/xyqonlinerule.git)，[123盘更新](https://www.123pan.com/s/alSeVv-lGO0A.html)；js内容来自[hipy](https://github.com/hjdhnx/hipy-server.git)。
- pg.json pg源，[配置说明](#pg说明)，[telegram频道更新](https://t.me/s/PandaGroovePG)。
- cool.json XYQ+PG。

### pg说明
<details>
  <summary>点击展开/关闭</summary>

把zip文件解压缩到安卓设备的/sdcard/tvbox/JS/目录

复制lib/tokentemplate.json成为lib/tokenm.json，并填写必要的内容

特别提示：发现影视壳并不能加载最新的jar，如果遇到jar表现异常，或者最新的jar承诺的功能改进没有实现，请清除播放壳app的缓存后强杀播放壳后再试，清除方法1：在壳app的设置里点击“缓存”，清除方法2：设备的应用管理中，清除壳app的数据及缓存。

特别警告：迅雷云盘限制极为严格，不要尝试单token多用户异地使用，或多线程使用，随时可能封号。

可以透过配置中的“网盘及弹幕配置”的视频源来实现快捷方便的获取32位token及opentoken的功能。在“网盘及弹幕配置”中扫过任何一个OpenToken后，会自动激活“转存原画”功能

提示：如果遇到极速GO原画反复快速报错，不一定是被封号，可尝试杀掉播放器重启，或重启整个播放设备解决。

提示2：如果遇到“转存原画”速度被限制在2M左右，那么请尝试在阿里云盘APP里退出登录，然后重新登录，然后删除播放设备SD卡的TV目录，在播放器上重新扫码登录。

提示3：zip包内预置的aliproxy从jar内的assets改为zip内的aliproxy.gz，可以减少jar包对播放器内存的消耗，但因为aliproxy.gz的释出需要使用到壳上的proxy功能，所以如果播放设备安装了多个类似的播放器，可能导致aliproxy释放出错或运行出错。不要尝试在同一个播放设备上运行多个播放壳，也不要尝试把本jar加载到同一个播放设备的不同播放壳上。

tokenm.json格式说明：

```jsonc
{
"token":"这里填写阿里云盘的32位token，也可以不填写，在播放阿里云盘内容时会弹出窗口，点击QrCode，用阿里云盘app扫码",
"open_token":"这里填写通过alist或其他openapi提供方申请的280位aliyun openapi token，也可以不写，会自动隐藏转存原画",
"thread_limit":32, //这里是阿里云盘的GO代理的并发协程数或java代理的并发线程数，若遇到账号被限制并发数，请将此数值改为10
"is_vip":true, //是否是阿里云盘的VIP用户，设置为true后，使用vip_thread_limit设置的数值来并发加速。如本设置项目不是true，则自动隐藏“转存原画”
"vip_thread_limit":10, //这里是阿里云盘的转存原画(OpenToken)并发线程数，若遇到账号被限制并发数，请将此数值改为10
"quark_thread_limit":32, //这里是夸克网盘GO代理的并发协程数或java代理的并发线程数，若遇到账号被限制并发数，请将此数值改为10
"quark_vip_thread_limit":16, //这里是夸克网盘设置quark_is_vip:true之后的并发线程数，若遇到账号被限制并发数，请将此数值改为10
"quark_is_vip":false, //是否是夸克网盘的VIP用户，设置为true后，线程数受quark_vip_thread_limit控制
"vod_flags":"4k|4kz|auto", //这里是播放阿里云的画质选项，4k代表不转存原画（GO原画），4kz代表转存原画,其他都代表预览画质,可选的预览画质包括qhd,fhd,hd,sd,ld，
"quark_flags":"4kz|auto", //这里是播放夸克网盘的画质选项，4kz代表转存原画（GO原画），其他都代表转码画质,可选的预览画质包括4k,2k,super,high,low,normal
"uc_thread_limit":0,
"uc_is_vip":false,
"uc_flags":"4kz|auto",
"uc_vip_thread_limit":0,
"thunder_thread_limit":0,
"thunder_is_vip":false,
"thunder_vip_thread_limit":0,
"thunder_flags":"4k|4kz|auto",
"aliproxy":"这里填写外部的加速代理，用于在盒子性能不够的情况下，使用外部的加速代理来加速播放，可以不填写",
"proxy":"这里填写用于科学上网的地址，连接openapi或某些资源站可能会需要用到，可以不填写",
"open_api_url":"https://api.xhofe.top/alist/ali_open/token", //这是alist的openapi接口地址，也可使用其他openapi提供商的地址。
"danmu":true,//是否全局开启阿里云盘所有csp的弹幕支持，聚合类CSP仍需单独设置，例如Wogg, Wobg
"quark_danmu":true,//是否全局开启夸克网盘的所有csp的弹幕支持, 聚合类CSP仍需单独设置，例如Wogg, Wobg
"quark_cookie":"这里填写通过https://pan.quark.cn网站获取到的cookie，会很长，全数填入即可。"
"uc_cookie":"这里填写通过https://drive.uc.cn网站登录获取的cookie",
"thunder_username":"这里填入用户名或手机号，如果是手机号，记得是类似'+86 139123457'这样的格式，+86后有空格才对",
"thunder_password":"密码",
"thunder_captchatoken":"首次使用迅雷网盘时，需要使用app弹出的登陆地址去接码登录，并获取captchaToken，具体方法参考alist网站的文档:https://alist.nn.ci/zh/guide/drivers/thunder.html",
"pikpak_username":"PikPak网盘的用户名",
"pikpak_password":"PikPak网盘的密码",
"pikpak_flags":"4k|auto",
"pikpak_thread_limit":2,
"pikpak_vip_thread_limit":2,
"pikpak_proxy":"用于科学上网连接PikPak网盘的代理服务器地址",
"pikpak_proxy_onlyapi":false
}
```
</details>
