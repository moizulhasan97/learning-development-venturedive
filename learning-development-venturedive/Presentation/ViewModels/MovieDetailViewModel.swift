//
//  MovieDetailViewModel.swift
//  learning-development-venturedive
//
//  Created by Moiz Ul Hasan on 18/12/2025.
//


import Foundation
import Combine

enum LoadState<T>: Equatable where T: Equatable {
    case idle
    case loading
    case loaded(T)
    case failed(String)
}

@MainActor
final class MovieDetailViewModel: ObservableObject {
    @Published private(set) var filmState: LoadState<Film> = .idle
    @Published private(set) var castState: LoadState<[Person]> = .idle

    private let getFilmDetail: GetFilmDetailUseCase
    private let getPeople: GetPeopleUseCase

    init(getFilmDetail: GetFilmDetailUseCase, getPeople: GetPeopleUseCase) {
        self.getFilmDetail = getFilmDetail
        self.getPeople = getPeople
    }

    func load(id: String) {
        Task {
            await loadFilm(id: id)
        }
        Task {
            await loadCast(for: id)
        }
    }

    private func loadFilm(id: String) async {
        filmState = .loading
        do {
            let film = try await getFilmDetail.execute(id: id)
            filmState = .loaded(film)
        } catch {
            filmState = .failed(error.localizedDescription)
        }
    }

    private func loadCast(for id: String) async {
        castState = .loading
        do {
            let people = try await getPeople.execute()
            let filmURLString = "https://ghibliapi.vercel.app/films/\(id)"
            let filmURL = URL(string: filmURLString)
            let cast = people.filter { person in
                person.films.contains(where: { $0 == filmURL })
            }
            castState = .loaded(cast)
        } catch {
            castState = .failed(error.localizedDescription)
        }
    }
}
