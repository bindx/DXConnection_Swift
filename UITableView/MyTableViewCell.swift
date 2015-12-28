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
    
    func setInfo(data: NSDictionary, indexPath :Int){

        self.title.text = data["title"] as? String;
        self.detail.text = data["digest"] as? String;
        self.img.setImageWithUrl((data["imgsrc"] as? String)!);
        
        if(indexPath % 2 == 0){
            self.backgroundColor = UIColor.whiteColor();
        }else{
            self.backgroundColor = UIColor.groupTableViewBackgroundColor();
        }
    }
}
