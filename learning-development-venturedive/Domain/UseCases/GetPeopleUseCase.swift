//
//  GetPeopleUseCase.swift
//  learning-development-venturedive
//
//  Created by Moiz Ul Hasan on 18/12/2025.
//

import Foundation

public protocol GetPeopleUseCase {
    func execute() async throws -> [Person]
}

public struct DefaultGetPeopleUseCase: GetPeopleUseCase {
    private let repository: PeopleRepository
    public init(repository: PeopleRepository) { self.repository = repository }
    public func execute() async throws -> [Person] {
        try await repository.fetchPeople()
    }
}
