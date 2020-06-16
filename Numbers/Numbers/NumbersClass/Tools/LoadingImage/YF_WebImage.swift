//
//  YF_WebImage.swift
//  Numbers
//
//  Created by yan feng on 2019/6/19.
//  Copyright © 2019 Yan feng. All rights reserved.
//
import UIKit

extension UIImageView {

    func YF_WebImage(url:String , defaultImage:String?){
        var YFImage:UIImage?
        if url.count == 0
        {
            return
        }
        if defaultImage != nil{
            self.image = UIImage(named: defaultImage!)
        }
        let data : NSData? = YF_WebImageChche.readCacheFromUrl(url: url)
        if data != nil {
            YFImage = UIImage(data: data! as Data)
            self.image = YFImage
        }else{
            DispatchQueue.global().async {
                let imageURL:NSURL = NSURL(string: url)!
                let data:NSData? = NSData(contentsOf: imageURL as URL)
                if data != nil{
                    YFImage = UIImage(data: data! as Data)
                    YF_WebImageChche.writeCacheToUrl(url: url, data: data!)
                    DispatchQueue.main.async {
                        self.image = YFImage
                    }
                }
            }
        }
    }
}
