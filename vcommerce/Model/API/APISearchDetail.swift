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
        override func getJSONEncoderData() -> Data?{
            return try! JSONEncoder().encode(RequestParam(pid: self.pid))
        }
        struct RequestParam : Codable{
            let pid : String
        }
        var pid:String! = ""
        
        init(pid: String!) {
            super.init()
            self.pid = pid
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
        
        
        class UserInfo : Codable{
            var uid : String!
            var name : String!
        }
        class Eval : Codable {
            var like : Int!
            var dislike : Int!
        }
    }
}
