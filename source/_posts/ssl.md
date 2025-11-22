---
title: localhost HTTPS支持
---

# localhost HTTPS支持

# *.localhost.direct - 公开签名通配符SSL证书支持子域名

>[!NOTE]
>New DNS讨论正在进行中：https://github.com/Upinel/localhost.direct/issues/21

某天早晨，我遇到了本地开发常见的三大问题：

1. 在本地测试环境中使用完全限定域名（FQDN）
2. 本地环境中的SSL证书麻烦多多
3. 实现子域支持于本地开发环境

为了解决这些问题，我注册了localhost.direct这个域名，并获取了一个通配符的SSL证书。将localhost.direct和*.localhost.direct配置指向127.0.0.1。现在可以愉快地编码啦！

恍然大悟！我发现我可以免费与全球开发者共享私钥及SSL证书。因此，*.localhost.direct项目诞生了。

开发人员可以在https://get.localhost.direct/获取最新的SSL证书包下载链接，这将成为唯一的保留子域名。通配符SSL证书的更新将在此发布，并且您的反馈非常宝贵。

祝你好运！

## 重要信息
>[!IMPORTANT]
>非SSL（HTTP）：运行正常  
> SSL（HTTPS）：建议使用私有CA证书包并在本地环境中信任该证书，由于可能因密钥泄露导致撤销 https://github.com/Upinel/localhost.direct/issues/18，我们目前提供两层的证书包。

>[!TIP]
>实际上强烈推荐您自己为*.localhost.direct自签名并将其在组织中受信。这可以确保公共CA撤销不会影响您的开发环境，并且您可以继续享受公开支持的子域名测试。（参见下载 - 第四部分）

>[!WARNING]
>请勿将.key文件放置于任何可访问的地方，包括GitHub项目中。一旦发现，证书将会被吊销。我将来不想要求用户注册 https://github.com/Upinel/localhost.direct/issues/18  
>.key文件必须始终以密码保护的压缩包形式存在。证书包已进行加密并附带原因说明。CA一直在扫描互联网查看是否有密钥泄露的情况发生，请注意。

## EULA
*为了更好地遵守指南，我们对用户协议进行了修改，并立即生效：*
**通过使用此服务,** 您（localhost.direct开发者）和LHD（localhost.direct）同意您将作为LHD的开发人员。然而，LHD永远不会知道你开发了什么内容也不会声称拥有或版权你的作品。同时，LHD不会支付任何激励或补偿并且不对您的开发过程中产生的费用、成本或损害负责。
通过此开发者协议,LHD会将其开发环境域名（localhost.direct和*.localhost.direct）指向您本地服务器的IP地址（在这种情况下为127.0.0.1）。LHD还将授予你仅用于内部测试目的使用其SSL证书的权利。该证书将单独提供给您。

请注意，证书包的所有权归LHD所有，并且您绝不能泄露、共享或转租此证书包给任何其他方。如果您有多名开发者，则他们都将受相同的开发协议约束与LHD。

## 使用方法：
### 对于非SSL用户
localhost.direct无需配置即可立即使用，功能类似于传统的localhost，同时支持子域名.localhost.direct。

### 用于希望在本地开发环境中启用HTTPS（SSL）的用户
下载或克隆.key和.crt文件，并将其部署到您的本地Web服务器以设置一个启用了SSL的本地开发环境。

## 限制：
**get.localhost.direct** 是保留的唯一子域，您无法使用它。

## 下载
我们现在提供两层证书包。如果您希望完全匿名，请使用通用证书包。
我们还提供了请求和赞助支持下的证书包，您可以通过电子邮件申请它们。

### <ins>A. 非公共CA证书</ins>（如果您的开发环境具有管理员权限，则可以使用以下10年期预生成的自签名证书）
这是避免CA撤销最可靠的方法。只需下载以下证书包（或自行创建），安装并信任该证书，结果将在您的开发环境中安装一个有效期为10年的*.localhost.direct 证书。由于它在本地受信，因此如果您具有完全管理员权限，则是最稳定的解决方案。
下载：[https://aka.re/localhost-ss](https://aka.re/localhost-ss)
密码: **localhost**

### <ins>B.通用证书包</ins>（完全匿名 - 已停止，请考虑使用非公共CA证书包并在本地环境中受信）