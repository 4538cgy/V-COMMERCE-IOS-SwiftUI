//
//  APISerarchTest.swift
//  vcommerce
//
//  Created by JeongU Park on 2020/12/20.
//

import Foundation
import Alamofire

class APISearch {
    private var uid : String!
    init(uid : String) {
        self.uid = uid
    }
    public func send(success : @escaping ([SearchResponse.Items])-> Void , fail : @escaping  (String) -> Void){
        let url = APIClient.URL_BASE + "/api/v1/search?uid=\(self.uid ?? "")"
        AF.request(url, method: .get, parameters: nil,headers: ["Content-Type": "application/json"]).responseDecodable{
            (response :  DataResponse<SearchResponse,AFError>) in
            
            switch response.result{
            case .success(let value) :
                print(value)
                
                if value.code != nil &&  value.code != 200 {
                    fail(value.msg)
                }else{
                    guard let response  = value.items else {
                        fail("no data")
                        return
                    }
                    success(response)
                }
                break
                
            case .failure(let error) :
                print(error)
                fail("Network Error")
                break
            }
        }
        
    }
}
