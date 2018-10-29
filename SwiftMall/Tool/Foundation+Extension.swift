//
//  Foundation+Extension.swift
//  SwiftMall
//
//  Created by LiuQingying on 2018/9/18.
//  Copyright © 2018年 JM. All rights reserved.
//

import Foundation
extension String {
    static func timeStamp() -> String {
        let date: NSDate = NSDate()
        let timeInterval: TimeInterval = date.timeIntervalSince1970
        let timeStamp = "\(timeInterval)"
        return timeStamp;
    }
    static func random8LengthString() -> String {
        let timeInterval: TimeInterval = NSDate.timeIntervalSinceReferenceDate
        let randomString: String = String.init(format: "%.8f", timeInterval)
        let random8LengthString: String = randomString.components(separatedBy: ".")[1]
        return random8LengthString;
    }
    static func stringWithDict(dict: Dictionary<String, Any>) -> String {
        let sortedArray: [String] = dict.keys.sorted { (str: String, str1: String) -> Bool in
            return str < str1
        }
        var str: String = "";
        for key in sortedArray {
            let value: String = dict[key] as! String
            str = str.appending(value);
        }
        return str
        
    }
    func md5() -> String {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CUnsignedInt(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<UInt8>.allocate(capacity: 16)
        CC_MD5(str!, strLen, result)
        let hash = NSMutableString()
        for i in 0 ..< digestLen {
            hash.appendFormat("%02x", result[i])
        }
        free(result)
        return String(format: hash as String)
    }
    static func requestTypeWithDict(dict: Dictionary<String, Any>) -> String {
        let sortedArray: [String] = dict.keys.sorted { (str: String, str1: String) -> Bool in
            return str < str1
        }
        var str = ""
        var i: Int = 0;
        for key in sortedArray {
            i = i+1
            let value: String = dict[key] as! String
            if(i==1){
                str = str.appending(String.init(format: "?%@=%@", key,value))

            }else{
               str = str.appending(String.init(format: "&%@=%@", key,value))
            }
        }
        return str
    }
   
}
