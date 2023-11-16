//
//  APIService.swift
//  VIPER_Exam
//
//  Created by 이재열 on 2023/11/16.
//

import Foundation
import Moya

protocol APIServiceProtocol {
    var DogProvider: MoyaProvider<DogAPI> { get }
}

class APIService: APIServiceProtocol {
    var DogProvider: MoyaProvider<DogAPI>
    
    init(DogProvider: MoyaProvider<DogAPI>) {
        self.DogProvider = DogProvider
    }
}
