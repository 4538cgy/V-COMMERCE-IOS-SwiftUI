//
//  ResponseCodable.swift
//  vcommerce
//
//  Created by JeongU Park on 2020/11/18.
//

import Foundation

struct SearchResponse: Codable{
    
    var code : Int!
    var msg : String!
    var uid : String!
    var items : [Items]!
    
    struct Items : Codable{
        var pid : String!
        var status : Int!
        var thumbnail : String!
        var media : String!
    }
}

struct SearchDetailResponse: Codable {
    var code : Int!
    var msg : String!
    
    var pid : String!
    var userInfo: UserInfo!
    var title : String!
    var body : String!
    var thumbnail: String!
    var media : String!
    var eval : Eval!
    
    
    struct UserInfo : Codable{
        var uid : String!
        var name : String!
    }
    struct Eval : Codable {
        var like : Int!
        var dislike : Int!
    }
}
