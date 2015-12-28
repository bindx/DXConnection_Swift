//
//  DXHttpRequest.swift
//  swift tipss
//
//  Created by Bindx on 15/7/8.
//  Copyright © 2015年 Bindx. All rights reserved.
//

import UIKit

let MAX_CONCURRENT_OPERATIONCOUNT = 3;

class DXHttpRequest: NSObject {
    //初始化
    override init() {
        super.init();
    }
    //线程管理
    class DXConnectManager: NSObject {
        //线程池
        let downloadQueue: NSOperationQueue;
        
        //初始化线程池
        init(downloadQueue : NSOperationQueue) {
            self.downloadQueue = NSOperationQueue();
            self.downloadQueue.maxConcurrentOperationCount = MAX_CONCURRENT_OPERATIONCOUNT;
        }
        
        //设置最大线程数
        func maxConCurrentOperationCount(max :Int){
            if max > 0{
                self.downloadQueue.maxConcurrentOperationCount = max;
            }
        }
        
        //添加任务到线程中
        func addRequest(request: DXRequest){
            
        }
        
        func addSynchronizedRequest(request :DXRequest) ->(DXRequest){
            return DXRequest();
        }
    }
    
    class DXRequest: NSObject {
        
    }
    
    //线程队列
    class DXConnectionOperation: NSOperation {
        var request   : NSMutableURLRequest?
        var connect   : NSURLConnection?
        var data      : NSMutableData?
        var isFinished: Bool?
        
        func initWithRequest(request: DXRequest){
            
        }
    }
}


class Request {

    let queue :NSOperationQueue;
    var Result: ((result: JSON) ->Void)?
    var ImgData: ((result: NSData) ->Void)?

    init(){
        self.queue = NSOperationQueue();
    }
    
    struct Get {
        static func dataWith(url: String,result: ((result: JSON) ->Void)){
            Request().initWithUrlRequest(url, httpmethod: "get", result: result, imgData: nil);
        }
    }
    
    struct GetImg {
        static func dataWith(url: String,result: ((result: NSData) ->Void)){
            Request().initWithUrlRequest(url, httpmethod: "get", result: nil, imgData: result);
        }
    }
    
    struct Post {
        static func dataWith(url: String,result: ((result: JSON) ->Void)){
            Request().initWithUrlRequest(url, httpmethod: "post", result: result ,imgData: nil);
        }
    }
    
    func initWithUrlRequest(url: String, httpmethod: String,result:((result: JSON) ->Void)?,imgData: ((result: NSData) ->Void)?){
        if let _ = result{
//            queue.addOperation(DXHttpOperation(url: NSURL(string: url), result: result!, data: nil));
            queue.addOperation(DXHttpOperation(url: NSURL(string: url), result: result!, imgresult: nil, data: nil));
        }
        
        if let _ = imgData{
            queue.addOperation(DXHttpOperation(url: NSURL(string: url), result: nil, imgresult: imgData, data: nil));
        }
    }
}

class DXHttpOperation: NSOperation, NSURLSessionDataDelegate {
    
    var url: NSURL?
    var resPonseData: NSMutableData?
    var connection  : NSURLConnection!
    var reCeiveData : NSMutableData?
    var postData    : NSData?
    var callBack = Request();
    
    init(url: NSURL?,result:((result: JSON) ->Void)?,imgresult: ((result: NSData) ->Void)?,data: NSData?){
        resPonseData = NSMutableData();
        self.url = url;
        self.postData = data;
        self.callBack.Result = result;
        self.callBack.ImgData = imgresult;
    }
    
    private var _executing = false;
    
    override var executing :Bool{
        get{
            return _finished;
        }
        
        set(newValue){
            _finished = newValue;
        }
    }
    
    private var _finished = false;

    override var finished : Bool{
        get{
            return _finished;
        }
        
        set(newValue){
            _finished = newValue;
        }
    }
    
    override func start() {
        self.executing = true;
        
        if let url = self.url{
            let request = NSMutableURLRequest(URL: url);
            if let _ = postData{
                request.HTTPMethod = "POST";
                request.HTTPBody = reCeiveData;
            }
            
            self.connection = NSURLConnection(request: request, delegate: self);
            
            repeat{
                NSRunLoop.currentRunLoop().runMode(NSDefaultRunLoopMode, beforeDate: NSDate(timeIntervalSinceReferenceDate: 0.1))
            }while (self.executing)
        }
    }
    
//    func connection(connection: NSURLConnection, didReceiveResponse response: NSURLResponse){
//        let response = response as! NSHTTPURLResponse;
//        print("服务器状态码\(response.statusCode)");
//    }
    
    func connection(connection: NSURLConnection, didReceiveData data: NSData){
        self.resPonseData?.appendData(data);
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection){
        self.executing = false;
        self.finished = true;
        
        if let _ = self.callBack.Result{
            if let dat = resPonseData{
                self.callBack.Result!(result: JSON(data: dat));
            }
        }
        
        if let _ = self.callBack.ImgData{
            if let dat = resPonseData{
                self.callBack.ImgData!(result: dat);
            }
        }
    }
    
    func connection(connection: NSURLConnection, didFailWithError error: NSError){
        
    }
    
}
