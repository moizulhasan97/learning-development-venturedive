//
//  FilmRepositorySpy.swift
//  learning-development-venturedive
//
//  Created by Moiz Ul Hasan on 28/12/2025.
//

import Foundation
@testable import learning_development_venturedive

final class FilmRepositorySpy: FilmRepository {
    private(set) var fetchFilmsCallCount = 0
    private(set) var fetchFilmDetailReceivedID: String?
    var filmsResult: Result<[Film], Error> = .success([])
    var filmDetailResult: Result<Film, Error> = .failure(NSError(domain: "unset", code: -1))

    func fetchFilms() async throws -> [Film] {
        fetchFilmsCallCount += 1
        switch filmsResult {
        case .success(let films): return films
        case .failure(let error): throw error
        }
    }

    func fetchFilmDetail(id: String) async throws -> Film {
        fetchFilmDetailReceivedID = id
        switch filmDetailResult {
        case .success(let film): return film
        case .failure(let error): throw error
        }
    }
}
