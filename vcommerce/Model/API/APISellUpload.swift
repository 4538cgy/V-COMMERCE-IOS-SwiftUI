//
//  APISellUpload.swift
//  vcommerce
//
//  Created by JeongU Park on 2020/10/24.
//

import Foundation
import ObjectMapper

class APISellUpload{
    
    class Request : APIBase.Request {
        public func send(success: ((Response) -> Void)!, failure: ((Int, Response?)->Void)! = nil) {
            APIClient.send(request: self,mediaData: self.media, response: Response.self, success: success, failure: failure);
        }
        override func methods() -> [Any] {
            return [MethodType.POST, "/api/v1/sell/upload"]
        }
        
        var meta: Meta!
        var media : Data!
        init(meta: Meta!,media : Data) {
            super.init()
            self.meta = meta
            self.media = media
        }
        
        required init(from decoder: Decoder) throws {
            fatalError("init(from:) has not been implemented")
        }
        
        override func contentType() -> String {
            return "multipart/form-data"
        }
        

        class Meta  {
            var token : String!
            var uid : String!
            var title : String!
            var body : String!
            var category : [String]!
            init(token:String, uid:String, title:String,body:String , category : [String]!) {
                self.token = token
                self.uid = uid
                self.title = title
                self.body = body
                self.category = category
            }
        }
    }
    class Response : APIBase.Response {
        
    }
    
    
}
