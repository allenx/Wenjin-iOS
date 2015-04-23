Wenjin-iOS
======================
问津社区 iOS 版客户端

# 简介

> 寻师讲道，结友问津。

问津 是天外天工作室出品的天津大学校内问答社区。本项目为问津社区 iOS 客户端，适配 iPhone, iPod touch, iPad 平台。

# 项目架构

本项目遵循 MVC 架构规范。项目结构主要为：

* Main
	* AppDelegate
	* Localizeable.Strings
	* main.m
	* info.plist
	* Base.lproj & zh-Hans.lproj
* Modal
	* 各模块数据管理器
	* 消息显示模块
	* 本地数据管理
	* 字符串处理
	* App 外观颜色管理
	* API 调用及加密模块
	* 单例模式实现
* View
	* 各种 TableViewCell
	* 各种自定义 View
* Controller
	* MainTabBarController
	* 各种 ViewController
* Resource
	* Images.xcassets
	* Bootstrap

# 开源项目

衷心感谢以下开源项目为 问津 作出的不可磨灭的贡献。

* Cocoapods
* AFNetworking
* JSONKit
* ALActionBlocks
* SVProgressHUD
* SVPullToRefresh
* POP
* KVOController
* FXForms
* NYSegmentedControl
* TLTagsControl

为适应 问津 的需求，部分代码被做出了一些更改并 fork 到我自己的分支中（而未通过 Cocoapods 进行管理）。具体详见代码。







