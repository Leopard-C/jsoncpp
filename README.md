## 1. 关于jsoncpp

本项目修改自 [open-source-parsers/jsoncpp](https://github.com/open-source-parsers/jsoncpp)，版本号`1.9.5`。

主要是为了更好的支持UTF8字符的显示。

## 2. 修改内容

+ `Json::Value`类，修改`toStyledString()`函数签名，新增参数`settings`。

```cpp
String toStyledString(const Json::Value& settings = Json::nullValue) const;
```

+ `Json::StreamWriterBuilder`类，新增`setSettings()`方法，函数签名如下。

```cpp
void setSettings(const Json::Value& setting);
```

+ `Json::FastWriter`类，新增`dropNullKeyValues_`和`emitUTF8_`两个私有属性，以及对应的`dropNullKeyValues()`和`emitUTF8()`方法。

    + `dropNullKeyValues`: 如果某个`key`对应的`value`为`null`，序列化为字符串时忽略该键值。

        ```json
        // JSON对象
        {
            "age": 12,
            "name": "Tom",
            "data": null
        }

        // 输出字符串
        // data属性被移除
        {"age":12,"name":"Tom"}
        ```

    + `emitUTF8`: 启用UTF8编码。

        ```json
        // 不启用
        {"name":"\u7f16\u7a0b","score":98}

        // 启用
        {"name":"编程","score":98}
        ```

## 3. 示例

见`example/main.cpp`源文件。

## 4.1 编译(Linux平台)

```shell
# x86_64
make

# arm64(交叉编译)
make CXX=aarch64-linux-gnu-g++ AR=aarch64-linux-gnu-ar ARCH=aarch64
```

输出如下文件

+ `lib/linux/libjsonccp.a`: 静态库文件
+ `example.out`: 示例程序。(运行方式：`./example.out`)

## 4.2 编译(Windows平台)

打开`win-vsproj/jsoncpp.sln`项目，编译即可。

输出如下文件

+ `lib/windows/$(Platform)/$(Configuration)/jsoncpp.lib`: 静态库文件
+ `example.exe`: 示例程序。
