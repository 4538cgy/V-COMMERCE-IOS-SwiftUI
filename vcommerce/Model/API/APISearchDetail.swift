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
        public func send(success: ((SearchDetailResponse) -> Void)!, failure: ((Int, SearchDetailResponse?)->Void)! = nil) {
            APIClient.send(request: self, response: SearchDetailResponse.self, success: success, failure: failure);
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
    

}
