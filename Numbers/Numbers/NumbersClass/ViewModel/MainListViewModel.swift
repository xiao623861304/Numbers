//
//  NumbersViewModel.swift
//  Numbers
//
//  Created by yan feng on 2020/6/13.
//  Copyright © 2020 Yan feng. All rights reserved.
//

import UIKit

class MainListViewModel: NSObject {
    
   lazy var NumbersGroups : [NumbersModel] = [NumbersModel]()

      func loadNumberData(type: MethodType,urlString : String, parameters : [String : Any]? = nil, finishedCallback: @escaping () -> ()) {
        
        NetWorkTools.requestData(type: type, urlString: urlString, succeed: { (result, error) in
            
            let jsonResponse = try? JSONSerialization.jsonObject(with: result, options: .mutableLeaves)

            guard let dataArray = jsonResponse as? [[String : Any]] else {
                
                return
                
            }
            for dict in dataArray {
                let numbers = NumbersModel.init(name: dict["name"] as! String, image: dict["image"] as! String)
                self.NumbersGroups.append(numbers)
            }
            finishedCallback()

        }) { (error) in
            
        }
        
        
    }
}
