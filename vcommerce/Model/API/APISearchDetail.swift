//
//  APISearchDetail.swift
//  vcommerce
//
//  Created by JeongU Park on 2020/10/24.
//

import Foundation
import ObjectMapper

class APISearchDetail{
    class Request : APIBase.Request {
        public func send(success: ((Response) -> Void)!, failure: ((Int, Response?)->Void)! = nil) {
            APIClient.send(request: self, response: Response.self, success: success, failure: failure);
        }
        override func methods() -> [Any] {
            return [MethodType.GET, "/api/v1/search/detail"]
        }
        
        required init?(map: Map) { super.init(map: map) }
        
        var pid:String! = ""
        
        init(pid: String!) {
            super.init()
            self.pid = pid
        }
        override func mapping(map: Map) {
            super.mapping(map: map)
            
            pid <- map["pid"]
            
        }
    }
    
    class Response: APIBase.Response {
        
        
        var pid : String!
        var userInfo: UserInfo!
        var title : String!
        var body : String!
        var thumbnail: String!
        var media : String!
        var eval : Eval!
        
        
        override func mapping(map: Map) {
            super.mapping(map: map)
            pid <- map["pid"]
            userInfo <- map["items"]
            title <- map["title"]
            body <- map["body"]
            thumbnail <- map["thumbnail"]
            media <- map["media"]
            eval <- map["eval"]
        }
        
        class UserInfo : Mappable{
            var uid : String!
            var name : String!
            
            required init?(map: Map) {}
            
            func mapping(map: Map) {
                uid <- map["uid"]
                name <- map["name"]
            }
        }
        class Eval : Mappable {
            var like : Int!
            var dislike : Int!
            
            required init?(map: Map) {}
            
            func mapping(map: Map) {
                like <- map["like"]
                dislike <- map["dislike"]
            }
        }
    }
}
