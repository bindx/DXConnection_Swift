//
//  DetailViewController.swift
//  UITableView
//
//  Created by Bindx on 15/7/8.
//  Copyright © 2015年 Bindx. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var webView: UIWebView!
    var urlStr:String?;
    
 override func viewDidLoad() {
        super.viewDidLoad()

    let url = NSURL(string: self.urlStr!)
    let request = NSURLRequest(URL: url!)
    webView.loadRequest(request)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
