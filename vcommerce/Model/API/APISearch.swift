//
//  APISearch.swift
//  vcommerce
//
//  Created by JeongU Park on 2020/10/21.
//

import Foundation
import ObjectMapper
import Alamofire

class APISearch {
    class Request : APIBase.Request {
        public func send(success: ((Response) -> Void)!, failure: ((Int, Response?)->Void)! = nil) {
            APIClient.send(request: self, response: Response.self, success: success, failure: failure);
        }
        override func methods() -> [Any] {
            return [MethodType.GET, "/api/v1/search"]
        }
        override func getJSONEncoderData() -> Data?{
            return try! JSONEncoder().encode(RequestParam(uid: self.uid))
        }
        struct RequestParam : Codable{
            let uid :String
        }
        var uid : String!
        init(uid: String!) {
            super.init()
            self.uid = uid
        }
        
    }
    
    
    class Response: APIBase.Response {
        
        struct SearchRP : Codable {
            let uid : String
            let items : [Items]!
        }
        var uid : String!
        var items: [Items]!
        
        
        class Items : Codable{
            var pid : String!
            var status : Int!
            var thumbnail : String!
            var media : String!
        }
    }
}
