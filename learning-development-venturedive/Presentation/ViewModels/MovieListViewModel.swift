//
//  MovieListViewModel.swift
//  learning-development-venturedive
//
//  Created by Moiz Ul Hasan on 18/12/2025.
//


import Foundation
import Combine

@MainActor
final class MovieListViewModel: ObservableObject {
    @Published var query: String = ""
    @Published private(set) var state: State = .idle
    @Published private(set) var items: [Film] = []
    @Published private(set) var filtered: [Film] = []

    enum State: Equatable {
        case idle
        case loading
        case loaded
        case error(String)
    }

    private let getFilms: GetFilmsUseCase
    private var cancellables: Set<AnyCancellable> = []

    init(getFilms: GetFilmsUseCase) {
        self.getFilms = getFilms
        bindSearch()
    }

    func onAppear() {
        Task { await load() }
    }

    func load() async {
        state = .loading
        do {
            let films = try await getFilms.execute()
            self.items = films
            self.state = .loaded
            applyFilter()
        } catch {
            self.state = .error(error.localizedDescription)
        }
    }

    private func bindSearch() {
        $query
            .debounce(for: .milliseconds(400), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] _ in
                self?.applyFilter()
            }
            .store(in: &cancellables)
    }

    private func applyFilter() {
        let trimmed = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else {
            filtered = items
            return
        }
        let lower = trimmed.lowercased()
        filtered = items.filter { film in
            film.title.lowercased().contains(lower) ||
            film.originalTitle.lowercased().contains(lower) ||
            film.director.lowercased().contains(lower)
        }
    }
}
