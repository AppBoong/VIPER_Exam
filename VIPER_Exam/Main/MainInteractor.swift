//
//  MainInteractor.swift
//  VIPER_Exam
//
//  Created by 이재열 on 2023/11/16.
//

import Foundation
import RxSwift
import RxCocoa
import Moya
import RxMoya

protocol MainInteractorProtocol {
    func fetchRandomDog() -> Single<[Dog]>
    func fetchDogs(limit: Int) -> Single<[Dog]>
}

class MainInteractor: MainInteractorProtocol {
    var apiService: APIServiceProtocol
    
    init(apiService: APIServiceProtocol) {
        self.apiService = apiService
    }
    
    func fetchRandomDog() -> Single<[Dog]> {
        return apiService.DogProvider.rx.request(.getRandomDog)
            .filterSuccessfulStatusCodes()
            .map([Dog].self)
    }
    
    func fetchDogs(limit: Int) -> Single<[Dog]> {
        return apiService.DogProvider.rx.request(.getDogs(limit: limit))
            .filterSuccessfulStatusCodes()
            .map([Dog].self)
    }
}
