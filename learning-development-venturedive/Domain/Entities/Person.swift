//
//  Person.swift
//  learning-development-venturedive
//
//  Created by Moiz Ul Hasan on 18/12/2025.
//

import Foundation

public struct Person: Identifiable, Equatable, Sendable {
    public let id: String
    public let name: String
    public let gender: String?
    public let age: String?
    public let films: [URL]

    public init(id: String, name: String, gender: String?, age: String?, films: [URL]) {
        self.id = id
        self.name = name
        self.gender = gender
        self.age = age
        self.films = films
    }
}
