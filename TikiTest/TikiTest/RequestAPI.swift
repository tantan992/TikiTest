//
//  RequestAPI.swift
//  toibanvn
//
//  Created by Tan Tan on 8/21/16.
//  Copyright © 2016 Tan Tan. All rights reserved.
//

import UIKit
import Alamofire

typealias CompletionBlock = ([String:AnyObject]?) -> Void
typealias ErrorHandler = (NSError?) -> Void

enum HOST : String{
    case dev = "https://tiki-mobile.s3-ap-southeast-1.amazonaws.com/ios/keywords.json"
    case production = "https://toiban.com.vn/index/"
    
}

class RequestAPI: NSObject {
    private var alamofireManager : Alamofire.SessionManager

//    private let strBaseAPI = HOST.production.rawValue
    
    override init() {
       let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 30
        config.timeoutIntervalForResource = 30
        self.alamofireManager = Alamofire.SessionManager(configuration: config)
    }
    
    func request(strURL:String?, params:[String:Any]?, completeHandler:CompletionBlock?, errorHandler:ErrorHandler?) -> Void  {
        guard let url = strURL else { return  }
        
        alamofireManager.request(url, method: .get, parameters: params, encoding: URLEncoding.default, headers: nil) .responseJSON { (response) in
            
                switch (response.result){
                case .success:
                    if let json  = response.result.value as? [String : AnyObject]{
                        completeHandler?(json)
                    }
                    break
                    
                case .failure:
                    self.showAlert(response.result.error?.localizedDescription)
                    errorHandler?(response.result.error as NSError?)
                    break
                    
                }

        }
        
    }
    
 
    
    //MARK: - SHOW ALERT ERROR
    func showAlert(_ content:String?) -> Void {
        if let content = content  {
            let alert = UIAlertView(title: "Message", message: content, delegate: nil, cancelButtonTitle: "OK")
            alert.show()
        }

    }
    
}
