//
//  RemoteFilmRepository.swift
//  learning-development-venturedive
//
//  Created by Moiz Ul Hasan on 18/12/2025.
//


import Foundation

public final class RemoteFilmRepository: FilmRepository {
    private let client = GhibliAPIClient()
    public init() {}

    public func fetchFilms() async throws -> [Film] {
        let data = try await client.get(path: "films")
        let dtos = try JSONDecoder().decode([FilmDTO].self, from: data)
        return dtos.map { $0.toDomain() }
    }

    public func fetchFilmDetail(id: String) async throws -> Film {
        let data = try await client.get(path: "films/\(id)")
        let dto = try JSONDecoder().decode(FilmDTO.self, from: data)
        return dto.toDomain()
    }
}
