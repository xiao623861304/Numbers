//
//  DetailsViewModel.swift
//  Numbers
//
//  Created by yan feng on 2020/6/13.
//  Copyright © 2020 Yan feng. All rights reserved.
//

import UIKit

class DetailsViewModel: NSObject {
    
    lazy var details : DetailsModel = DetailsModel()
    
    func loadDetailData(type: MethodType,urlString : String, parameters : [String : Any]? = nil, finishedCallback: @escaping () -> ()) {
           
           NetWorkTools.requestData(type: type, urlString: urlString, succeed: { (result, error) in
               let jsonResponse = try? JSONSerialization.jsonObject(with: result, options: .mutableLeaves)
               
                guard let dataDict = jsonResponse as? [String : Any] else {
                   
                   return
                   
               }

            self.details = DetailsModel.init(text: dataDict["text"] as! String, image: dataDict["image"] as! String)
               
               finishedCallback()

           }) { (error) in
               
           }
           
           
       }
}
