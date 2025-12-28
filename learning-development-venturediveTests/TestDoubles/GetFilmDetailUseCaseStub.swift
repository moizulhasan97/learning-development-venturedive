//
//  GetFilmDetailUseCaseStub.swift
//  learning-development-venturedive
//
//  Created by Moiz Ul Hasan on 28/12/2025.
//

import Foundation
@testable import learning_development_venturedive

struct GetFilmDetailUseCaseStub: GetFilmDetailUseCase {
    var result: Result<Film, Error>

    func execute(id: String) async throws -> Film {
        switch result {
        case .success(let film): return film
        case .failure(let error): throw error
        }
    }
}
