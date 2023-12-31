//
//  MainPresenter.swift
//  VIPER_Exam
//
//  Created by 이재열 on 2023/11/16.
//

import Foundation
import RxSwift
import RxCocoa

protocol MainPresenterInput {
    func showRandomDog()
    func showDogs(limit: Int)
    func showDogDetail()
}

protocol MainPresenterOutput {
    var dogs: BehaviorRelay<[Dog]> { get }
}

protocol MainPresenterProtocol {
    var input: MainPresenterInput { get }
    var output: MainPresenterOutput { get }
    var interactor: MainInteractorProtocol { get }
}

class MainPresenter: MainPresenterProtocol, MainPresenterInput, MainPresenterOutput {
    var input: MainPresenterInput { return self }
     
    var output: MainPresenterOutput { return self }
    
    var dogs = BehaviorRelay<[Dog]>(value: [])
    
    let interactor: MainInteractorProtocol
    
    var fetchData: Disposable?
    
    init(interactor: MainInteractorProtocol) {
        self.interactor = interactor
    }
    
    func showRandomDog() {
        fetchData = interactor.fetchRandomDog()
            .subscribe { [weak self] response in
                guard let self else { return }
                self.dogs.accept(response)
            } onFailure: { error in
                print("fetchError:", error)
            }
        
        fetchData = nil
    }
    
    func showDogs(limit: Int) {
        fetchData = interactor.fetchDogs(limit: limit)
            .subscribe { [weak self] response in
                guard let self else { return }
                self.dogs.accept(response)
            } onFailure: { error in
                print("fetchError:", error)
            }
        
        fetchData = nil
    }
    
    func showDogDetail() {
    }
}
