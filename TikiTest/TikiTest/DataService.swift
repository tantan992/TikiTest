//
//  DataService.swift
//  toibanvn
//
//  Created by Tan Tan on 8/21/16.
//  Copyright © 2016 Tan Tan. All rights reserved.
//

import UIKit
class DataService: NSObject {
    private let requestAPI = RequestAPI()
    private let strBaseAPI = "https://tiki-mobile.s3-ap-southeast-1.amazonaws.com/ios/keywords.json"
    
    func loadListProduct( successBlock:@escaping ([Product]?,NSError?) -> Void)  {

        requestAPI.request(strURL: strBaseAPI , params: nil,completeHandler: { (response) in
            var products:[Product] = []
            if let response = response {
                guard let jsons = response["keywords"] as? [Any] else {return}
                
                for index in jsons{
                    guard let object = index as? [String : Any] else {return}
                    let product = Product(json: object)
                    products.append(product)
                }

                successBlock(products, nil)
            }
        }, errorHandler: { (error) in
            successBlock(nil,error)
        })
        
    }
 
    
}


