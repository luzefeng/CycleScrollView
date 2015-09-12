
1. 用swift写的无限循环图片展示，比较粗糙，其中用到了SDWwebImage用来下载网络图片和缓存图片。

![](http://appbyluzefeng-wordpress.stor.sinaapp.com/uploads/2015/09/scrollview.gif)

使用方法

本地图片

        var localImages = NSArray(objects: UIImage(named: "1.jpg")!, UIImage(named: "2.jpg")!, UIImage(named: "3.jpg")!, UIImage(named: "4.jpg")!, UIImage(named: "5.jpg")!, UIImage(named: "6.jpg")!)
        var scroll = CycleScrollView(frame: CGRect(x: 0, y: 200, width: self.view.bounds.size.width, height: 200))
        scroll.setupLocalImages(localImages)
        self.view.addSubview(scroll)
        
网络图片

        var remoteImages = NSArray(objects: "http://img1.mm131.com/pic/1997/14.jpg", "http://img1.mm131.com/pic/1997/15.jpg", "http://img1.mm131.com/pic/1997/18.jpg", "http://img1.mm131.com/pic/1997/19.jpg")
        var scroll1 = CycleScrollView(frame: CGRect(x: 0, y: 400, width: self.view.bounds.size.width, height: 200))
        scroll1.setupRemoteImages(remoteImages)
        self.view.addSubview(scroll1)

var timerInterval: NSTimeInterval = 2.0 //设置时间间隔

var delegate: CycleScrollViewDelegate? //点击事件代理
