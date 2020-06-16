//
//  YF_WebImageChche.swift
//  Numbers
//
//  Created by yan feng on 2019/6/19.
//  Copyright © 2019 Yan feng. All rights reserved.
//
import UIKit


class YF_WebImageChche: NSObject {

    static let fileManager:FileManager = FileManager.default
    class func readCacheFromUrl(url:String) -> NSData?{
        var data : NSData?
        let path : String = YF_WebImageChche.getFullCachePathFromUrl(url: url)
        if FileManager.default.fileExists(atPath: path){
            data = NSData(contentsOfFile: path)
        }
        return data
    }
    class func writeCacheToUrl(url:String, data:NSData){
        let path:String = YF_WebImageChche.getFullCachePathFromUrl(url: url)
        data.write(toFile: path, atomically: true)
    }
    // Setting Cache Path
    class func getFullCachePathFromUrl(url:String)->String{
        var chchePath = NSHomeDirectory().appendingFormat("/Library/Caches/Nike_Cache")
        fileManager.fileExists(atPath: chchePath)
        if !(fileManager.fileExists(atPath: chchePath)) {
            do {
                try fileManager.createDirectory(atPath: chchePath, withIntermediateDirectories: true, attributes: nil)
            } catch let error as NSError {
                print("Unable to create directory \(error.debugDescription)")
            }
        }
        //String processing
        var newURL:String
        newURL = YF_WebImageChche.stringToYFString(str: url)
        chchePath = chchePath.appendingFormat("/%@", newURL)
//        print(newURL)
        return chchePath
    }
    // Delete Cache
    class func removeAllCache(){
        let chchePath = NSHomeDirectory().appendingFormat("/Library/Caches/Nike_Cache")
//        chchePath = NSHomeDirectory().appendingFormat("/Library/Caches/Nike_Cache")
        let fileManager:FileManager = FileManager.default
        if fileManager.fileExists(atPath: chchePath) {
            do{
                try fileManager.removeItem(atPath: chchePath)
            }catch let error as NSError{
                print("Unable to delete directory \(error.debugDescription)")
            }
        }
        
    }
    class func stringToYFString(str:String)->String{
        let newStr:NSMutableString = NSMutableString()
        for i:Int in 0..<str.count{
            let c:unichar = (str as NSString).character(at: i)
            if (c >= 48 && c <= 57) || (c >= 65 && c <= 90) || (c >= 97 && c <= 122){
                newStr.appendFormat("%c", c)
            }
        }
        return newStr.copy() as! String
        
    }
}
