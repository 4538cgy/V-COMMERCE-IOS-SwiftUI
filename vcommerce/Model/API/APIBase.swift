//
//  APIBase.swift
//  vcommerce
//
//  Created by JeongU Park on 2020/10/21.
//
import UIKit
import ObjectMapper
import Foundation
import Alamofire

public class APIBase {
    class Request: NSObject, Mappable {
        
        
        override init() {
        }
        // Mappable protocol
        required init?(map: Map) {
        }
        func mapping(map: Map) {
        }
        func methods() -> [Any] {
            return [MethodType.GET, ""]
        }
        func methodType() -> MethodType {
            return self.methods()[0] as! MethodType
        }
        func methodTypeString() -> String {
            return methodType().rawValue
        }
        
        func methodURL() -> String {
            return self.methods()[1] as! String
        }
        
        func multiparts() -> [String: String]! {
            return nil
        }
        func headers() -> HTTPHeaders {
            return ["Content-Type": self.contentType()]
        }
        func contentType() -> String {
            return "application/json"
        }
        func timeoutInterval() -> Double {
            return 30
        }
        public func toJSON() -> [String: Any] {
            let mappable = self as Mappable
            
            return mappable.toJSON()
        }
        public func getMappable() -> Mappable {
            return self as Mappable
        }
        
    }
    
    class Response: NSObject, Mappable {
        
        var code:Int = 0
        var msg:String! = ""
        required init?(map: Map) {}
        func mapping(map: Map) {
            code <- map["code"]
            msg <- map["msg"]
        }
        
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
        
        public func mapping(JSON: [String: Any]) {
            let map = Map(mappingType: .fromJSON, JSON: JSON)
            self.mapping(map: map)
        }
        
        public func toJSON() -> [String: Any] {
            let mappable = self as Mappable
            
            return mappable.toJSON()
        }
    }
}

