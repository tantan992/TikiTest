//
//  Product.swift
//  toibanvn
//
//  Created by Tan Tan on 8/21/16.
//  Copyright © 2016 Tan Tan. All rights reserved.
//


import Foundation

struct Product {
    var keyword:String! = nil
    var icon:String! = nil
 
    init(json : [String:Any]?){
        guard let json = json else {return}
        
        guard let strKeyword = json["keyword"] as? String else {return}
        guard let strIcon = json["icon"] as? String else {return}
        
        self.keyword = strKeyword
        self.icon = strIcon


    }

    
}
