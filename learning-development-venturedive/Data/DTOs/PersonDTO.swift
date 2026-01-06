//
//  PersonDTO.swift
//  learning-development-venturedive
//
//  Created by Moiz Ul Hasan on 18/12/2025.
//

import Foundation

struct PersonDTO: Decodable {
    let id: String
    let name: String
    let gender: String?
    let age: String?
    let films: [String]
}

extension PersonDTO {
    func toDomain() -> Person {
        Person(
            id: id,
            name: name,
            gender: gender,
            age: age,
            films: films.compactMap(URL.init(string:))
        )
    }
}
