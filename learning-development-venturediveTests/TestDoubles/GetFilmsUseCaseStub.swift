//
//  GetFilmsUseCaseStub.swift
//  learning-development-venturedive
//
//  Created by Moiz Ul Hasan on 28/12/2025.
//

import Foundation
@testable import learning_development_venturedive

struct GetFilmsUseCaseStub: GetFilmsUseCase {
    var result: Result<[Film], Error>

    func execute() async throws -> [Film] {
        switch result {
        case .success(let films): return films
        case .failure(let error): throw error
        }
    }
}
