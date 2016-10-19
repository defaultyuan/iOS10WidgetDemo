//
//  Item.swift
//  iOS10WidgetDemo
//
//  Created by 袁斌 on 2016/10/19.
//  Copyright © 2016年 https://github.com/DefaultYuan. All rights reserved.
//

import UIKit

class Item: NSObject {

    var name : String?
    var price : String?
    var range : String?
    
    
    class func initWithDict(dict: Dictionary<String,String>) -> Item {
        
        let item = Item()
        
        for (key, value) in dict {
            item.setValue(value, forKey: key)
        }
        
        return item
    }
    
}
