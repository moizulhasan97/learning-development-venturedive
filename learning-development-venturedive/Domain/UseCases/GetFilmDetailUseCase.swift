//
//  GetFilmDetailUseCase.swift
//  learning-development-venturedive
//
//  Created by Moiz Ul Hasan on 18/12/2025.
//

import Foundation

public protocol GetFilmDetailUseCase {
    func execute(id: String) async throws -> Film
}

public struct DefaultGetFilmDetailUseCase: GetFilmDetailUseCase {
    private let repository: FilmRepository
    public init(repository: FilmRepository) { self.repository = repository }
    public func execute(id: String) async throws -> Film {
        try await repository.fetchFilmDetail(id: id)
    }
}
