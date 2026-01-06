//
//  FilmRepository.swift
//  learning-development-venturedive
//
//  Created by Moiz Ul Hasan on 18/12/2025.
//

import Foundation

public protocol FilmRepository {
    func fetchFilms() async throws -> [Film]
    func fetchFilmDetail(id: String) async throws -> Film
}
