//
//  APIClient.swift
//  vcommerce
//
//  Created by JeongU Park on 2020/10/21.
//

import Foundation
import UIKit
import ObjectMapper
import Alamofire

enum MethodType: String {
    case GET
    case POST
    case PUT
    case DELETE
}


class APIClient : NSObject {
    
    private static var progressCount:Int = 0;
    public static var URL_BASE = "http://52.79.209.221:8880"
    
    public static var defaultFailure: ((Int) -> Bool)? = nil
    
    
    public static func showProgress() {
        progressCount = progressCount + 1;
        
        if (progressCount > 0) {
            
            //            LoadingProgress.show()
        }
    }
    
    public static func stopProgress() {
        progressCount = progressCount - 1;
        
        if (progressCount <= 0) {
            
            //            LoadingProgress.hide()
        }
    }
    #if DEBUG
    private static func getCurrentDateTime() -> String {
        let formatter = DateFormatter()
        //formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSSS"
        formatter.dateFormat = "HH:mm:ss.SSSS"
        
        return formatter.string(from: Date())
    }
    #endif
    
    private static func processFailure(statusCode:Int) {
        if (nil != defaultFailure && true == defaultFailure!(statusCode)) {
            return
        }
        
        let message:String = "통신 상태가 원활하지 않습니다\n잠시 후 다시 시도해주세요"
        print(message)
        
    }
    public static func send(request: APIBase.Request!, response: SearchDetailResponse.Type,success: ((SearchDetailResponse) -> Void)!,
                            failure: ((Int, SearchDetailResponse?)->Void)!){
        var url:String = request.methodURL()
        url = ((url.hasPrefix("http")) ? url : APIClient.URL_BASE + url)
        guard let dict = try? JSONSerialization.jsonObject(with: request.getJSONEncoderData(), options: []) as? [String: Any] else {
            return failure(0, nil)
        }
        let parameters = dict
        
        AF.request(url,method: .get, parameters: parameters,headers: request.headers()).responseJSON{ (response) in
            switch response.result{
            case .success(let value) :
                print(value)
                responseSuccess(response: response.response, responseObject : response.data, success : { (statusCode:Int, responseData: Data) in
                    do{
                        let responseResult = try JSONDecoder().decode( SearchDetailResponse.self, from: responseData)
                        if(responseResult.code != nil && responseResult.code != 0){
                            if let failure = failure {
                                failure(responseResult.code, responseResult)
                            }
                        }else{
                           success(responseResult);
                        }
                    }catch{
                        print("error: ",error)
                        if let failure = failure {
                            failure(0, nil);
                        }
                    }
                }, failure: {(statusCode) in
                    processFailure(statusCode: statusCode)
                    
                    if let failure = failure {
                        failure(0, nil);
                    }
                })
                break
                
            case .failure(let error) :
                print(error)
                responseFail(url : url , response : response.response, error : error, failure: {
                    (statusCode) in
                    processFailure(statusCode: statusCode)
                    
                    if let failure = failure {
                        failure(statusCode, nil);
                    }
                })
                break
                
            }
        }
    }
    public static func send(request: APIBase.Request!, response: SearchResponse.Type,success: ((SearchResponse) -> Void)!,
                            failure: ((Int, SearchResponse?)->Void)!){
        
        var url:String = request.methodURL()
        url = ((url.hasPrefix("http")) ? url : APIClient.URL_BASE + url)
        guard let dict = try? JSONSerialization.jsonObject(with: request.getJSONEncoderData(), options: []) as? [String: Any] else {
            return failure(0, nil)
        }
        let parameters = dict
        
        AF.request(url,method: .get, parameters: parameters,headers: request.headers()).responseJSON{ (response) in
            switch response.result{
            case .success(let value) :
                print(value)
                responseSuccess(response: response.response, responseObject : response.data, success : { (statusCode:Int, responseData: Data) in
                    do{
                        let responseResult = try JSONDecoder().decode( SearchResponse.self, from: responseData)
                        if(responseResult.code != nil && responseResult.code != 0){
                            if let failure = failure {
                                failure(responseResult.code, responseResult)
                            }
                        }else{
                           success(responseResult);
                        }
                    }catch{
                        print("error: ",error)
                        if let failure = failure {
                            failure(0, nil);
                        }
                    }
                }, failure: {(statusCode) in
                    processFailure(statusCode: statusCode)
                    
                    if let failure = failure {
                        failure(0, nil);
                    }
                })
                break
                
            case .failure(let error) :
                print(error)
                responseFail(url : url , response : response.response, error : error, failure: {
                    (statusCode) in
                    processFailure(statusCode: statusCode)
                    
                    if let failure = failure {
                        failure(statusCode, nil);
                    }
                })
                break
                
            }
        }
    }
    private static func responseSuccess(response : HTTPURLResponse?,responseObject : Any?, success: ((Int, Data) -> Void)?,  failure: ((Int)->Void)!) {

        
        if let response = response  {
            
            let absoluteString = response.url?.absoluteString ?? ""
            
            #if DEBUG
            print("=> onReceive <=: \(getCurrentDateTime()) \(absoluteString)")
            print("Header: \(response.allHeaderFields.toJSONString())")
            if let responseData = responseObject as? Data {
                print("Body: (\(responseData.textString.count)) \(responseData.textString)")
            }
            print("\n")
            #endif
            
            guard let responseData = responseObject as? Data else {
                processFailure(statusCode: response.statusCode)
                
                if let failure = failure {
                    failure(0);
                }
                return;
            }
            if let success = success {
                success(response.statusCode, responseData)
            }
        }else {
            print("response is nil")
        }
        
    }
    private static func responseFail(url : String, response : HTTPURLResponse?, error:  Error,failure: ((Int)->Void)?){
        if response == nil{
            processFailure(statusCode: 0)
            if let failure = failure {
                failure(0)
            }
            return
        }
        
        let error = error as NSError
        if (error.code == NSURLErrorNotConnectedToInternet) {
            processFailure(statusCode: 0)
            
            if let failure = failure {
                failure(0)
            }
            return
        }
        
        print("onErrorReceive: \(url) statusCode : \(String(describing: response!.statusCode)), errorCode : \(error.code)\n\n")
        
        let statusCode = response?.statusCode ?? error.code
        processFailure(statusCode: statusCode)
        
        if let failure = failure {
            failure(statusCode)
        }
    }
    
}
