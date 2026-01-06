//
//  GetPeopleUseCaseStub.swift
//  learning-development-venturedive
//
//  Created by Moiz Ul Hasan on 28/12/2025.
//

import Foundation
@testable import learning_development_venturedive

struct GetPeopleUseCaseStub: GetPeopleUseCase {
    var result: Result<[Person], Error>

    func execute() async throws -> [Person] {
        switch result {
        case .success(let people): return people
        case .failure(let error): throw error
        }
    }
}
