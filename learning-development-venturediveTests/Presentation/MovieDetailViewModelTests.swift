//
//  MovieDetailViewModelTests.swift
//  learning-development-venturedive
//
//  Created by Moiz Ul Hasan on 28/12/2025.
//

import XCTest
@testable import learning_development_venturedive

@MainActor
final class MovieDetailViewModelTests: XCTestCase {
    
    func makePeople(for filmIDs: [String]) -> [Person] {
        filmIDs.enumerated().map { idx, filmID in
            Person(
                id: "p\(idx)",
                name: "Person\(idx)",
                gender: "Male",
                age: "23",
                films: [
                    URL(string: "https://ghibliapi.vercel.app/films/\(filmID)")!
                ]
            )
        }
    }

    func test_film_success_transitions_to_loaded() async {
        let film = Film(
            id: "f1",
            title: "ABC",
            originalTitle: "DEF",
            description: "GHI",
            director: "Director",
            producer: "Producer",
            releaseDate: "",
            runningTime: "",
            rtScore: "",
            url: URL(string: "https://ghibliapi.vercel.app/films/f1")!
        )

        let filmUC = GetFilmDetailUseCaseStub(result: .success(film))
        let peopleUC = GetPeopleUseCaseStub(result: .success([]))
        let sut = MovieDetailViewModel(getFilmDetail: filmUC, getPeople: peopleUC)

        XCTAssertEqual(sut.filmState, .idle)

        await sut.load(id: "f1")

        XCTAssertEqual(sut.filmState, .loaded(film))
    }

    func test_film_failure_transitions_to_failed() async {
        enum E: Error { case fail }
        let filmUC = GetFilmDetailUseCaseStub(result: .failure(E.fail))
        let peopleUC = GetPeopleUseCaseStub(result: .success([]))
        let sut = MovieDetailViewModel(getFilmDetail: filmUC, getPeople: peopleUC)

        await sut.load(id: "f1")

        if case .failed(let message) = sut.filmState {
            XCTAssertFalse(message.isEmpty)
        } else {
            XCTFail("Expected failed film state")
        }
    }

    func test_cast_success_filters_people_by_film_id_url_and_transitions() async {
        let film = Film(
            id: "f2",
            title: "ABC",
            originalTitle: "DEF",
            description: "GHI",
            director: "Director",
            producer: "Producer",
            releaseDate: "",
            runningTime: "",
            rtScore: "",
            url: URL(string: "https://ghibliapi.vercel.app/films/f2")!
        )

        let filmUC = GetFilmDetailUseCaseStub(result: .success(film))

        let people = makePeople(for: ["f2", "f2", "other"])
        let peopleUC = GetPeopleUseCaseStub(result: .success(people))

        let sut = MovieDetailViewModel(getFilmDetail: filmUC, getPeople: peopleUC)

        XCTAssertEqual(sut.castState, .idle)

        await sut.load(id: "f2")

        if case .loaded(let cast) = sut.castState {
            XCTAssertEqual(cast.count, 2)
            XCTAssertTrue(
                cast.allSatisfy {
                    $0.films.contains(URL(string: "https://ghibliapi.vercel.app/films/f2")!)
                }
            )
        } else {
            XCTFail("Expected loaded cast state")
        }
    }

    func test_cast_failure_transitions_to_failed() async {
        let filmUC = GetFilmDetailUseCaseStub(
            result: .success(
                Film(
                    id: "4",
                    title: "My Totoro",
                    originalTitle: "となりの",
                    description: "story",
                    director: "Miyazaki",
                    producer: "Hara",
                    releaseDate: "1998",
                    runningTime: "80",
                    rtScore: "90",
                    url: URL(string: "https://ghibliapi.vercel.app/films/4")!
                )
            )
        )

        enum E: Error { case fail }
        let peopleUC = GetPeopleUseCaseStub(result: .failure(E.fail))

        let sut = MovieDetailViewModel(getFilmDetail: filmUC, getPeople: peopleUC)

        await sut.load(id: "f3")

        if case .failed(let message) = sut.castState {
            XCTAssertFalse(message.isEmpty)
        } else {
            XCTFail("Expected failed cast state")
        }
    }
}

