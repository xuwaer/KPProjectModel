#KPProjectMode   

iOS项目框架，使用CocoaPods管理第三方开源库。使用前请配置CocoaPods。（**请勿上传Pods文件夹下的任何文件，包括添加、删除、更新**）


##KPFramework 框架主要部分
1.KPFrameHeader.h   
框架所需要使用的各种头文件。    

2.KPBase     
主要使用的父类，例：ViewController     

3.Views    
自定义的各种View控件    

4.Launch    
应用启动时的模块化定义。包括：闪屏页、引导页      

5.Alert     
提示相关工具。目前仅使用MPProgressHub      

6.Map    
地图类工具。目前仅集成BaiduMap     

7.Network    
网络访问工具。使用的是MKNetworkKit开源项目作为基础。     
目前仅支持http方式。     

8.Database   
数据库访问工具。使用CoreData技术，通过线程控制数据库读写。     
目前设计还在最初级阶段。即：线程控制读写。    

9.File    
文件管理工具。暂未设计。    

10.Common    
其他通用工具。包括各种扩展、宏定义等