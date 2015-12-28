### DXHttpRequest_swift 

----


#####文件介绍

File Name | introduction |
------------ | ------------- | 
DXHttpRequest.swift|网络请求|
UIImageView+Network.swift|给UIImageView&UIButton添加网络方法|

####  使用方法

####---- GET请求

```
   Request.Get.dataWith("http://c.m.163.com//nc/article/list/T1348649580692/0-20.html") { (result) -> Void in
            
            self.data = result["T1348649580692"].arrayObject!;
            
            //回到主线程更新TableView数据
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.tableView.reloadData();
            
            })
            
        };
    } 
```

####---- POST 请求

```
 Request.Get.dataWith("http://postxxxx",data: NSData?) { (result) -> Void in
    
    };

```


#### ---- 设置网络图片
```
  xxxx.setImageWithUrl("http://imageUrl");
  
```

###### 备注:依赖SwiftyJSON库解析JSON数据
