//
//  DogResponse.swift
//  VIPER_Exam
//
//  Created by 이재열 on 2023/11/16.
//

import Foundation

struct Dog: Decodable {
    let id, url: String
    let width, height: Int
    let breeds: [Breed]
    
    struct Breed: Decodable {
        let id, name, temperament, origin, wikipedia_url: String
    }
}

