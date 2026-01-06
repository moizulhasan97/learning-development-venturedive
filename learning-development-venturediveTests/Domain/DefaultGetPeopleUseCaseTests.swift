//
//  DefaultGetPeopleUseCaseTests.swift
//  learning-development-venturedive
//
//  Created by Moiz Ul Hasan on 28/12/2025.
//

import XCTest
@testable import learning_development_venturedive

final class DefaultGetPeopleUseCaseTests: XCTestCase {

    func test_execute_success_returnsPeople_and_callsRepositoryOnce() async throws {
        let spy = PeopleRepositorySpy()
        let expected: [Person] = [
            Person(
                id: "p1",
                name: "Chihiro",
                gender: "F",
                age: "10",
                films: [URL(string: "https://ghibliapi.vercel.app/films/1")!]
            )
        ]
        spy.peopleResult = .success(expected)

        let sut = DefaultGetPeopleUseCase(repository: spy)

        let people = try await sut.execute()

        XCTAssertEqual(people, expected)
        XCTAssertEqual(spy.fetchPeopleCallCount, 1)
    }

    func test_execute_failure_propagatesError() async {
        let spy = PeopleRepositorySpy()
        enum E: Error { case fail }
        spy.peopleResult = .failure(E.fail)

        let sut = DefaultGetPeopleUseCase(repository: spy)

        do {
            _ = try await sut.execute()
            XCTFail("Expected error")
        } catch {
            // ok
        }
        XCTAssertEqual(spy.fetchPeopleCallCount, 1)
    }
}

