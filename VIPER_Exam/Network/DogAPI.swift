//
//  DogAPI.swift
//  VIPER_Exam
//
//  Created by 이재열 on 2023/11/16.
//

import Foundation
import Moya

enum DogAPI {
    case getRandomDog
    case getDogs(limit: Int)
}

extension DogAPI: TargetType {
    var baseURL: URL {
        URL(string: "https://api.thedogapi.com/v1/images")!
    }
    
    var path: String {
        switch self {
        case .getRandomDog:
            return "/search"
        case .getDogs:
            return "/search"
        }
    }
    
    var method: Moya.Method {
        .get
    }
    
    var task: Moya.Task {
        switch self {
        case .getRandomDog:
            return .requestPlain
        case .getDogs(let limit):
            return .requestParameters(parameters: ["limit" : limit], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        ["x-api-key" : "live_s7eoXbWR7Qt3K9eH8q4yHWC2uz3vR00vzfsUSKDcYwLDWwiSUyqeCfTJLkXDsGja"]
    }
    
    
}
