//
//  PeopleRepositorySpy.swift
//  learning-development-venturedive
//
//  Created by Moiz Ul Hasan on 28/12/2025.
//

import Foundation
@testable import learning_development_venturedive

final class PeopleRepositorySpy: PeopleRepository {
    private(set) var fetchPeopleCallCount = 0
    var peopleResult: Result<[Person], Error> = .success([])

    func fetchPeople() async throws -> [Person] {
        fetchPeopleCallCount += 1
        switch peopleResult {
        case .success(let people): return people
        case .failure(let error): throw error
        }
    }
}
