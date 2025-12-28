//
//  MovieListViewModelTests.swift
//  learning-development-venturedive
//
//  Created by Moiz Ul Hasan on 28/12/2025.
//

import XCTest
import Combine
@testable import learning_development_venturedive

@MainActor
final class MovieListViewModelTests: XCTestCase {
    
    private func makeFilms() -> [Film] {
        [
            Film(
                id: "1",
                title: "Spirited Away",
                originalTitle: "千と千尋の神隠し",
                description: "Hakaru",
                director: "Hayao",
                producer: "Miyazaki",
                releaseDate: "1990",
                runningTime: "120",
                rtScore: "80",
                url: URL(string: "https://ghibliapi.vercel.app/films/1")!
            ),
            Film(
                id: "2",
                title: "Totoro",
                originalTitle: "となりのトトロ",
                description: "Nikasa",
                director: "Hayao Miyazaki",
                producer: "Miyazakl",
                releaseDate: "1992",
                runningTime: "120",
                rtScore: "82",
                url: URL(string: "https://ghibliapi.vercel.app/films/2")!
            ),
            Film(
                id: "3",
                title: "Ponyo",
                originalTitle: "崖の上のポニョ",
                description: "Yoshi",
                director: "Hayao Miyazaki",
                producer: "Miyazaoi",
                releaseDate: "1991",
                runningTime: "120",
                rtScore: "83",
                url: URL(string: "https://ghibliapi.vercel.app/films/3")!
            )
            
        ]
    }
    
    private func yieldMain() async {
        await MainActor.run {}
    }
    
    func test_load_success_transitions_and_sets_items_filtered() async {
        let films = makeFilms()
        let useCase = GetFilmsUseCaseStub(result: .success(films))
        let sut = MovieListViewModel(
            getFilms: useCase,
            scheduler: DispatchQueue.main.eraseToAnyScheduler(),
            debounce: .zero
        )
        
        XCTAssertEqual(sut.state, .idle)
        
        await sut.load()
        
        XCTAssertEqual(sut.state, .loaded)
        XCTAssertEqual(sut.items, films)
        XCTAssertEqual(sut.filtered, films)
    }
    
    func test_load_failure_transitions_to_error() async {
        enum E: Error { case boom }
        let useCase = GetFilmsUseCaseStub(result: .failure(E.boom))
        let sut = MovieListViewModel(
            getFilms: useCase,
            scheduler: DispatchQueue.main.eraseToAnyScheduler(),
            debounce: .zero
        )
        
        XCTAssertEqual(sut.state, .idle)
        
        await sut.load()
        
        if case .error(let message) = sut.state {
            XCTAssertFalse(message.isEmpty)
        } else {
            XCTFail("Expected error state")
        }
    }
    
    func test_filtering_correctness_empty_trim_caseInsensitive_and_fields() async {
        let films = makeFilms()
        let useCase = GetFilmsUseCaseStub(result: .success(films))
        let sut = MovieListViewModel(
            getFilms: useCase,
            scheduler: DispatchQueue.main.eraseToAnyScheduler(),
            debounce: .zero
        )
        
        await sut.load()
        
        sut.query = ""
        XCTAssertEqual(sut.filtered, films)
        
        sut.query = "  MIYAZAKI  "
        await yieldMain()
        XCTAssertEqual(sut.filtered.map { $0.id }, ["2", "3"])
        
        sut.query = "ponyo"
        await yieldMain()
        XCTAssertEqual(sut.filtered.map { $0.id }, ["3"])
        
        sut.query = "となりの"
        await yieldMain()
        XCTAssertEqual(sut.filtered.map { $0.id }, ["2"])
        
        sut.query = "unknown"
        await yieldMain()
        XCTAssertTrue(sut.filtered.isEmpty)
    }
}
