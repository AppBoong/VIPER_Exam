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
    func fetchDogs() -> Single<[Dog]>
}

class MainInteractor: MainInteractorProtocol {
    var apiService: APIServiceProtocol
    
    init(apiService: APIServiceProtocol) {
        self.apiService = apiService
    }
    
    func fetchDogs() -> Single<[Dog]> {
        return apiService.DogProvider.rx.request(.getRandomDog)
            .filterSuccessfulStatusCodes()
            .map([Dog].self)
    }
}
