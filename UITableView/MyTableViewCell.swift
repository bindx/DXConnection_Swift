//
//  MyTableViewCell.swift
//  UITableView
//
//  Created by Bindx on 15/7/8.
//  Copyright © 2015年 Bindx. All rights reserved.
//

import UIKit

class MyTableViewCell: UITableViewCell {
    //标题
    @IBOutlet weak var title: UILabel!
    //副标题
    @IBOutlet weak var detail: UILabel!
    
    //图片
    @IBOutlet weak var img: UIImageView!
    
    func setInfo(title: String, indexPath :Int){
        self.title.text = title;
        self.title.font = UIFont(name: title, size: 14);
        self.detail.text = String(indexPath);
        
        if(indexPath % 2 == 0){
            self.backgroundColor = UIColor.yellowColor();
        }else{
            self.backgroundColor = UIColor.greenColor();
        }
    }
    
}
