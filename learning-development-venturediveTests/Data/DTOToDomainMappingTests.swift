//
//  DTOToDomainMappingTests.swift
//  learning-development-venturedive
//
//  Created by Moiz Ul Hasan on 28/12/2025.
//


import XCTest
@testable import learning_development_venturedive

final class DTOToDomainMappingTests: XCTestCase {

    func test_FilmDTO_toDomain_mapsFields_andParsesURL() {
            let dto = FilmDTO(
                id: "1",
                title: "Spirited Away",
                original_title: "千と千尋の神隠し",
                description: "nature",
                director: "Hayao Miyazaki",
                producer: "Toshio Suzuki",
                release_date: "2001",
                running_time: "125",
                rt_score: "97",
                movie_banner: "https://example.com/banner.jpg",
                url: "https://ghibliapi.vercel.app/films/1"
            )

            let film = dto.toDomain()

            XCTAssertEqual(film.id, "1")
            XCTAssertEqual(film.title, "Spirited Away")
            XCTAssertEqual(film.originalTitle, "千と千尋の神隠し")
            XCTAssertEqual(film.description, "nature")
            XCTAssertEqual(film.director, "Hayao Miyazaki")
            XCTAssertEqual(film.producer, "Toshio Suzuki")
            XCTAssertEqual(film.releaseDate, "2001")
            XCTAssertEqual(film.runningTime, "125")
            XCTAssertEqual(film.rtScore, "97")
            XCTAssertEqual(
                film.url?.absoluteString,
                "https://ghibliapi.vercel.app/films/1"
            )
            XCTAssertEqual(film.movieBannerURL?.absoluteString, "https://example.com/banner.jpg")
        }

    func test_PersonDTO_toDomain_mapsFilmsToURLs() {
        let dto = PersonDTO(
            id: "p1",
            name: "Chihiro",
            gender: "Female",
            age: "10",
            films: [
                "https://ghibliapi.vercel.app/films/1",
                "https://ghibliapi.vercel.app/films/2"
            ]
        )

        let person = dto.toDomain()

        XCTAssertEqual(person.id, "p1")
        XCTAssertEqual(person.name, "Chihiro")
        XCTAssertEqual(person.gender, "Female")
        XCTAssertEqual(person.age, "10")
        XCTAssertEqual(
            person.films.map(\.absoluteString),
            [
                "https://ghibliapi.vercel.app/films/1",
                "https://ghibliapi.vercel.app/films/2"
            ]
        )
    }

    func test_FilmDTO_movieBanner_invalid_or_nil_mapsToNil() {
        let dto1 = FilmDTO(
            id: "1", title: "A", original_title: "B", description: "C", director: "D", producer: "E", release_date: "2000", running_time: "100", rt_score: "90", movie_banner: nil, url: nil
        )
        XCTAssertNil(dto1.toDomain().movieBannerURL)

        let dto2 = FilmDTO(
            id: "2", title: "A", original_title: "B", description: "C", director: "D", producer: "E", release_date: "2000", running_time: "100", rt_score: "90", movie_banner: "", url: nil
        )
        XCTAssertNil(dto2.toDomain().movieBannerURL)
    }
}

