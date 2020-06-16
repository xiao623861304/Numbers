//
//  NumbersModel.swift
//  Numbers
//
//  Created by yan feng on 2020/6/13.
//  Copyright © 2020 Yan feng. All rights reserved.
//

import UIKit

class NumbersModel: NSObject {
    
       var name: String = ""
       var image: String = ""
       
       override init() {
           
       }
       
       init(name: String, image: String) {
           self.name = name
           self.image = image
       }
    
}

