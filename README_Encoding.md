# IDEA中解决中文乱码问题

## 问题描述
在IDEA控制台中显示中文乱码，如"��¼����"实际应该是"登录信息"

## 解决方案

### 1. 设置IDEA文件编码
1. 打开IDEA
2. `File` -> `Settings` (或 `Ctrl + Alt + S`)
3. 搜索 "File Encodings"
4. 设置以下编码为UTF-8：
   - Global Encoding: UTF-8
   - Project Encoding: UTF-8
   - Default encoding for properties files: UTF-8

### 2. 设置控制台编码
1. 在Settings中搜索 "Console"
2. 找到 "Console" 设置
3. 设置 "Default encoding" 为 UTF-8

### 3. 配置Tomcat VM参数
1. 打开Run/Debug Configurations
2. 选择你的Tomcat配置
3. 在 "VM options" 中添加：
   ```
   -Dfile.encoding=UTF-8
   -Dsun.jnu.encoding=UTF-8
   ```

### 4. 设置系统环境变量（可选）
在系统环境变量中添加：
```
JAVA_TOOL_OPTIONS=-Dfile.encoding=UTF-8
```

### 5. 重启IDEA和Tomcat
设置完成后，重启IDEA和Tomcat服务器。

## 已完成的代码修改

项目中已经添加了字符编码过滤器来确保Web请求的编码正确：

- `web.xml`: 添加了CharacterEncodingFilter
- `CharacterEncodingFilter.java`: 实现了UTF-8编码过滤器
- 数据库连接字符串已包含UTF-8编码参数

## 验证方法

重新启动Tomcat后，控制台输出的中文应该正常显示，如：
- "登录信息" 而不是 "��¼����"
- "用户信息" 而不是 "�û���"
