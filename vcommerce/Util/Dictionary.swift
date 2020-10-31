//
//  Dictionary.swift
//  vcommerce
//
//  Created by JeongU Park on 2020/10/23.
//

import Foundation

import UIKit

extension Dictionary {
    func toString(_ key : Key, def:String ) -> String {
        if self[key] != nil {
            let value : String! = (self[key] as! NSString) as String
            if value != nil {
                return value
            }
        }
        
        return def
    }
    
    func toJSONString(prettyPrint: Bool = false) -> String {
        let dictionary = self
        
        // if let data = JSONSerialization.data(withJSONObject: dictionary, options: JSONSerialization.WritingOptions.prettyPrinted)
        
        do {
            let options:JSONSerialization.WritingOptions = (false == prettyPrint) ? [] : JSONSerialization.WritingOptions.prettyPrinted
            
            let data = try JSONSerialization.data(withJSONObject: dictionary, options: options)

            return data.textString
        }
        catch {}
        
        return ""
            
    }
}
extension Data {
    var textString: String {
        guard let string = NSString(data: self, encoding: String.Encoding.utf8.rawValue) else {
            return ""
        }
        return "\(string)"
    }
    
}
extension String  {
    var length : Int {
        return self.count
    }
}
