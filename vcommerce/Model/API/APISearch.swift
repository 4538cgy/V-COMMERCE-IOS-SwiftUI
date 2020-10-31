//
//  APISearch.swift
//  vcommerce
//
//  Created by JeongU Park on 2020/10/21.
//

import Foundation
import ObjectMapper

class APISearch {
    class Request : APIBase.Request {
        public func send(success: ((Response) -> Void)!, failure: ((Int, Response?)->Void)! = nil) {
            APIClient.send(request: self, response: Response.self, success: success, failure: failure);
        }
        override func methods() -> [Any] {
            return [MethodType.GET, "/api/v1/search"]
        }
        
        required init?(map: Map) { super.init(map: map) }
        
        var uid:String! = ""
        
        init(uid: String!) {
            super.init()
            self.uid = uid
        }
        override func mapping(map: Map) {
            super.mapping(map: map)
            
            uid <- map["uid"]
            
        }
    }
    
    class Response: APIBase.Response {
        
        
        var uid : String!
        var items: [Items]!
        
        
        override func mapping(map: Map) {
            super.mapping(map: map)
            uid <- map["uid"]
            items <- map["items"]
        }
        
        class Items : Mappable{
            var pid : String!
            var status : Int!
            var thumbnail : String!
            var media : String!
            
            required init?(map: Map) {}
            
            func mapping(map: Map) {
                pid <- map["pid"]
                status <- map["status"]
                thumbnail <- map["thumbnail"]
                media <- map["media"]
            }
        }
    }
}
