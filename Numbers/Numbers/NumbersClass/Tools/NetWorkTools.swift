//
//  NetWorkTools.swift
//  Numbers
//
//  Created by yan feng on 2020/6/13.
//  Copyright © 2020 Yan feng. All rights reserved.
//

import UIKit

enum MethodType: String {
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
}

class NetWorkTools: NSObject {
    
    static var hostReachability:YFNetWorkReachability!
    static func requestData(type: MethodType,urlString: String, parameters: [String : Any]? = nil ,succeed:@escaping ((_ result : Data, _ error: Error?) -> Swift.Void), failure: @escaping ((_ error: Error?)  -> Swift.Void)) {
        let session = URLSession.shared
        let request = NSMutableURLRequest(url: NSURL(string: urlString)! as URL)
        request.httpMethod = type.rawValue
     
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        hostReachability = YFNetWorkReachability(hostName: urlString)
        let netWorkStatus =  hostReachability.currentReachabilityStatus()
        switch netWorkStatus {
        case .notReachable:
            appDelegate.showNetWorkErrorAlert()
            break
        case .unknown:
            appDelegate.reconnectedNetwork()
            break
        case .WWAN2G:
            appDelegate.reconnectedNetwork()
            break
        case .WWAN3G:
            appDelegate.reconnectedNetwork()
            break
        case .WWAN4G:
            appDelegate.reconnectedNetwork()
            break
        case .wiFi:
            appDelegate.reconnectedNetwork()
            break
        default:
            break
            
        }
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
            guard let result = data , error == nil  else {
                failure(error)
                return
                
            }
            succeed(result, nil)
            
        }
        task.resume()
        
    }
}
