//
//  GetFilmsUseCase.swift
//  learning-development-venturedive
//
//  Created by Moiz Ul Hasan on 18/12/2025.
//

import Foundation

public protocol GetFilmsUseCase {
    func execute() async throws -> [Film]
}

public struct DefaultGetFilmsUseCase: GetFilmsUseCase {
    private let repository: FilmRepository
    public init(repository: FilmRepository) { self.repository = repository }
    public func execute() async throws -> [Film] {
        try await repository.fetchFilms()
    }
}
