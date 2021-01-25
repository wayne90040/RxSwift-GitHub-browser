//
//  DataModel.swift
//  GitHubRepositories-MVVM
//
//  Created by Wei Lun Hsu on 2021/1/24.
//

import ObjectMapper
import RxDataSources

struct Owner: Mappable {
    
    var name: String!
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        name <- map["login"]
    }
}

struct GitRepo: Mappable {

    var owner: Owner!
    var name: String!
    var isPrivate: Bool!
    var url: String!
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        owner <- map["owner"]
        name <- map["name"]
        isPrivate <- map["private"]
        url <- map["url"]
    }
}

