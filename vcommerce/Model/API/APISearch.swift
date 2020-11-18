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
        public func send(success: ((SearchResponse) -> Void)!, failure: ((Int, SearchResponse?)->Void)! = nil) {
            APIClient.send(request: self, response: SearchResponse.self, success: success, failure: failure);
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
  
}
