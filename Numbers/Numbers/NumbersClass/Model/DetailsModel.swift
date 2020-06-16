//
//  DetailsModel.swift
//  Numbers
//
//  Created by yan feng on 2020/6/13.
//  Copyright © 2020 Yan feng. All rights reserved.
//

import UIKit

class DetailsModel: NSObject {
    
    var name: String = ""
    var text: String = ""
    var image: String = ""
    
    override init() {
           
    }
    
    init(text: String, image: String) {
         self.text = text
         self.image = image
         
     }

}
