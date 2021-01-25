//
//  NetworkManager.swift
//  GitHubRepositories-MVVM
//
//  Created by Wei Lun Hsu on 2021/1/24.
//

import Moya

enum NetworkManager {
    case searchRepos(keyword: String)
}

extension NetworkManager: TargetType {
    
    var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }
    
    var path: String {
        switch self {
        
        case .searchRepos(let keyword):
            print(baseURL.description + "/users/\(keyword)/repos")
            return "/users/\(keyword)/repos"
        }
    }
    
    var method: Method {
        return .get
    }
    
    var sampleData: Data {
        switch self {
        case .searchRepos(_):
            return "".data(using: String.Encoding.utf8)!
        }
    }
    
    var task: Task {
        switch self {
        case .searchRepos(_):
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .searchRepos(_):
            return [:]
        }
    }
}
