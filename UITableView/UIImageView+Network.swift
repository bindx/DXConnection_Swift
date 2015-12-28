//
//  File.swift
//  swift tipss
//
//  Created by Bindx on 15/7/8.
//  Copyright © 2015年 Bindx. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView{
    func setImageWithUrl(url: String){
        Request.GetData.dataWith(url) { (result) -> Void in
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.image = UIImage(data: result);
            });
        };
    }
}

extension UIButton{
    func setImageWithUrl(url: String ,state: UIControlState){
        Request.GetData.dataWith(url) { (result) -> Void in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.setBackgroundImage(UIImage(data: result), forState: state);
            });
           
        };
    }
}