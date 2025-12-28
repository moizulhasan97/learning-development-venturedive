//
//  DefaultGetFilmDetailUseCaseTests.swift
//  learning-development-venturedive
//
//  Created by Moiz Ul Hasan on 28/12/2025.
//

import XCTest
@testable import learning_development_venturedive

final class DefaultGetFilmDetailUseCaseTests: XCTestCase {

    func test_execute_success_returnsFilm_and_passesCorrectID() async throws {
        let spy = FilmRepositorySpy()
        
        let expected = Film(
            id: "42",
            title: "My Neighbor Totoro",
            originalTitle: "となりのトトロ",
            description: "some story",
            director: "Hayao Miyazaki",
            producer: "Toru Hara",
            releaseDate: "1988",
            runningTime: "86",
            rtScore: "95",
            url: URL(string: "https://ghibliapi.vercel.app/films/42")!
        )
        spy.filmDetailResult = .success(expected)

        let sut = DefaultGetFilmDetailUseCase(repository: spy)

        let film = try await sut.execute(id: "42")

        XCTAssertEqual(film, expected)
        XCTAssertEqual(spy.fetchFilmDetailReceivedID, "42")
    }

    func test_execute_failure_propagatesError() async {
        let spy = FilmRepositorySpy()
        enum E: Error { case nope }
        spy.filmDetailResult = .failure(E.nope)
        let sut = DefaultGetFilmDetailUseCase(repository: spy)

        do {
            _ = try await sut.execute(id: "x")
            XCTFail("Expected error")
        } catch {
            // ok
        }
        XCTAssertEqual(spy.fetchFilmDetailReceivedID, "x")
    }
}
