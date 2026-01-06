//
//  RemotePeopleRepository.swift
//  learning-development-venturedive
//
//  Created by Moiz Ul Hasan on 18/12/2025.
//


import Foundation

public final class RemotePeopleRepository: PeopleRepository {
    private let client = GhibliAPIClient()
    public init() {}

    public func fetchPeople() async throws -> [Person] {
        let data = try await client.get(path: "people")
        let dtos = try JSONDecoder().decode([PersonDTO].self, from: data)
        return dtos.map { $0.toDomain() }
    }
}
