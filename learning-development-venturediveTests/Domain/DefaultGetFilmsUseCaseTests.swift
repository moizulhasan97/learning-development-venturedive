//
//  DefaultGetFilmsUseCaseTests.swift
//  learning-development-venturedive
//
//  Created by Moiz Ul Hasan on 28/12/2025.
//

import XCTest
@testable import learning_development_venturedive

final class DefaultGetFilmsUseCaseTests: XCTestCase {

    func test_execute_success_returnsFilms_and_callsRepositoryOnce() async throws {
        let spy = FilmRepositorySpy()
        let expected = [
            Film(
                id: "1",
                title: "Spirited Away",
                originalTitle: "千と千尋の神隠し",
                description: "", director: "Hayao Miyazaki",
                producer: "Toshio Suzuki",
                releaseDate: "2001",
                runningTime: "125",
                rtScore: "97",
                movieBannerURL: nil,
                url: .init(string: "https://ghibliapi.vercel.app/films/1")!
            )
        ]
        spy.filmsResult = .success(expected)

        let sut = DefaultGetFilmsUseCase(repository: spy)

        let films = try await sut.execute()

        XCTAssertEqual(films, expected)
        XCTAssertEqual(spy.fetchFilmsCallCount, 1)
    }

    func test_execute_failure_propagatesError() async {
        let spy = FilmRepositorySpy()
        enum E: Error { case boom }
        spy.filmsResult = .failure(E.boom)
        let sut = DefaultGetFilmsUseCase(repository: spy)

        do {
            _ = try await sut.execute()
            XCTFail("Expected error")
        } catch {
            // ok
        }
        XCTAssertEqual(spy.fetchFilmsCallCount, 1)
    }
}

