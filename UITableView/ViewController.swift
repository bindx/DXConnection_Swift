//
//  ViewController.swift
//  UITableView
//
//  Created by Bindx on 15/7/8.
//  Copyright © 2015年 Bindx. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
    let cellID = "mycell";
    
    var data :NSArray?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "网易新闻"
        
        let nib = UINib(nibName: "MyTableViewCell", bundle: nil);
        self.tableView.registerNib(nib, forCellReuseIdentifier: cellID);
        
        Request.Get.dataWith("http://c.m.163.com//nc/article/list/T1348649580692/0-20.html") { (result) -> Void in
            
            self.data = result["T1348649580692"].arrayObject!;
            
            //回到主线程更新TableView数据
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.tableView.reloadData();
            
            })
            
        };
        
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellID, forIndexPath: indexPath) as! MyTableViewCell;
        
        if let data = self.data{
            cell.setInfo(data[indexPath.row] as! NSDictionary, indexPath: indexPath.row);
        }
        
        return cell;
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "jumpid") {
            
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if let fontCount = self.data{
            return fontCount.count;
        }
        return 0;
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let detail = self.storyboard?.instantiateViewControllerWithIdentifier("detail") as! DetailViewController;
        
        if let data = self.data{
            detail.title = data[indexPath.row]["title"] as? String;
            detail.urlStr = data[indexPath.row]["url_3w"] as? String;
        }
        
        self.navigationController?.pushViewController(detail, animated: true)
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100;
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

