//
//  PeopleRepository.swift
//  learning-development-venturedive
//
//  Created by Moiz Ul Hasan on 18/12/2025.
//

import Foundation

public protocol PeopleRepository {
    func fetchPeople() async throws -> [Person]
}
