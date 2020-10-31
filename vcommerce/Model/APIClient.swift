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
    
    public static func send<T: APIBase.Response>(request: APIBase.Request!, mediaData : Data? = nil, response: T.Type,
                                                 success: ((T) -> Void)!,
                                                 failure: ((Int, T?)->Void)!
    ) {
        
        send(request: request, mediaData: mediaData, success: { (statusCode:Int, responseData: Data) in
            
            //print("\(responseData.textString)")
            
            let jsonObject = try? JSONSerialization.jsonObject(with: responseData, options: JSONSerialization.ReadingOptions.allowFragments)
            
            if (nil == jsonObject) {
                processFailure(statusCode: statusCode)
                return;
            }
            
            if let data = Mapper<T>().map(JSONObject: jsonObject) {
                #if DEBUG
                print("onProcess: \(data)\n\(data.toJSONString(prettyPrint: true) ?? "")\n")
                #endif
                
                if (true == data.isSuccess()) {
                    if let success = success {
                        success(data);
                    }
                }
                else {
                    
                    if let failure = failure {
                        failure(data.code, data)
                    }
                    
                }
            }
            else {
                processFailure(statusCode: statusCode)
                
                if let failure = failure {
                    failure(0, nil);
                }
            }
            
        }, failure: { (statusCode: Int) in
            
            processFailure(statusCode: statusCode)
            
            if let failure = failure {
                failure(statusCode, nil);
            }
            
        })
        
    }
    
    public static func send(request: APIBase.Request!, mediaData : Data? = nil,
                            success: ((Int, Data) -> Void)!,
                            failure: ((Int)->Void)!
    ) {
        showProgress()
        
        var url:String = request.methodURL()
        url = ((url.hasPrefix("http")) ? url : APIClient.URL_BASE + url)
        
        let parameters = request.toJSON() as Parameters
        send(url: url, headers: request.headers(), parameters: parameters,mediaData : mediaData,  methodString: request.methodType().rawValue, contentType: request.contentType(),  timeoutInterval: request.timeoutInterval(), success: {
            (response, responseObject) in
            
            stopProgress()
            
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
        }, failure: { (response, error) in
            
            stopProgress()
            
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
            
        })
    }
    
    public static func send(url: String, headers: HTTPHeaders, parameters: Parameters,mediaData:Data? = nil,
                            methodString: String, contentType: String = "application/json", timeoutInterval: Double = 30,
                            success: ((HTTPURLResponse, Any?) -> Void)?,
                            failure: ((HTTPURLResponse?, Error) -> Void)?
    ) {
        
        // 디버그시 로그 뽑기 위한 부분
        
        #if DEBUG
        print("=> onSend <=: \(getCurrentDateTime()) \(url)")
        print("Body: (\(parameters.toJSONString().count)) \(parameters.toJSONString(prettyPrint: true))")
        print("\n")
        #endif
        
        let success: ((HTTPURLResponse?, Any?) -> Void)? = {
            (response, responseObject) in
            
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
                
                if let success = success {
                    success(response, responseObject)
                }
            }else {
                print("response is nil")
            }
        }
        
        
        let failure: ((HTTPURLResponse?, Error) -> Void)? = {
            (response, error) in
            
            if let failure = failure {
                
                failure(response, error)
            }
            
        }
        if methodString == MethodType.GET.rawValue {
            AF.request(url,method: .get, parameters: parameters,headers: headers).responseJSON{ (response) in
                switch response.result{
                case .success(let value) :
                    print(value)
                    success!(response.response, response.data)
                    break
                    
                case .failure(let error) :
                    print(error)
                    failure!(response.response, error)
                    break
                    
                }
            }
            
        }else if methodString == MethodType.POST.rawValue{
            AF.upload(multipartFormData: { (multipartFormData) in
                multipartFormData.append(mediaData!, withName: "media")
                multipartFormData.append(Data(parameters.toJSONString(prettyPrint: true).utf8), withName: "meta")
            }, to: url).responseJSON{ (response) in
                
                switch response.result {
                case .success(let value) :
                    print("success \(value)")
                    success!(response.response, response.data)
                    break
                    
                case .failure(let error) :
                    print("failure \(error)")
                    failure!(response.response, error)
                    break
                    
                }
                
            }
            
        }else {
        }
    }
}
