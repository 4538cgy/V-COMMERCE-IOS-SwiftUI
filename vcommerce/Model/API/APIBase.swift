//
//  APIBase.swift
//  vcommerce
//
//  Created by JeongU Park on 2020/10/21.
//
import UIKit
import Foundation
import Alamofire
public class APIBase {
    class Request: NSObject{
        
        override init() {
        }
        func methods() -> [Any] {
            return [MethodType.GET, ""]
        }
        func methodType() -> MethodType {
            return self.methods()[0] as! MethodType
        }
        func timeoutInterval() -> Double {
            return 30
        }
        func methodURL() -> String {
            return self.methods()[1] as! String
        }
        func headers() -> HTTPHeaders {
            return ["Content-Type": self.contentType()]
        }
        func contentType() -> String {
            return "application/json"
        }
        func getJSONEncoderData() -> Data!{
            return nil
        }
    }
    
    class Response: NSObject {
        struct ResponsParam : Codable {
            let code : Int
            let msg : String
        }
        var code:Int = 0
        var msg:String! = ""
    
        
        func getErrorMessage() -> String! {
            
            if (nil == msg) {
                return nil
            }
            
            return msg
        }
        
        
        func isSuccess() -> Bool {
            
            if self.code != 0 { return false}
            
            return true
        }
        
       
    }
}

