//
//  RequestManager.swift
//  toibanvn
//
//  Created by Tan Tan on 8/20/16.
//  Copyright © 2016 Tan Tan. All rights reserved.
//

import UIKit

class TManager: NSObject {
    static let sharedInstance = TManager()
    
    var dataService = DataService()
}
