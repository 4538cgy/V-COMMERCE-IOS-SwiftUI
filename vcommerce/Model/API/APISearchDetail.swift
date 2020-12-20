//
//  APISearchDetail.swift
//  vcommerce
//
//  Created by JeongU Park on 2020/10/24.
//

import Foundation
import Alamofire
class APISearchDetail{
    private var pid : String!
    init(pid : String) {
        self.pid = pid
    }
    public func send(success : @escaping (SearchDetailResponse)-> Void , fail : @escaping  (String) -> Void){
        let url = APIClient.URL_BASE + "/api/v1/search/detail?pid=\(self.pid ?? "")"
        AF.request(url, method: .get, parameters: nil,headers: ["Content-Type": "application/json"]).responseDecodable{
            (response :  DataResponse<SearchDetailResponse,AFError>) in
            
            switch response.result{
            case .success(let value) :
                print(value)
                if  value.code != nil &&  value.code != 200 {
                    fail(value.msg)
                }else {
                    success(value)
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
